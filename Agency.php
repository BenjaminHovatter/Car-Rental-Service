The below HTML is for testing the PHP interface.   -->
<html>
<body>

<html>
   <body>
	<h1> Add Agency </h1>
      <form action = "<?php $_PHP_SELF ?>" method = "GET">
        Department Number: <input type = "text" name = "d_num" />
        Street: <input type = "text" name = "street" />
	City: <input type = "text" name = "city" />
	State: <input type = "text" name = "state" />
        <input type = "submit" />
      </form>    
   </body>
</html>

</body>
</html>

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

$stmt = $conn->prepare("INSERT INTO `agency` (d_num, street, city, state) VALUES (?, ?, ?, ?)");
$stmt -> bind_param("isss", $d_num, $street, $city, $state);

// Change the variables to the element names on the front end
if ($_GET["d_num"] && $_GET["street"] && $_GET["city"] && $_GET["state"]) {
    $d_num = $_GET['d_num'];
    $street = $_GET['street'];
    $city = $_GET['city'];
    $state = $_GET['state'];
}


$stmt->execute();

echo "New records created successfully";

$stmt->close();
$conn->close();
?>