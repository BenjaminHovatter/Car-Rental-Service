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
    die("Connection Failed: ");//, $conn->connect_error);
}
$sql = "INSERT INTO `payment` (transaction_id, card_num, exp_date, card_holder, amount) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
if ( false===$stmt ) {
    die('prepare() failed: ' . htmlspecialchars($conn->error));
}
$stmt -> bind_param("iisii", $transactionId, $cardNumber, $expDate, $cardHolder, $amount);

// Change the variables to the element names on the front end
if ($_GET["transactionId"] && $_GET["cardNumber"] && $_GET["expDate"] && $_GET["cardHolder"] && $_GET["amount"]) {
    $transactionId = $_GET['transactionId'];
    $cardNumber = $_GET['cardNumber'];
    $expDate = $_GET['expDate'];
    $cardHolder = $_GET['cardHolder'];
    $amount= $_GET['amount'];
}


$stmt->execute();
if($status === false) {
    echo "Wrong!!!!";
    var_dump($stmt->error);
}
echo "New payment is created successfully";

$stmt->close();
$conn->close();
?>