-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jul 05, 2025 at 09:16 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webtruyends`
--

-- --------------------------------------------------------

--
-- Table structure for table `binh_luan`
--

CREATE TABLE `binh_luan` (
  `id` int(11) NOT NULL,
  `truyen_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `noi_dung` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `binh_luan`
--

INSERT INTO `binh_luan` (`id`, `truyen_id`, `user_id`, `noi_dung`, `created_at`) VALUES
(1, 9, 1, 'truyện hay', '2025-07-05 03:21:15'),
(2, 9, 1, 'cũng ok', '2025-07-05 03:36:05'),
(3, 9, 1, 'ok', '2025-07-05 04:11:18');

-- --------------------------------------------------------

--
-- Table structure for table `chuong`
--

CREATE TABLE `chuong` (
  `id` int(11) NOT NULL,
  `truyen_id` int(11) NOT NULL,
  `tieu_de` varchar(255) NOT NULL,
  `noi_dung` longtext NOT NULL,
  `thu_tu` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chuong`
--

INSERT INTO `chuong` (`id`, `truyen_id`, `tieu_de`, `noi_dung`, `thu_tu`, `created_at`) VALUES
(6, 6, 'Chương 1: Ongo lão đánh cá và con cá đỏ', '<p>test</p>', 1, '2025-07-02 11:19:33'),
(7, 7, 'Chương 1: Ongo lão đánh cá và con cá đỏ', '<p>test</p>', 1, '2025-07-02 11:19:45'),
(9, 9, 'Chương 1: Bi long đại ca', '<p>ádasdsad</p>', 1, '2025-07-02 15:43:10'),
(10, 9, 'Chương 2 : Hùng Phong tRANH bÁ', '<p>&nbsp;</p><h2>What is it</h2><p>Autoprefixer online — web repl for original Autoprefixer. It parses your CSS and adds vendor prefixes to CSS rules using values from <a href=\"https://caniuse.com/\">Can I Use</a>. It is <a href=\"https://developers.google.com/web/tools/setup/setup-buildtools#dont_trip_up_with_vendor_prefixes\">recommended</a> by Google and used by Twitter and Taobao.</p><h3>How does it work</h3><p>The Autoprefixer uses data on the popularity of browsers and support for vendor prefixes by browsers. Based on this information, it arranges and deletes the prefixes. It can help you get prefixes for: animations, transition, transform, grid, flex, flexbox and others.</p><h3>Browser filter</h3><p>You can configure which browsers to generate prefixes for in the distribution. More details on the syntax are in the <a href=\"https://github.com/postcss/autoprefixer#browsers\">documentation</a>. There is also a block in the <a href=\"https://github.com/postcss/autoprefixer#faq\">FAQ</a>.</p><h3>Options</h3><p>The IE grid layout polyfill is enabled, which is not by <a href=\"https://github.com/postcss/autoprefixer#does-autoprefixer-polyfill-grid-layout-for-ie\">default</a> in autoprefixer.</p><h4>Big thanks</h4><p>To <a href=\"https://github.com/ai\">Andrey Sitnik</a>, author of <a href=\"https://github.com/postcss/postcss\">PostCSS</a>, <a href=\"https://github.com/postcss/autoprefixer\">Autoprefixer</a>, <a href=\"https://github.com/ai/browserslist\">browserslist</a> and other awesome tools.</p><p>Autoprefixer online, also known as: prefixer, prefix generator, cross browser css generator, vendor prefixes generator.</p>', 1, '2025-07-02 17:11:58'),
(11, 10, 'Chương 1: ACB', '<p>ASDSAAA</p><p>nội tình</p><h2>Giới thiệu truyện</h2><h2>Danh sách chương</h2><p>Là một truyện được giới thiệu với bạn đọc trên trang đọc truyện chữ hay online. <a href=\"https://truyenchu.com.vn/lam-nguoi-duong-nhan-tan-pho-ma-nguoi-th\"><strong>Truyện Làm ngươi đương nhàn tản phò mã, ngươi thành chí cường Võ Thánh? </strong></a>là một <a href=\"https://truyenchu.com.vn/\"><strong>truyện online hay</strong></a> của tác giả <strong>Thủ Tịch Ngoạn Gia</strong> sáng tác thuộc thể loại <strong>Huyền huyễn</strong>, <strong>Ngôn tình</strong>, <strong>Dã sử</strong>, <strong>Cổ Đại</strong>, <strong>Hệ thống</strong>, với diễn biến, nội dung truyện rất hấp dẫn và cuốn hút. Đọc truyện bạn đọc sẽ được dẫn dắt vào một thế giới đầy sự sáng tạo mới lạ, những tình tiết đặc sắc, giúp bạn có những trải nghiệm thích thú, mới lạ hơn.</p><p><a href=\"https://truyenchu.com.vn/\"><strong>Truyện Chữ</strong></a> <a href=\"https://truyenchu.com.vn/lam-nguoi-duong-nhan-tan-pho-ma-nguoi-th\"><strong>Truyện Làm ngươi đương nhàn tản phò mã, ngươi thành chí cường Võ Thánh? </strong></a>được cập nhật nhanh và đầy đủ nhất tại TruyenChu. Bạn đọc đừng quên để lại bình luận và chia sẻ, ủng hộ TruyenChu ra các chương mới nhất của truyện <a href=\"https://lightnovel.vn/truyen/lam-nguoi-duong-nhan-tan-pho-ma-nguoi-th\"><strong>Truyện Làm ngươi đương nhàn tản phò mã, ngươi thành chí cường Võ Thánh? </strong></a>.</p><p>Bình luận truyện</p><p>Bạn cần <a href=\"https://truyenchu.com.vn/tai-khoan/dang-nhap\">đăng nhập</a> để bình luận</p><h2>Truyện cùng thể loại</h2><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=3840&amp;q=75\" alt=\"Nam xuyên nữ: Các nam chính đều ái tới nghe lén gia tiếng lòng \" srcset=\"https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/nam-xuyen-nu-cac-nam-chinh-deu-ai-toi-ng.html\">Nam xuyên nữ: Các nam chính đều ái tới nghe lén gia tiếng lòng</a></p><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=3840&amp;q=75\" alt=\"Thôn phệ Cửu Trọng Thiên \" srcset=\"https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/thon-phe-cuu-trong-thien/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/thon-phe-cuu-trong-thien.html\">Thôn phệ Cửu Trọng Thiên</a></p><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=3840&amp;q=75\" alt=\"Ta sắm vai khế quỷ sư đều là bệnh tâm thần \" srcset=\"https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/ta-sam-vai-khe-quy-su-deu-la-benh-tam-th.html\">Ta sắm vai khế quỷ sư đều là bệnh tâm thần</a></p><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=3840&amp;q=75\" alt=\"Đầu uy đỉnh cấp thú nhân sau, ta bị toàn tinh tế đoàn sủng \" srcset=\"https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/dau-uy-dinh-cap-thu-nhan-sau-ta-bi-toan-.html\">Đầu uy đỉnh cấp thú nhân sau, ta bị toàn tinh tế đoàn sủng</a></p><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=3840&amp;q=75\" alt=\"Khí tử tu tiên lục \" srcset=\"https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/khi-tu-tu-tien-luc/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/khi-tu-tu-tien-luc.html\">Khí tử tu tiên lục</a></p><figure class=\"image\"><img style=\"aspect-ratio:150/200;\" src=\"https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=3840&amp;q=75\" alt=\"60 niên đại, ta có thể vô hạn bắt chước \" srcset=\"https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=640&amp;q=75 640w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=750&amp;q=75 750w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=828&amp;q=75 828w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=1080&amp;q=75 1080w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=1200&amp;q=75 1200w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=1920&amp;q=75 1920w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=2048&amp;q=75 2048w, https://static.truyenchu.com.vn/Data/60-nien-dai-ta-co-the-vo-han-bat-chuoc/150.jpg?w=3840&amp;q=75 3840w\" sizes=\"100vw\" width=\"150\" height=\"200\"></figure><p><a href=\"https://truyenchu.com.vn/truyen/60-nien-dai-ta-co-the-vo-han-bat-chuoc.html\">60 niên đại, ta có thể vô hạn bắt chước</a></p><h4>Truyện Cùng Tác Giả</h4><h3><a href=\"https://truyenchu.com.vn/truyen/de-nguoi-lam-nhan-tan-pho-ma-nguoi-thanh-chi-cuong-vo-thanh.html\">Để Ngươi Làm Nhàn Tản Phò Mã, Ngươi Thành Chí Cường Võ Thánh?</a></h3><p><a href=\"https://truyenchu.com.vn/truyen-tac-gia/thu-tich-ngoan-gia-c685\">Xem thêm</a></p><h4>Truyện Hot</h4><figure class=\"image\"><img style=\"aspect-ratio:24/32;\" src=\"https://truyenchu.com.vn/images/medal-1.svg\" width=\"24\" height=\"32\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/van-co-than-de.html\">Vạn Cổ Thần Đế</a></h3><p>Phi Thiên Ngư</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:80/128;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%2780%27%20height=%27128%27/%3e\" alt=\"\" width=\"80\" height=\"128\"></figure><figure class=\"image\"><img style=\"aspect-ratio:150/215;\" src=\"https://static.truyenchu.com.vn/Data/van-co-than-de/150.jpg?w=256&amp;q=75\" alt=\"Vạn Cổ Thần Đế\" srcset=\"https://static.truyenchu.com.vn/Data/van-co-than-de/150.jpg?w=96&amp;q=75 1x, https://static.truyenchu.com.vn/Data/van-co-than-de/150.jpg?w=256&amp;q=75 2x\" sizes=\"100vw\" width=\"150\" height=\"215\"></figure><figure class=\"image\"><img style=\"aspect-ratio:24/32;\" src=\"https://truyenchu.com.vn/images/medal-2.svg\" width=\"24\" height=\"32\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/than-de-vo-thuong.html\">Vô Thượng Thần Đế</a></h3><figure class=\"image\"><img style=\"aspect-ratio:24/32;\" src=\"https://truyenchu.com.vn/images/medal-3.svg\" width=\"24\" height=\"32\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/vu-luyen-dien-phong.html\">Vũ Luyện Điên Phong</a></h3><p>4</p><h3><a href=\"https://truyenchu.com.vn/truyen/de-ba.html\">Đế Bá</a></h3><p>5</p><h3><a href=\"https://truyenchu.com.vn/truyen/bat-dau-danh-dau-hoang-co-thanh-the.html\">Bắt Đầu Đánh Dấu Hoang Cổ Thánh Thể</a></h3><p>6</p><h3><a href=\"https://truyenchu.com.vn/truyen/cuu-tinh-ba-the-quyet.html\">Cửu Tinh Bá Thể Quyết</a></h3><p>7</p><h3><a href=\"https://truyenchu.com.vn/truyen/vo-thuong-sat-than.html\">Vô Thượng Sát Thần</a></h3><p>8</p><h3><a href=\"https://truyenchu.com.vn/truyen/nhat-kiem-doc-ton.html\">Nhất Kiếm Độc Tôn</a></h3><p>9</p><h3><a href=\"https://truyenchu.com.vn/truyen/tien-vo-de-ton.html\">Tiên Võ Đế Tôn</a></h3><p>10</p><h3><a href=\"https://truyenchu.com.vn/truyen/than-dao-de-ton.html\">Thần Đạo Đế Tôn</a></h3><p>11</p><h3><a href=\"https://truyenchu.com.vn/truyen/dao-gioi-thien-ha.html\">Đạo Giới Thiên Hạ</a></h3><p>12</p><h3><a href=\"https://truyenchu.com.vn/truyen/ta-chi-muon-an-tinh-lam-cau-dao-ben-trong-nguoi.html\">Ta Chỉ Muốn An Tĩnh Làm Cẩu Đạo Bên Trong Người</a></h3><h4><strong>VỀ TRUYỆN CHỮ</strong></h4><p><a href=\"https://truyenchu.com.vn/\">Truyện Chữ</a> -&nbsp;<a href=\"https://truyenchu.com.vn/\">Đọc truyện chữ</a> online, <a href=\"https://truyenchu.com.vn/\">mê đọc truyện</a>&nbsp;chữ,&nbsp;truyện chữ hay. Website luôn cập nhật những bộ&nbsp;truyện chữ dịch hoặc convert&nbsp;đang cập nhật hoặc <a href=\"https://truyenchu.com.vn/danh-sach/truyen-full\">truyện full</a> thuộc các thể loại đặc sắc như&nbsp;<a href=\"https://truyenchu.com.vn/the-loai/tien-hiep\">truyện Tiên Hiệp</a>,&nbsp;<a href=\"https://truyenchu.com.vn/the-loai/kiem-hiep\">truyện Kiếm Hiệp</a>, , <a href=\"https://truyenchu.com.vn/the-loai/he-thong\">truyện hệ thống</a> hay&nbsp;<a href=\"https://truyenchu.com.vn/the-loai/ngon-tinh\">truyện Ngôn Tình</a>&nbsp;một cách nhanh nhất. Hỗ trợ mọi thiết bị như di động và máy tính bảng.</p><p><a href=\"https://truyenchu.vn/\">Truyenchu</a>, <a href=\"https://truyenchu.vn/danh-sach/truyen-full\">truyenfull</a>, <a href=\"https://quykiep.com/\">lightnovel</a>, <a href=\"https://quykiep.com/truyen-full-ds\">truyen full</a></p><p><a href=\"https://truyenchu.com.vn/dieu-khoan-dich-vu\">Điều khoản dịch vụ</a><a href=\"https://truyenchu.com.vn/ve-chung-toi\">Về chúng tôi</a><a href=\"https://truyenchu.com.vn/lien-he\">Liên hệ</a></p>', 1, '2025-07-04 13:23:52'),
(12, 10, 'Chương 2 : Khởi Nguyên ', '<figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Bức Thư Tình Số 32 - Đan Thanh Thủ\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/buc-thu-tinh-so-32-dan-thanh-thu.html\">Bức Thư Tình Số 32 - Đan Thanh Thủ</a></h3><p>Thể loại Nguyên sang hiện đại tình cảm lãng mạn song khiết HE Giới thiệu:&nbsp; Hồi cấp ba Hạ Mộ từng thích Tống Phục Hành học thần của trường Cô viết rất nhiều thư tình đến nỗi cô trở thành hình tượng phản diện kinh điển chuyên “ăn thịt thiên</p><p>94 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Tình Huống Thay Đổi - Phẩm Phong\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/tinh-huong-thay-doi-pham-phong.html\">Tình Huống Thay Đổi - Phẩm Phong</a></h3><p>Tình huống thay đổi Tác giả Phẩm Phong Editor:&nbsp;Fluoxetine Bìa:&nbsp;Lariol Thể loại:&nbsp;Ngôn tình hiện đại tình cảm tái sinh trưởng thành tâm lý xã hội HE Nữ chính Lý Văn Văn tái sinh vào cơ thể của một người phụ nữ chính đã chết cùng thời điểm với cô Trình</p><p>32 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Hạ Nhật Kiến Nam Tường – Điềm Thiểm\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/ha-nhat-kien-nam-tuong-diem-thiem.html\">Hạ Nhật Kiến Nam Tường – Điềm Thiểm</a></h3><p>Thể loại:&nbsp;Ngôn tình Hiện đại Một lòng một dạ Ngọt ngào Vườn trường Thiên kiêu chi tử 1vs1 Song xử HE.&nbsp; Giới thiệu:&nbsp; Thiên kim thật sáng suốt trong mắt toàn là tình yêu 🆚 Thiếu gia hiếu thắng cuối cùng bị đả kích bởi nữ chính Vào ngày cô</p><p>80 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Ve Sầu Mùa Hạ Lắng Nghe Tuyết Tan\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/ve-sau-mua-ha-lang-nghe-tuyet-tan.html\">Ve Sầu Mùa Hạ Lắng Nghe Tuyết Tan</a></h3><p>⚘Tên gốc 夏蝉听雪 ⚘Tác giả Lê Trì ⚘Số chương 74 chương 20 NT ⚘Thể loại Thanh xuân học đường nữ yêu thầm cứu rỗi chữa lành HE ⚘CP Ôn Tuyết Ninh nữ Lục Từ nam ⚘Editor Cá Voi Mây GIỚI THIỆU Ôn Tuyết Ninh thầm thích một người Anh ấy</p><p>95 chương</p><p><a href=\"https://truyenchu.com.vn/dong-nhan\">Đồng nhân</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Thỏ Thỏ Phải Làm Đại Kiếm Tiên\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/tho-tho-phai-lam-dai-kiem-tien.html\">Thỏ Thỏ Phải Làm Đại Kiếm Tiên</a></h3><p>Bị hiểu nhầm là không được kỳ thực rất được trí tuyệt công Yến Phi Độ)&nbsp;x&nbsp;Ngốc nghếch mỹ nhân làm nũng thỏ thỏ thụ Hàn Giang Tuyết ______ Văn án Tiểu thỏ tinh Hàn Giang Tuyết vẫn luôn mơ ước được bái nhập môn phái Đào Hoa Lạc trở thành</p><p>107 chương</p><p><a href=\"https://truyenchu.com.vn/tien-hiep\">Tiên hiệp</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Lại Không Thức Tỉnh, Nam Nhân Của Cậu Sẽ Bỏ Chạy\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/lai-khong-thuc-tinh-nam-nhan-cua-cau-se-bo-chay.html\">Lại Không Thức Tỉnh, Nam Nhân Của Cậu Sẽ Bỏ Chạy</a></h3><p>Giới thiệu Bạn trai như nước chảy trúc mã làm bằng sắt Thế gian nhiều gay trúc mã không cho phao Khả năng Lâm Thu Úc bị ám rồi mỗi lần cho rằng bản thân đã tìm được chân mệnh thiên tử kết quả không đến một tháng đã bị</p><p>15 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Từ Đó, Kinh Thành Chẳng Còn Mùa Đông\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/tu-do-kinh-thanh-chang-con-mua-dong.html\">Từ Đó, Kinh Thành Chẳng Còn Mùa Đông</a></h3><p>Thiếu gia Giang Chi Dao lại nổi tính công tử Hắn không chịu đọc sách còn hắt mực lên mặt ta Không chút nể nang mắng ta “Ngươi là một con câm thối không cha không mẹ!” “Cũng đòi bắt chước người ta mơ gả cho trạng nguyên lang?!” “Không</p><p>11 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Ánh Trăng Treo Ngoài Cửa Sổ\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/anh-trang-treo-ngoai-cua-so.html\">Ánh Trăng Treo Ngoài Cửa Sổ</a></h3><p>Kiếp trước ta từng cứu một nam nhân toàn thân đầy thương tích Yến Bắc Lục Hắn trở thành tể tướng đương triều cưới ta làm thê nhưng lại chưa từng chân thật gần gũi Khi ấy ta ngây ngô cho rằng hắn chỉ là người lãnh đạm không giỏi</p><p>34 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Tổng Tài &quot;Bắt Gian&quot; Ngược\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/tong-tai-bat-gian-nguoc.html\">Tổng Tài \"Bắt Gian\" Ngược</a></h3><p>Để giúp một cô nàng con nhà giàu bắt gian vị hôn phu tổng tài của cô ta tôi phục kích tuyến đường quen thuộc của anh ta bám theo như điên Cuối cùng sau khi trà trộn thành nhân viên phục vụ khách sạn tôi cũng chụp được ảnh</p><p>19 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:300/416;\" src=\"https://truyenchu.com.vn/images/no-image.webp\" alt=\"Sau Khi Bị Đọc Tâm, Tôi Trở Thành Con Cưng Của Cả Nhà\" srcset=\"/images/no-image.webp 1x, /images/no-image.webp 2x\" sizes=\"100vw\" width=\"300\" height=\"416\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/sau-khi-bi-doc-tam-toi-tro-thanh-con-cung-cua-ca-nha.html\">Sau Khi Bị Đọc Tâm, Tôi Trở Thành Con Cưng Của Cả Nhà</a></h3><p>Nguyễn Sơ Đường xuyên sách rồi Hơn nữa còn là truyện niên đại nghèo rớt mồng tơi cha mẹ đều là thanh niên trí thức xuống nông thôn bữa đói bữa no Nhìn người cha sắp ngỏm củ tỏi Nguyễn Sơ Đường không nhịn được mà thầm than trong lòng</p><p>58 chương</p><p><a href=\"https://truyenchu.com.vn/dong-nhan\">Đồng nhân</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Thập Niên 90: Nhờ Khả Năng Đọc Suy Nghĩ Cô Trở Thành Thần Thám\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/thap-nien-90-nho-kha-nang-doc-suy-nghi-co-tro-thanh-than-tham.html\">Thập Niên 90: Nhờ Khả Năng Đọc Suy Nghĩ Cô Trở Thành Thần Thám</a></h3><p>Năm 1991 Triệu Hướng Vãn thi đỗ vào Đại học Công an tỉnh Hồ Nam Tiếng gõ cửa lúc nửa đêm đã cuốn cô vào một câu chuyện gia đình đầy máu chó Con gái nuôi 11 tuổi tên là Mai Mai đã làm em gái bị lạc mất Người</p><p>150 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Xuyên thư chi ta ở be văn cứu vớt mỹ cường thảm nam chủ \" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/xuyen-thu-chi-ta-o-be-van-cuu-vot-my-cuo.html\">Xuyên thư chi ta ở be văn cứu vớt mỹ cường thảm nam chủ</a></h3><p>Tác phẩm tóm tắt song nam chủ xuyên thư cường cường chủ chịu song mối tình đầu HE】 thanh lãnh ôn nhu đại mỹ nhân VS mỹ cường thảm khốc ca nam chủ Tạ khi hơi tài mạo song tuyệt vốn là thiên chi kiêu tử lại bởi vì bệnh</p><p>386 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Ký Sự Thăng Tiến Của Bà Mẹ Kế Trẻ\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/ky-su-thang-tien-cua-ba-me-ke-tre.html\">Ký Sự Thăng Tiến Của Bà Mẹ Kế Trẻ</a></h3><p>Năm Thẩm Yếm Ly tròn hai mươi tuổi Ta một công cụ hình người một bà mẹ kế trẻ coi như đã làm tròn bổn phận Ta quay lại nghề cũ quyến rũ lão Thượng thư góa vợ có hai đứa con Thượng thư bị ta trêu chọc đến mê</p><p>17 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Không Làm Pháo Hôi Lụy Tình\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/khong-lam-phao-hoi-luy-tinh.html\">Không Làm Pháo Hôi Lụy Tình</a></h3><p>Thể loại Nguyên sang Đam mỹ Hiện đại HE Tình cảm Ngọt sủng Xuyên thư Vườn trường Chủ thụ Sảng văn 1v1 Giới thiệu:&nbsp; Khi Tạ Nguyễn tỉnh dậy cậu phát hiện thế giới mình đang là một cuốn tiểu thuyết đam mỹ thanh xuân vườn trường Còn cậu lại</p><p>99 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Ta Nguyện Cưỡi Gió Đạp Mây\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/ta-nguyen-cuoi-gio-dap-may.html\">Ta Nguyện Cưỡi Gió Đạp Mây</a></h3><p>Thể loại:&nbsp;Cổ đại chút huyền huyễn chút trinh thám ngọt sủng hài hước HE Giới thiệu Tạ Thừa Phong đang rất tức giận hắn bị người khác ám hại Tin tốt là Hắn chưa chết Tin xấu là Sống còn thảm hơn chết Nhân vật chính Thẩm Gia Gia vs</p><p>41 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Dỗ Dành Em Đi - Nịnh Lộc\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/do-danh-em-di-ninh-loc.html\">Dỗ Dành Em Đi - Nịnh Lộc</a></h3><p>Thể loại Đam mỹ hiện đại song hướng yêu thầm thanh xuân vườn trường HE GIỚI THIỆU Dụ Nhiên thích thầm cậu bạn thanh mai trúc mã từ lâu lắm rồi mà chẳng hề hay biết Cũng chính vì vậy gu thẩm mỹ của cậu chàng cứ thế bị “đóng</p><p>21 chương</p><p><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Nhiếp Chính Vương Đòi Hủy Diệt Thế Giới\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/nhiep-chinh-vuong-doi-huy-diet-the-gioi.html\">Nhiếp Chính Vương Đòi Hủy Diệt Thế Giới</a></h3><p>Trưởng tỷ trà xanh vì mong muốn thăng quan tiến chức nhân lúc Nhiếp chính vương say rượu đã thẳng tay dùng ba gói thôi tình tán Nhiếp chính vương phát cuồng suốt một đêm sáng hôm sau lập tức dẫn theo mấy ngàn tướng sĩ vây chặt Giang phủ</p><p>20 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Giang Thắng Hàn - Nhất Chỉ Khí Thủy Hùng\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/giang-thang-han-nhat-chi-khi-thuy-hung.html\">Giang Thắng Hàn - Nhất Chỉ Khí Thủy Hùng</a></h3><p>Ta từng hai lần che chắn mũi kiếm thay cho Tần Phóng Cả hai lần đều suýt mất mạng Vậy mà hắn lại đem ta ra làm vật cá cược rồi khi bị thua ta phải gả cho người khác làm thiếp Chỉ vì hắn sắp thành thân tân nương</p><p>12 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Chiếc Quạt Xương\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/chiec-quat-xuong.html\">Chiếc Quạt Xương</a></h3><p>Ta đã chec dưới tay nữ nhân được Dung Cảnh cưng chiều nhất rồi bị làm thành chiếc quạt xương Minh Giới ta ngày đêm đứng canh bên cầu đợi hắn ta đợi mười hai năm vẫn không thấy nhưng lại đợi được nữ nhân đó Buồn cười thay ngay</p><p>16 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><figure class=\"image\"><img style=\"aspect-ratio:192/256;\" src=\"data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27192%27%20height=%27256%27/%3e\" alt=\"\" width=\"192\" height=\"256\"></figure><figure class=\"image\"><img style=\"aspect-ratio:1/1;\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" alt=\"Gả Cho Lương An\" width=\"1\" height=\"1\"></figure><h3><a href=\"https://truyenchu.com.vn/truyen/ga-cho-luong-an.html\">Gả Cho Lương An</a></h3><p>Ta là thứ nữ của nhà họ Lưu Vốn dĩ chỉ định tùy tiện gả cho một người nào đó là xong Nào ngờ hôn phu của trưởng tỷ lại gặp chuyện trúng độc ngã ngựa trở thành một kẻ vừa bệnh vừa tàn phế Tỷ ấy sống chết không</p><p>10 chương</p><p><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a></p><p>Đang hiển thị 1 đến 20 của 43.244 kết quả</p><p><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac\">1</a><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac?page=2\">2</a><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac?page=3\">3</a><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac?page=4\">4</a><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac?page=5\">5</a><a href=\"https://truyenchu.com.vn/danh-sach/ngon-tinh-sac?page=2\">Sau</a></p><p>GO</p><p>Sắp xếp theo</p><p><a href=\"https://truyenchu.com.vn/ngon-tinh?sort=moi-cap-nhat\">Mới cập nhật</a><a href=\"https://truyenchu.com.vn/ngon-tinh\">Mới đăng</a><a href=\"https://truyenchu.com.vn/ngon-tinh?sort=doc-nhieu\">Xem nhiều</a><a href=\"https://truyenchu.com.vn/ngon-tinh?sort=so-chuong-tang\">Số chương</a><a href=\"https://truyenchu.com.vn/ngon-tinh?sort=danh-gia-cao\">Đánh giá</a></p><p>Đã chọn</p><p><a href=\"https://truyenchu.com.vn/ngon-tinh\">Ngôn tình</a><a href=\"https://truyenchu.com.vn/sac\">Sắc</a></p><p>Thể loại</p><p><a href=\"https://truyenchu.com.vn/tien-hiep\">Tiên hiệp</a><a href=\"https://truyenchu.com.vn/huyen-huyen\">Huyền huyễn</a><a href=\"https://truyenchu.com.vn/khoa-huyen\">Khoa huyễn</a><a href=\"https://truyenchu.com.vn/vong-du\">Võng du</a><a href=\"https://truyenchu.com.vn/do-thi\">Đô thị</a><a href=\"https://truyenchu.com.vn/dong-nhan\">Đồng nhân</a><a href=\"https://truyenchu.com.vn/da-su\">Dã sử</a><a href=\"https://truyenchu.com.vn/canh-ky\">Cạnh kỹ</a><a href=\"https://truyenchu.com.vn/huyen-nghi\">Huyền nghi</a><a href=\"https://truyenchu.com.vn/kiem-hiep\">Kiếm hiệp</a><a href=\"https://truyenchu.com.vn/ky-ao\">Kỳ ảo</a><a href=\"https://truyenchu.com.vn/sac\">Sắc</a><a href=\"https://truyenchu.com.vn/ngon-tinh\">Ngôn tình</a><a href=\"https://truyenchu.com.vn/dam-my\">Đam mỹ</a><a href=\"https://truyenchu.com.vn/bach-hop\">Bách Hợp</a><a href=\"https://truyenchu.com.vn/truyen-teen\">Truyện Teen</a><a href=\"https://truyenchu.com.vn/light-novel\">Light Novel</a></p><p>Bối cảnh thế giới</p><p>Lưu phái</p>', 1, '2025-07-04 13:25:42');

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `id` int(11) NOT NULL,
  `truyen_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `so_sao` int(11) NOT NULL CHECK (`so_sao` between 1 and 5),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`id`, `truyen_id`, `user_id`, `so_sao`, `created_at`) VALUES
