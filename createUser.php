<?php
// Change these two the local database settings
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "car_rental_service";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check Connection
if ($conn->connect_error) {
    die("Connection Failed: ");//, $conn->connect_error);
}

$stmt = $conn->prepare("INSERT INTO `user` (ssn, f_name, l_name, phone_number, street, city, state, zip) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
$stmt -> bind_param("issssssi",$ssn, $fName, $lName, $phoneNumber, $street, $city, $state, $zip);

// Change the variables to the element names on the front end
if ($_GET["ssn"] && $_GET["firstname"] && $_GET["lastname"] && $_GET["phone"] && $_GET["street"] && $_GET["city"] && $_GET["state"] && $_GET["zip"]) {
    $ssn = $_GET['ssn'];
    $fName = $_GET['firstname'];
    $lName = $_GET['lastname'];
    $phoneNumber = $_GET['phone'];
    $street = $_GET['street'];
    $city = $_GET['city'];
    $state = $_GET['state'];
    $zip = $_GET['zip'];
}


$stmt->execute();

echo "New records created successfully";

$stmt->close();
$conn->close();
?>