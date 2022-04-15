<!-- *** Update the HTML with the final front end product *** 

The below HTML is for testing the PHP interface.   -->
<html>
<body>

<html>
   <body>
      <form action = "<?php $_PHP_SELF ?>" method = "GET">
         Car Supplier ID: <input type = "text" name = "carSupplier" />
         VIN: <input type = "text" name = "vinNumber" />
         Make: <input type = "text" name = "make" />
         Model: <input type = "text" name = "model" />
         Color: <input type = "text" name = "color" />
         Price Per day: <input type = "text" name = "price" />
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
    die("Connection Failed: ");
}
$sql = "INSERT INTO car_supplier (cs_id, vin, make, model, color, price_per_day) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt -> bind_param("sssssi", $cs_id, $vin, $make, $model, $color, $price);

// Change the variables to the element names on the front end
if ($_GET["carSupplier"] && $_GET["vinNumber"] && $_GET["make"] && $_GET["model"] && $_GET["color"] && $_GET["price"]) {
    $cs_id = $_GET['carSupplier'];
    $vin = $_GET['vinNumber'];
    $make = $_GET['make'];
    $model = $_GET['model'];
    $color = $_GET['color'];
    $price = $_GET['price'];
    
    $stmt->execute();
}

echo "New records created successfully";


$stmt->close();
$conn->close();
?>