(14, 9, 1, 4, '2025-07-05 04:08:36');

-- --------------------------------------------------------

--
-- Table structure for table `truyen`
--

CREATE TABLE `truyen` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tieu_de` varchar(255) NOT NULL,
  `tac_gia` varchar(255) NOT NULL,
  `anh_bia` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `the_loai` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `truyen`
--

INSERT INTO `truyen` (`id`, `user_id`, `tieu_de`, `tac_gia`, `anh_bia`, `mo_ta`, `the_loai`, `created_at`) VALUES
(6, 1, 'Ongo lão đánh cá và con cá đỏ', 'phạm tấn phát', NULL, 'test', 'Tiên Hiệp, Cạnh Kỹ', '2025-07-02 11:19:33'),
(7, 1, 'Hành Trình Của Người Anh Hùng', 'sdassd', 'uploads/6865535c93a79.png', 'ádsad', 'Tiên Hiệp, Huyền Huyễn, Thần Thoại Tu Chân', '2025-07-02 11:19:45'),
(9, 1, 'Naruto ', 'aNH LONG', 'uploads/6865538ea486f_1751470990.png', '', 'Tiên Hiệp, Huyền Huyễn, Huyền Nghi, Thần Thoại Tu Chân', '2025-07-02 15:43:10'),
(10, 2, 'ANH ,LONG', 'PHATS ', 'uploads/6867d6254ac84.jpg', 'SDSFSFSDSSSS', 'Tiên Hiệp, Huyền Huyễn, Cạnh Kỹ, Thần Thoại Tu Chân', '2025-07-04 13:23:52');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1, 'anhlong@gmail.com', '$2y$10$sSK3SXj1gpz5Gg6Zv/lo5uqTX/TrXkQ3e592iFbD1dsjoEKhBcA2q', '2025-07-01 15:31:45'),
(2, 'phat@gmail.com', '$2y$10$rca6hVHtPu0wwTSW8x3bM.G8F2Ri70bPt9V3ag2c.tNg6115OkyIW', '2025-07-04 13:17:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `binh_luan`
--
ALTER TABLE `binh_luan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chuong`
--
ALTER TABLE `chuong`
  ADD PRIMARY KEY (`id`),
  ADD KEY `truyen_id` (`truyen_id`);

--
-- Indexes for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `truyen_id` (`truyen_id`,`user_id`),
  ADD UNIQUE KEY `unique_user_truyen` (`truyen_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `truyen`
--
ALTER TABLE `truyen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `binh_luan`
--
ALTER TABLE `binh_luan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `chuong`
--
ALTER TABLE `chuong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `truyen`
--
ALTER TABLE `truyen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chuong`
--
ALTER TABLE `chuong`
  ADD CONSTRAINT `chuong_ibfk_1` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `truyen`
--
ALTER TABLE `truyen`
  ADD CONSTRAINT `truyen_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
