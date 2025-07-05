<?php
require_once("../auth/db.php");

if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "Thiếu ID truyện"]);
    exit;
}

$truyen_id = intval($_GET['id']);

$stmt = $conn->prepare("SELECT id, tieu_de FROM chuong WHERE truyen_id = ? ORDER BY thu_tu ASC");
$stmt->bind_param("i", $truyen_id);
$stmt->execute();
$result = $stmt->get_result();

$chuong = [];
while ($row = $result->fetch_assoc()) {
    $chuong[] = $row;
}

echo json_encode($chuong);

$stmt->close();
$conn->close();
?>
