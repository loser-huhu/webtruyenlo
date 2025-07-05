<?php
session_start();
require_once 'db.php';

// Kiểm tra đăng nhập
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

// Xử lý dữ liệu form
$errors = [];
$success = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Lấy dữ liệu từ form
    $tieuDe = $_POST['story_name'] ?? '';
    $tacGia = $_POST['author'] ?? '';
    $moTa = $_POST['summary'] ?? '';
    $theLoai = isset($_POST['categories']) ? implode(', ', $_POST['categories']) : '';
    $chuongTieuDe = $_POST['chapter_title'] ?? '';
    $chuongNoiDung = $_POST['chapter_content'] ?? '';

    // Validate dữ liệu
    if (empty($tieuDe)) $errors[] = 'Vui lòng nhập tên truyện';
    if (empty($tacGia)) $errors[] = 'Vui lòng nhập tên tác giả';
    if (empty($chuongTieuDe)) $errors[] = 'Vui lòng nhập tiêu đề chương';
    if (empty($chuongNoiDung)) $errors[] = 'Vui lòng nhập nội dung chương';

    // Xử lý upload ảnh bìa
    $anhBia = null;
    if (isset($_FILES['cover_image']) && $_FILES['cover_image']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['cover_image'];
        $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        $maxSize = 5 * 1024 * 1024; // 5MB

        if (in_array($file['type'], $allowedTypes) && $file['size'] <= $maxSize) {
            $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
            $newName = uniqid('cover_', true) . '.' . $ext;
            $uploadPath = 'uploads/' . $newName;

            if (move_uploaded_file($file['tmp_name'], $uploadPath)) {
                $anhBia = $uploadPath;
            } else {
                $errors[] = 'Có lỗi khi upload ảnh bìa';
            }
        } else {
            $errors[] = 'File ảnh không hợp lệ (chỉ chấp nhận JPG, PNG, GIF và tối đa 5MB)';
        }
    }

    // Lưu vào CSDL nếu không có lỗi
    if (empty($errors)) {
        try {
            $pdo->beginTransaction();

            // Lưu truyện
            $stmt = $pdo->prepare("INSERT INTO truyen (user_id, tieu_de, tac_gia, anh_bia, mo_ta, the_loai) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$_SESSION['user_id'], $tieuDe, $tacGia, $anhBia, $moTa, $theLoai]);
            $truyenId = $pdo->lastInsertId();

            // Lưu chương đầu tiên
            $stmt = $pdo->prepare("INSERT INTO chuong (truyen_id, tieu_de, noi_dung, thu_tu) VALUES (?, ?, ?, ?)");
            $stmt->execute([$truyenId, $chuongTieuDe, $chuongNoiDung, 1]);

            $pdo->commit();
            $success = true;
        } catch (Exception $e) {
            $pdo->rollBack();
            $errors[] = 'Có lỗi xảy ra: ' . $e->getMessage();
        }
    }
}

// Hiển thị kết quả
if ($success) {
    header('Location: user_stories.php?success=1');
    exit();
} else {
    // Lưu lỗi và chuyển hướng trở lại form
    $_SESSION['errors'] = $errors;
    header('Location: dang_truyen.html');
    exit();
}
?>