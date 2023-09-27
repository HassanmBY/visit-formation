<?php

include ("config.php");
include ("headers.php");

$method = $_SERVER["REQUEST_METHOD"];

$route = isset($_GET['route']) ? $_GET['route'] : "";

if ($route == ""){
    $resp['message'] = "No Route";
    $resp['code'] = "You didn't enter any route";
    http_response_code(404);
    echo json_encode($resp);
    die();
}

$allowedRoutes = ["client", "formations", "historique_visites", "personnel", "sessions", "stagiaires_sessions", "visiteurs", "visiteur_personnel_info", "visiteur_session_info"];

if (!in_array($route, $allowedRoutes)){
    $resp['message'] = "Bad Request";
    $resp['code'] = "The route provided is not only not found but also wrongly formatted or in some way incorrect";
    http_response_code(400);
    echo json_encode($resp);
    die();
}

if ($route == "client"){
    $resp['message'] = "This is the client route, it's used to display the client interface";
    $res['code'] = "Client route shown";
    http_response_code(200);
    echo json_encode($resp);
    die();
}

if ($method == "GET") {
    $sql = "SELECT * FROM $route"; // Return everything from route
    $args = [];
    $firstArg = true;
    $jsonData = isset($_GET['data']) ? $_GET['data'] : '{}';
    $data = json_decode($jsonData, true);

    // Filter what to return from table
    $matchTypes = ["matches", "starts", "contains", "ends"];

    if ($route == "sessions" and isset($data['search']['id_formation'])) {
        $data = $data['search'];
        $sql = "SELECT * FROM sessions WHERE id_formation = :id_formation AND :date_today BETWEEN date_debut AND date_fin";
        $args['id_formation'] = $data['id_formation'];
        $args['date_today'] = $data['now'];

    } elseif ($route == 'historique_visites' and isset($data['search']['date_entree']) and isset($data['search']['id_visiteur'])) {
        $data = $data['search'];
        if (isset($data['operator'])) {
            $operator = $data['operator'];
            unset($data['operator']);
        } else {
            $operator = "AND";
        }

        if (isset($data['type'])) {
            $type = $data['type'];
            unset($data['type']);
        } else {
            $type = "matches";
        }

        $sql = "SELECT * FROM $route WHERE id_visiteur = :id_visiteur AND date_entree LIKE :date_entree";
        $args['id_visiteur'] = $data['id_visiteur'];
        $args['date_entree'] = $data['date_entree'].'%';

    } elseif (isset($data['search'])) {
        $data = $data['search'];
        if (isset($data['operator'])) {
            $operator = $data['operator'];
            unset($data['operator']);
        } else {
            $operator = "AND";
        }

        if (isset($data['type'])){
            $type = $data['type'];
            unset($data['type']);
        } else {
            $type = "matches";
        }

        foreach ($data as $field => $value) {
            $firstArg == true ?
                $sql .= " WHERE $field LIKE :$field"
                :
                $sql .= " $operator $field LIKE :$field";

            if (!in_array($type, $matchTypes)) {
                $resp['message'] = 'Type must be "matches", "starts", "contains" or "ends"';
                $resp['code'] = "Wrong matching type";
                http_response_code(400);
                echo json_encode($resp);
                die();
            } else {
                if($type == "matches"){
                    $args[$field] = $value;
                } elseif ($type == "starts") {
                    $args[$field] = $value . "%";
                } elseif ($type == "contains") {
                    $args[$field] = "%" . $value . "%";
                } elseif ($type == "ends") {
                    $args[$field] = "%" . $value;
                }
            }
            $firstArg = false;
        }
    } 

    // var_dump($sql);
    $req = $conn->prepare($sql);
    $req->execute($args);

    $nbhits = $req->rowCount();
    $content = $req->fetchAll();

    if ($content > 0) {
        $resp['content'] = $content;
        $resp['message'] = "List of $route";
        $resp["code"] = 'Ok';
        $resp['nbhits'] = $nbhits;
    } else {
        $resp['message'] = "No response";
        $resp['code'] = "No entry associated with your request";
    }
}

