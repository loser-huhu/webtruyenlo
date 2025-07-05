<?php
$host = 'localhost';
$dbname = 'webtruyen';
$user = 'root';
$pass = ''; // Mặc định XAMPP không có mật khẩu

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Kết nối CSDL thất bại: " . $e->getMessage());
}
?>
