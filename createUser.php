<?php
// Change these two the local database settings
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "myDB";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check Connection
if ($conn->connect_error) {
    die("Connection Failed: ", $conn->connect_error);
}

$stmt = $conn->prepare("INSERT INTO `user` (ssn, f_name, l_name, phone_number, street, city, state, zip) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
$stmt -> bind_param("issssssi"$ssn, $fName, $lName, $phoneNumber, $street, $city, $state, $zip);

// Change the variables to the element names on the front end

$ssn = $_POST['CHANGE_ME'];
$fName = $_POST['CHANGE_ME'];
$lName = $_POST['CHANGE ME'];
$phoneNumber = $_POST['CHANGE_ME'];
$street = $_POST['CHANGE_ME'];
$city = $_POST['CHANGE_ME'];
$state = $_POST['CHANGE_ME'];
$zip = $_POST['CHANGE_ME'];

stmt->execute();

$stmt->close();
$conn->close();
?>