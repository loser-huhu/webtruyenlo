<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user'])) {
    echo json_encode(['success' => false, 'message' => 'Bạn chưa đăng nhập']);
    exit;
}

require_once("../auth/db.php");

$data = json_decode(file_get_contents("php://input"), true);
$truyen_id = (int)($data['truyen_id'] ?? 0);
$so_sao = (int)($data['so_sao'] ?? 0);

if ($truyen_id <= 0 || $so_sao < 1 || $so_sao > 5) {
    echo json_encode(['success' => false, 'message' => 'Dữ liệu không hợp lệ']);
    exit;
}

$userEmail = $_SESSION['user'];
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $userEmail);
$stmt->execute();
$result = $stmt->get_result();

if ($user = $result->fetch_assoc()) {
    $user_id = $user['id'];

    // Dùng ON DUPLICATE KEY UPDATE để cập nhật điểm nếu đã tồn tại
    $stmt2 = $conn->prepare("
        INSERT INTO danh_gia (truyen_id, user_id, so_sao)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE so_sao = VALUES(so_sao)
    ");
    $stmt2->bind_param("iii", $truyen_id, $user_id, $so_sao);
    
    if ($stmt2->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Không thể lưu đánh giá']);
    }

    $stmt2->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Không tìm thấy user']);
}

$stmt->close();
$conn->close();
