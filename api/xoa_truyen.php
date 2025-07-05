<?php
session_start();
header('Content-Type: application/json');

require_once("../auth/db.php");

// Kiểm tra đăng nhập
if (!isset($_SESSION['user'])) {
    echo json_encode(["success" => false, "error" => "Chưa đăng nhập"]);
    exit;
}

// Lấy email người dùng đang đăng nhập
$userEmail = $_SESSION['user'];

// Lấy ID người dùng
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $userEmail);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (!$user) {
    echo json_encode(["success" => false, "error" => "Không tìm thấy người dùng"]);
    exit;
}

$user_id = $user['id'];

// Lấy ID truyện từ yêu cầu
$raw = file_get_contents("php://input");
$data = json_decode($raw, true);
$truyen_id = intval($data['truyen_id'] ?? 0);

if ($truyen_id <= 0) {
    echo json_encode(["success" => false, "error" => "Thiếu ID truyện"]);
    exit;
}

// Kiểm tra truyện có thuộc người dùng không
$check = $conn->prepare("SELECT id FROM truyen WHERE id = ? AND user_id = ?");
$check->bind_param("ii", $truyen_id, $user_id);
$check->execute();
$res = $check->get_result();

if ($res->num_rows === 0) {
    echo json_encode(["success" => false, "error" => "Truyện không tồn tại hoặc không thuộc về bạn"]);
    exit;
}

// Xoá truyện (do FOREIGN KEY ON DELETE CASCADE sẽ xoá chương luôn)
$del = $conn->prepare("DELETE FROM truyen WHERE id = ?");
$del->bind_param("i", $truyen_id);

if ($del->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => "Lỗi khi xoá truyện"]);
}
