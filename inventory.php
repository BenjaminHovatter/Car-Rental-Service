<?php
header('Access-Control-Allow-Origin: *');
// Change these two the local database settings
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "car_rental_service";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check Connection
if ($conn->connect_error) {
    die("Connection Failed: ");
}

$sql = "SELECT * FROM car_supplier";
$stmt = $conn->prepare($sql);

$stmt->execute();
$result = $stmt->get_result();

echo json_encode(iterator_to_array($result));

$stmt->close();
$conn->close();