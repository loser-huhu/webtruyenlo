<?php
require_once("../auth/db.php");

if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "Thiếu ID truyện"]);
    exit;
}

$id = intval($_GET['id']);

$stmt = $conn->prepare("SELECT * FROM truyen WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode($row);
} else {
    http_response_code(404);
    echo json_encode(["error" => "Không tìm thấy truyện"]);
}

$stmt->close();
$conn->close();
?>
