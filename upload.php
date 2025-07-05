<?php
session_start();

// Kiểm tra đăng nhập
if (!isset($_SESSION["user"])) {
    echo "<h2>Bạn cần đăng nhập để đăng truyện.</h2>";
    echo "<a href='index.html'>Về trang chủ</a>";
    exit;
}

// Kết nối CSDL
require_once __DIR__ . "/auth/db.php";

// Lấy user_id từ email session
$email = $_SESSION["user"];
$sql_user = "SELECT id FROM users WHERE email = ?";
$stmt_user = $conn->prepare($sql_user);
$stmt_user->bind_param("s", $email);
$stmt_user->execute();
$result_user = $stmt_user->get_result();
if (!$user_row = $result_user->fetch_assoc()) {
    echo "<h2>Không tìm thấy người dùng!</h2>";
    exit;
}
$user_id = $user_row['id'];

// Xử lý nếu có POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $tieu_de = $_POST["story_name"];
    $tac_gia = $_POST["author"];
    $mo_ta = $_POST["summary"];
    $the_loai = isset($_POST["categories"]) ? implode(", ", $_POST["categories"]) : "";

    // Xử lý ảnh bìa
    $anh_bia = null;
    if (isset($_FILES["cover_image"]) && $_FILES["cover_image"]["error"] === UPLOAD_ERR_OK) {
        $upload_dir = "uploads/";
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }
        $ext = pathinfo($_FILES["cover_image"]["name"], PATHINFO_EXTENSION);
        $filename = uniqid() . "_" . time() . "." . $ext;
        $target_file = $upload_dir . $filename;

        if (move_uploaded_file($_FILES["cover_image"]["tmp_name"], $target_file)) {
            $anh_bia = $target_file;
        }
    }

    // Thêm vào bảng truyen
    $sql = "INSERT INTO truyen (user_id, tieu_de, tac_gia, anh_bia, mo_ta, the_loai) 
            VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isssss", $user_id, $tieu_de, $tac_gia, $anh_bia, $mo_ta, $the_loai);

    if ($stmt->execute()) {
        $truyen_id = $stmt->insert_id;

        // Nếu có nội dung chương đầu tiên
        if (!empty($_POST["chapter_content"])) {
            $noi_dung = $_POST["chapter_content"];
            $tieu_de_chuong = "Chương 1: " . $tieu_de;

            $sql_chuong = "INSERT INTO chuong (truyen_id, tieu_de, noi_dung, thu_tu)
                           VALUES (?, ?, ?, 1)";
            $stmt_chuong = $conn->prepare($sql_chuong);
            $stmt_chuong->bind_param("iss", $truyen_id, $tieu_de_chuong, $noi_dung);
            $stmt_chuong->execute();
            $stmt_chuong->close();
        }

        $thong_bao = "✅ Đăng truyện thành công!";
    } else {
        $thong_bao = "❌ Có lỗi khi lưu truyện: " . $stmt->error;
    }
    $stmt->close();
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Kết quả đăng truyện</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height:100vh;">
  <div class="card shadow p-4" style="max-width:600px;">
    <h2 class="mb-3">Kết quả</h2>
    <?php if (isset($thong_bao)) : ?>
      <div class="alert alert-info"><?= $thong_bao ?></div>
    <?php endif; ?>

    <div class="mt-3">
      <a href="upload.html" class="btn btn-primary">Đăng truyện mới</a>
      <a href="index.html" class="btn btn-outline-secondary">Về trang chủ</a>
      <a href="quan_ly_truyen.html" class="btn btn-outline-success">Truyện đã đăng</a>
    </div>
  </div>
</body>
</html>
