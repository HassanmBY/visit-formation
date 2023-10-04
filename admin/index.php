<?php

require_once "../config.php";

if ($_SERVER['REQUEST_METHOD'] === "POST" && isset($_POST['login']) && isset($_POST['pass'])) {
    $login = $_POST['login'];
    $pass = $_POST['pass'];

    // Fetch user from the database
    $sql = "SELECT * from admins WHERE login = :login";
    $stmt = $conn->prepare($sql);
    $stmt->execute(['login' => $login]);
    $user = $stmt->fetch();

    if ($user && password_verify($pass, $user['password'])) {
        // Authentication successful
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['token'] = md5(date("DdMyHis"));
        $_SESSION['expiration'] = time() + (60 * 5);
    } else {
        $errorMsg = "Invalid login credentials!";
    }
}

if (isset($_GET['action']) && $_GET['action'] === "logout") {
    // Logout
    session_destroy();
    header('Location: index.php');
    exit();
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord administrateur</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>
    <script>
        tailwind.config = {
            theme: {
                data: {
                    checked: 'ui~="checked"'
                },
                extend: {
                    colors: {
                        clifford: '#da373d',
                    }
                }
            }
        }
    </script>
    <script src="https://unpkg.com/html5-qrcode"></script>
    <script src="https://cdn.rawgit.com/davidshimjs/qrcodejs/gh-pages/qrcode.min.js"></script>
    <script src="assets/scripts/main.js" defer></script>
    <link rel="stylesheet" href="assets/style/style.css">
</head>

<body>
    <header class="bg-gray-800 p-4">
        <nav class="flex justify-between	">
            <ul class="flex space-x-4">
                <li><a href="index.php" class="text-white px-4 py-2 bg-blue-600 rounded-lg hover:bg-blue-500">Tableau de bord</a>
                </li>
            </ul>
            <ul>
                <li>
                    <a href="index.php?action=logout" class="text-white px-4 py-2 bg-red-600 rounded-lg hover:bg-red-500">Logout</a>
                </li>
            </ul>
        </nav>
    </header>
    <main class="mt-4 p-4 flex flex-col">
        <div class="flex flex-row">*
            <?php if (!isset($_SESSION['token']) || !isset($_SESSION['expiration']) || $_SESSION['expiration'] <= time()) : ?>
                <div class="p-6 bg-white border border-gray-200 rounded-lg shadow loginCard" id="loginCard">
                    <?php if (isset($errorMsg)) : ?>
                        <div class="alert alert-danger">
                            <?= $errorMsg ?>
                        </div>
                    <?php endif ?>
                    <form method="POST">
                        <h2 class="text-lg font-semibold">Connexion</h2>
                        <fieldset>
                            <legend>Login<legend>
                                    <div class="flex flex-col max-w-xs">
                                        <input name="login" id="login" required></input>
                                    </div>
                        </fieldset>
                        <fieldset>
                            <legend>Mot de passe</legend>
                            <div class="flex flex-col max-w-xs">
                                <input type="password" name="pass" id="pass" required>
                            </div>
                        </fieldset>
                        <button class="text-white px-4 py-2 bg-blue-600 rounded-lg hover:bg-blue-500">Connexion</button>
                    </form>
                </div>
            <?php else : ?>
                <div>
                    <h2 class="font-semibold">Visiteurs sur place</h2>
                    <div class="p-6 bg-white border border-gray-200 rounded-lg shadow max-w-min whosThere" id="whosThere">
                        <table class="table-auto text-left	">
                            <thead class="bg-gray-800 border-black-200 text-white">
                                <tr class="p-6">
                                    <th>Nom</th>
                                    <th>Prénom</th>
                                    <th>Email</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div>
                    <h2 class="font-semibold">Gérer le personnel</h2>
                    <div class="p-6 bg-white border border-gray-200 rounded-lg shadow" id="container">
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow" id="formateur">
                            <p class="font-semibold">Formateurs:</p>
                            <ul id="formateurs" class="p-6 bg-white border border-gray-200 rounded-lg shadow listContainers" data-container="formateur">

                            </ul>
                        </div>
                        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow" id="administration">
                            <p class="font-semibold">Administration:</p>
                            <ul id="admins" class="p-6 bg-white border border-gray-200 rounded-lg shadow listContainers" data-container="administration">

                            </ul>
                        </div>
                    </div>
                </div>
        </div>

        <div class="flex flex-row">
            <div>
                <h2 class="font-semibold">Modifier les données</h2>
                <div class="p-6 bg-white border border-gray-200 rounded-lg shadow" id="personnelContainer">
                    <h3 class="font-semibold">Peronnel</h3>
                    <select name="formateursList" id="formateursList">

                    </select>
                    <form class="flex flex-row gap-1">
                        <fieldset class="flex flex-col">
                            <label for="p_nom">Nom</label>
                            <input type="text" name="p_nom" id="p_nom">
                        </fieldset>
                        <fieldset class="flex flex-col">
                            <label for="p_prenom">Prénom</label>
                            <input type="text" name="p_prenom" id="p_prenom">
                        </fieldset>
                        <fieldset class="flex flex-col">
                            <label for="fonction">Fonction</label>
                            <select name="selectFonction" id="selectFonction">
                                <option value="formateur">Formateur</option>
                                <option value="administration">Administration</option>
                            </select>
                        </fieldset>
                        <fieldset class="flex flex-col">
                            <label for="local">Local</label>
                            <input type="text" name="local" id="local">
                        </fieldset>
                        <fieldset class="flex flex-col">
                            <label for="phone">N° de tel. interne</label>
                            <input type="text" name="phone" id="phone">
                        </fieldset>
                        <input type="hidden" id="p_id">
                    </form>
                    <button class="text-white px-4 py-2 bg-blue-600 rounded-lg hover:bg-blue-500" id="majPerso">Mettre à jour</button>
                </div>

                <div class="p-6 bg-white border border-gray-200 rounded-lg shadow" id="personnelContainer">
                    <h3 class="font-semibold">Formations</h3>
                    <select name="formationsList" id="formationsList">

                    </select>
                    <form class="flex flex-row gap-1">
                        <fieldset class="flex flex-col">
                            <label for="formationIntitule">Intitulé</label>
                            <input type="text" name="formationIntitule" id="formationIntitule">
                        </fieldset>

                    </form>
                    <button class="text-white px-4 py-2 bg-blue-600 rounded-lg hover:bg-blue-500" id="majForma">Mettre à jour</button>
                </div>
            </div>


        </div>

        <div class="flex flex-row">
            <div>
                <h2 class="font-semibold">Historique des visites</h2>
                <div class="p-6 bg-white border border-gray-200 rounded-lg shadow max-w-min historique" id="historique">
                    <input type="date" name="date" id="date">
                    <table class="table-auto text-left">
                        <thead class="bg-gray-800 border-gray-200 text-white">
                            <tr class="p-6">
                                <th>Nom</th>
                                <th>Prénom</th>
                                <th>Email</th>
                                <th>Entrée</th>
                                <th>Sortie</th>
                                <th>Objet</th>
                                <th>Nom du personnel</th>
                                <th>Prénom du personnel</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow errorBox" id="errorBox"></div>
    <?php endif; ?>
    </main>
</body>

</html>