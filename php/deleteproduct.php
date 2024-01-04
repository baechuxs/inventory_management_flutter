<?php
$db = mysqli_connect('', '', '', '');
if (!$db) {
    echo "Connection failed";
}

$id = $_POST['id'];

$insert = "DELETE from product where id like '" . $id . "'";
$query = mysqli_query($db, $insert);

if ($query) {
    echo json_encode("success");
}
