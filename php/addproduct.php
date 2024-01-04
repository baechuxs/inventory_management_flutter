<?php
$db = mysqli_connect('', '', '', '');
if (!$db) {
    echo "Connection failed";
}

$id = $_POST['id'];
$name = $_POST['name'];
$price = $_POST['price'];
$stock = $_POST['stock'];

$insert = "INSERT INTO product(id,name,price,stock)VALUES('" . $id . "','" . $name . "','" . $price . "','" . $stock . "')";
$query = mysqli_query($db, $insert);

if ($query) {
    echo json_encode("success");
}
