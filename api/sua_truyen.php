<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user'])) {
    echo json_encode(['success' => false, 'message' => 'Bạn chưa đăng nhập']);
    exit;
}

require_once("../auth/db.php");

$id = $_POST['id'];
$tieu_de = $_POST['story_name'];
$tac_gia = $_POST['author'];
$mo_ta = $_POST['summary'];
$the_loai = isset($_POST['categories']) ? implode(", ", $_POST['categories']) : '';
$anh_bia = null;

// Lấy ảnh bìa nếu có cập nhật
if (isset($_FILES['cover_image']) && $_FILES['cover_image']['error'] === UPLOAD_ERR_OK) {
    $upload_dir = '../uploads/';
    if (!is_dir($upload_dir)) {
        mkdir($upload_dir, 0777, true);
    }

    $ext = pathinfo($_FILES['cover_image']['name'], PATHINFO_EXTENSION);
    $filename = uniqid() . '.' . $ext;
    $target_path = $upload_dir . $filename;

    if (move_uploaded_file($_FILES['cover_image']['tmp_name'], $target_path)) {
        $anh_bia = 'uploads/' . $filename;
    }
}

// Câu lệnh SQL cập nhật
$sql = "UPDATE truyen SET tieu_de = ?, tac_gia = ?, mo_ta = ?, the_loai = ?" . ($anh_bia ? ", anh_bia = ?" : "") . " WHERE id = ?";
$stmt = $conn->prepare($sql);

if ($anh_bia) {
    $stmt->bind_param("sssssi", $tieu_de, $tac_gia, $mo_ta, $the_loai, $anh_bia, $id);
} else {
    $stmt->bind_param("ssssi", $tieu_de, $tac_gia, $mo_ta, $the_loai, $id);
}

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => $conn->error]);
}

$stmt->close();
$conn->close();
