<?php
session_start();
header('Content-Type: application/json');

require_once("../auth/db.php");

// Kiểm tra người dùng đã đăng nhập chưa
if (!isset($_SESSION['user'])) {
    echo json_encode([]);
    exit;
}

// Lấy ID người dùng từ session (dựa theo email)
$userEmail = $_SESSION['user'];
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $userEmail);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (!$user) {
    echo json_encode([]);
    exit;
}

$user_id = $user['id'];

// Truy vấn các truyện đã đăng của người dùng
$sql = "
    SELECT 
        t.id, 
        t.tieu_de, 
        t.tac_gia, 
        t.anh_bia, 
        t.mo_ta, 
        t.the_loai, 
        t.created_at,
        COUNT(c.id) AS tong_chuong
    FROM truyen t
    LEFT JOIN chuong c ON t.id = c.truyen_id
    WHERE t.user_id = ?
    GROUP BY t.id
    ORDER BY t.created_at DESC
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$stories = [];
while ($row = $result->fetch_assoc()) {
    $stories[] = $row;
}

echo json_encode($stories);
?>
