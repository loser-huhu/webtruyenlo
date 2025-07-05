<?php
session_start();
header('Content-Type: application/json');

$raw = file_get_contents("php://input");
$data = json_decode($raw, true);

$email = $data["email"];
$password = $data["password"];

// Kết nối cơ sở dữ liệu
require("db.php");

// Truy vấn người dùng
$stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
  if (password_verify($password, $row["password"])) {
    // ✅ Lưu ID và email vào session
    $_SESSION["user_id"] = $row["id"];
    $_SESSION["user"] = $row["email"];
    
    echo json_encode(["success" => true]);
  } else {
    echo json_encode(["success" => false, "error" => "Sai mật khẩu"]);
  }
} else {
  echo json_encode(["success" => false, "error" => "Tài khoản không tồn tại"]);
}

$conn->close();
?>
