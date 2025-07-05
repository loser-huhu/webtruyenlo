<?php
session_start();
header('Content-Type: application/json');

// Ghi log debug đầu vào
file_put_contents('debug_post.txt', print_r($_POST, true));

// Kiểm tra đăng nhập
if (!isset($_SESSION['user'])) {
    echo json_encode(['success' => false, 'message' => 'Bạn chưa đăng nhập']);
    exit;
}

require_once("../auth/db.php");

// Lấy dữ liệu từ form
$truyen_id = $_POST['truyen_id'] ?? null;
$tieu_de = $_POST['tieu_de'] ?? null;
$noi_dung = $_POST['noi_dung'] ?? null;

// Kiểm tra dữ liệu
if (empty($truyen_id) || empty($tieu_de) || empty($noi_dung)) {
    echo json_encode(['success' => false, 'message' => 'Thiếu dữ liệu']);
    exit;
}

// Câu lệnh SQL để thêm chương
$sql = "INSERT INTO chuong (truyen_id, tieu_de, noi_dung) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iss", $truyen_id, $tieu_de, $noi_dung);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Lỗi khi thêm chương: ' . $conn->error]);
}

$stmt->close();
$conn->close();
