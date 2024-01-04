<?php
$db = mysqli_connect('', '', '', '');
if (!$db) {
    echo "Connection failed";
}

$sql = "select * from product order by name";
$ambil_data = mysqli_query($db, $sql);

$data_product = array();

while ($row_product = mysqli_fetch_array($ambil_data)) {
    $data_product[] = $row_product;
}

echo json_encode($data_product);