if ($method == "POST"){
    $data = json_decode(file_get_contents('php://input'), true);
    $sql = "INSERT INTO $route SET ";
    $args = [];
    $i = 0;
    if ($route != "stagiaires_sessions"){
        foreach ($data as $field => $value) {
            if ($i <= count($data) - 1) {
                $sql .= "$field = :$field,";
                $args[$field] = $value;
            }
            $i++;
        }
        $sql = rtrim($sql, ",");
    } elseif($data['object_visite'] == "formations") {
        $sql = "INSERT INTO stagiaires_sessions (id_session, id_visiteur) VALUES (:id_session, :id_visiteur)";
        $args['id_session'] = $data['id_session']; 
        $args['id_visiteur'] = $data['id_visiteur'];
    }
    
    
    $resp['query'] = $sql;
    $req = $conn->prepare($sql);
    $req->execute($args);
    
    $id = $conn->lastInsertId();
    $nb_hits = $req->rowCount();
    

    if ($nb_hits > 0) {
        $resp['message'] = "$route.id=>$id added";
        $resp['code'] = "Ok";
        $resp['nbhits'] = $nb_hits;
    } else {
        $resp['message'] = "No row was added due to an error in your request or on the server";
        $resp['code'] = "No entry added";
        // $resp['infos'] = var_dump($req);
        http_response_code(500);
    }
}

if ($method == "PUT"){
    $data = json_decode(file_get_contents("php://input"), true);
    $routeIDName = rtrim($route, "s");
    if ($route == "historique_visites") $routeIDName = "visite";
    $args = [];
    $i = 0;
    if (!isset($data['id'])){
        $resp['message'] = "An ID is needed to proceed to a PUT request";
        $resp['code'] = "No ID given";
        http_response_code(400);
        die();
    }


    $args["id_$routeIDName"] = $data['id'];
    $id = $args["id_$routeIDName"];
    unset($data['id']);
    
    
    $sql = "UPDATE $route SET ";

    $resp['passThrough'] = 0;

    foreach ($data as $field => $value){
        $resp['passThrough'] = $resp['passThrough']+1;
        if ($i <= count($data)-1){
            $sql .= "$field = :$field,";
            $args[$field] = $value;
        }
        $i++;
    }

    $sql = rtrim($sql, ",");

    $sql .= " WHERE id_$routeIDName = :id_$routeIDName";

    $req = $conn->prepare($sql);
    $req->execute($args);

    $nb_hits = $req->rowCount();

    if ($nb_hits > 0){
        $resp['message'] ="$route.id=>$id modified";
        $resp['code'] = "Row updated";
        $resp['nbhits'] = $nb_hits;
        $resp['id'] = $id;
    } else {
        $resp['message'] = "No row was affected due to an error in your request or on the server";
        $resp['code'] = "No entry affected";
        http_response_code(500);
    }
}

if ($method == "DELETE"){
    $data = json_decode(file_get_contents("php://input"), true);
    $args = [];
    $i = 0;
    $routeIDName = rtrim($route, "s");
    $data = array_values($data['delete']);


    $sql = "DELETE FROM $route WHERE id_$routeIDName IN (";

    foreach ($data as $value){
        if($i<= count($data)-1){
            $sql .= ":id$i, ";
            $args["id$i"] = intval($value);
        }
        $i++;
    }

    $sql = rtrim($sql, ", ");
    $sql .= ")";

    if (count($data) == 0){
        $resp['message'] = "No ID to delete was specified";
        $resp['code'] = "No ID given";
        http_response_code(400);
        die();
    }

    $req = $conn->prepare($sql);
    $req->execute($args);

    $nb_hits = $req->rowCount();
    if ($nb_hits > 0){
        $resp['message'] = "Deleted row(s): ". implode(", ", $args);
        $resp['code'] = "Deletion successful";
        $resp['nbhits'] = $nb_hits;
    } else {
        $resp['message'] = "No row deleted due to an error in your request or on the server";
        $resp['code'] = "No row deleted";
        http_response_code(500);
    }
    
}

echo json_encode($resp);