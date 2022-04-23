<!-- *** Update the HTML with the final front end product *** 

The below HTML is for testing the PHP interface.   -->
<html>
<body>

<html>
   <body>
      <form action = "<?php $_PHP_SELF ?>" method = "GET">
         SSN: <input type = "text" name = "ssn" />
         Password: <input type = "text" name = "password" />  
         FirstName: <input type = "text" name = "firstname" />
         LastName: <input type = "text" name = "lastname" />
         PhoneNumber: <input type = "text" name = "phone" />
         Street: <input type = "text" name = "street" />
         City: <input type = "text" name = "city" />
         State: <input type = "text" name = "state" />
         Zip: <input type = "text" name = "zip" />
         <input type = "submit" />
      </form>    
   </body>
</html>

</body>
</html>

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
$sql = "INSERT INTO `user` (ssn, user_password, f_name, l_name, phone_number, street, city, state, zip) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt -> bind_param("isssssssi",$ssn, $user_password, $fName, $lName, $phoneNumber, $street, $city, $state, $zip);

// Change the variables to the element names on the front end
if ($_GET["ssn"] && $_GET["firstname"] && $_GET["lastname"] && $_GET["phone"] && $_GET["street"] && $_GET["city"] && $_GET["state"] && $_GET["zip"]) {
    $ssn = $_GET['ssn'];
    $user_password = $_GET['password'];
    $fName = $_GET['firstname'];
    $lName = $_GET['lastname'];
    $phoneNumber = $_GET['phone'];
    $street = $_GET['street'];
    $city = $_GET['city'];
    $state = $_GET['state'];
    $zip = $_GET['zip'];
}


$status = $stmt->execute();
if($status === false) {
    var_dump($stmt->error);
}
echo "New records created successfully";

$stmt->close();
$conn->close();
?>