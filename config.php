<?php

define('DB_HOST','localhost');
define('DB_NAME', 'exo_integ_2023');
define('DB_USER', 'root');
define('USER_PASS', '');

try {
    $conn = new PDO(
        'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
        DB_USER,
        USER_PASS,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    $conn->setAttribute(PDO::ATTR_STRINGIFY_FETCHES, false);
} catch (Exception $e) {
    die('Error: ' . $e->getMessage()); 
}

session_start();

include("functions.php");