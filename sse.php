<?php
// sse.php
header('Content-Type: text/event-stream');
header('Cache-Control: no-cache');

// Connexion à la base de données via PDO
require 'config.php'; // Assurez-vous que 'config.php' contient vos paramètres de connexion PDO

try {
    // Récupérez la liste des visiteurs actuellement dans le bâtiment
    $sql = "SELECT * FROM is_there ORDER BY nom ASC";
    $stmt = $conn->prepare($sql);
    $stmt->execute();

    $visiteurs = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Envoie les données au client
    echo "data: " . json_encode($visiteurs) . "\n\n";
    flush();
} catch (PDOException $e) {
    // Gérer l'erreur ou la logger
    error_log("Erreur PDO dans sse.php: " . $e->getMessage());
    echo "data: erreur\n\n";
    flush();
}
