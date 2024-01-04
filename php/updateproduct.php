<?php
$db = mysqli_connect('', '', '', '');
if (!$db) {
    echo "Connection failed";
}

$id = $_POST['id'];
$name = $_POST['name'];
$price = $_POST['price'];
$stock = $_POST['stock'];

$insert = "UPDATE product set name = '" . $name . "',price = '" . $price . "',stock = '" . $stock . "' where id = '" . $id . "'";
$query = mysqli_query($db, $insert);

if ($query) {
    echo json_encode("success");
}
