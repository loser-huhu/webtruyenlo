<?php
session_start();
require_once("auth/db.php");

// Lấy ID truyện
$truyen_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($truyen_id <= 0) die("Thiếu hoặc sai ID truyện");

// Lấy điểm đánh giá trung bình và số lượt đánh giá
$stmt = $conn->prepare("SELECT ROUND(AVG(so_sao),1) AS diem_tb, COUNT(*) AS so_luot FROM danh_gia WHERE truyen_id = ?");
$stmt->bind_param("i", $truyen_id);
$stmt->execute();
$ratingData = $stmt->get_result()->fetch_assoc();
$stmt->close();

$diemTB = $ratingData['diem_tb'] ?? 0;
$soLuot = $ratingData['so_luot'] ?? 0;

// Lấy thông tin truyện
$stmt = $conn->prepare("SELECT * FROM truyen WHERE id = ?");
$stmt->bind_param("i", $truyen_id);
$stmt->execute();
$truyen = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$truyen) die("Không tìm thấy truyện");

// Lấy danh sách chương
$stmt = $conn->prepare("SELECT * FROM chuong WHERE truyen_id = ? ORDER BY thu_tu ASC");
$stmt->bind_param("i", $truyen_id);
$stmt->execute();
$chapters = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

// Kiểm tra đăng nhập
$isLoggedIn = isset($_SESSION['user']);

// Xử lý bình luận
if ($isLoggedIn && isset($_POST['submit_comment'])) {
    $noi_dung = trim($_POST['noi_dung']);
    $userEmail = $_SESSION['user'];

    $stmtUser = $conn->prepare("SELECT id FROM users WHERE email = ?");
    $stmtUser->bind_param("s", $userEmail);
    $stmtUser->execute();
    $resultUser = $stmtUser->get_result();

    if ($userRow = $resultUser->fetch_assoc()) {
        $userId = $userRow['id'];
        $stmt = $conn->prepare("INSERT INTO binh_luan (truyen_id, user_id, noi_dung) VALUES (?, ?, ?)");
        $stmt->bind_param("iis", $truyen_id, $userId, $noi_dung);
        $stmt->execute();
        $stmt->close();
    }
    $stmtUser->close();
    header("Location: xemtruyen.php?id=" . $truyen_id);
    exit;
}

// Lấy danh sách bình luận
$stmt = $conn->prepare("
    SELECT binh_luan.noi_dung, binh_luan.created_at, users.email 
    FROM binh_luan 
    JOIN users ON binh_luan.user_id = users.id 
    WHERE binh_luan.truyen_id = ? 
    ORDER BY binh_luan.created_at DESC
");
$stmt->bind_param("i", $truyen_id);
$stmt->execute();
$comments = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$conn->close();
?>


<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?= htmlspecialchars($truyen['tieu_de']) ?> - Truyện chữ</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
    />
    <style>
      :root {
        --primary-color: #14425d;
        --primary-hover: #1e6b94;
        --text-color: #333;
        --text-secondary: #666;
        --light-bg: #f9fafb;
        --card-bg: #fff;
        --border-color: #eaeaea;
        --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }

      body {
        background-color: #f5f7fa;
        color: var(--text-color);
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }

      .novel-header {
        background: linear-gradient(
          135deg,
          var(--primary-color) 0%,
          #0d2b3e 100%
        );
        color: white;
        border-radius: 10px;
        box-shadow: var(--shadow);
        padding: 25px;
        margin-bottom: 30px;
      }

      .novel-cover {
        border-radius: 8px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        height: 350px;
        object-fit: cover;
        width: 100%;
      }

      .novel-title {
        font-size: 2.2rem;
        font-weight: 800;
        margin-bottom: 15px;
      }

      .novel-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-bottom: 20px;
      }

      .meta-item {
        background: rgba(255, 255, 255, 0.15);
        border-radius: 20px;
        padding: 8px 16px;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .rating-stars {
        color: #ffc107;
        margin-right: 8px;
      }

      .btn-read {
        background-color: #ff6b35;
        border: none;
        font-weight: 600;
        padding: 12px 28px;
        font-size: 1.1rem;
        border-radius: 8px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .btn-read:hover {
        background-color: #e55a2a;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
      }

      .btn-bookmark {
        background-color: rgba(255, 255, 255, 0.15);
        color: white;
        border: 1px solid rgba(255, 255, 255, 0.3);
        font-weight: 500;
        padding: 12px 24px;
        border-radius: 8px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .btn-bookmark:hover {
        background-color: rgba(255, 255, 255, 0.25);
      }

      .section-title {
        position: relative;
        padding-bottom: 12px;
        margin-bottom: 25px;
        font-weight: 700;
        color: var(--primary-color);
      }

      .section-title::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 4px;
        background: var(--primary-color);
        border-radius: 2px;
      }

      .novel-description {
        line-height: 1.8;
        font-size: 1.05rem;
        color: var(--text-secondary);
      }

      .chapters-container {
        background-color: var(--card-bg);
        border-radius: 10px;
        box-shadow: var(--shadow);
        padding: 25px;
        margin-bottom: 30px;
      }

      .chapters-list {
        list-style: none;
        padding: 0;
        margin: 0;
      }

      .chapter-item {
        padding: 14px 16px;
        border-bottom: 1px solid var(--border-color);
        transition: all 0.2s;
      }

      .chapter-item:hover {
        background-color: rgba(20, 66, 93, 0.05);
      }

      .chapter-item a {
        color: var(--text-color);
        text-decoration: none;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .chapter-item:hover a {
        color: var(--primary-color);
      }

      .chapter-date {
        font-size: 0.9rem;
        color: var(--text-secondary);
      }

      .comments-section {
        background-color: var(--card-bg);
        border-radius: 10px;
        box-shadow: var(--shadow);
        padding: 30px;
      }

      .comment-form {
        background-color: var(--light-bg);
        border-radius: 8px;
        padding: 25px;
        margin-bottom: 30px;
      }

      .form-control {
        border: 1px solid var(--border-color);
        border-radius: 8px;
        padding: 14px;
        font-size: 1rem;
      }

      .form-control:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(20, 66, 93, 0.2);
      }

      .btn-submit {
        background-color: var(--primary-color);
        color: white;
        padding: 12px 28px;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        transition: all 0.3s;
      }

      .btn-submit:hover {
        background-color: var(--primary-hover);
      }

      .login-required {
        background-color: var(--light-bg);
        border: 1px solid var(--border-color);
        border-radius: 8px;
        padding: 25px;
        text-align: center;
      }

      .login-link {
        color: var(--primary-color);
        font-weight: 600;
        text-decoration: none;
      }

      .comment-item {
        padding: 20px;
        border-bottom: 1px solid var(--border-color);
      }

      .comment-header {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
      }

      .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: var(--primary-color);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        margin-right: 12px;
      }

      .comment-content {
        padding-left: 52px;
      }

      .comment-date {
        font-size: 0.85rem;
        color: var(--text-secondary);
      }

      @media (max-width: 768px) {
        .novel-title {
          font-size: 1.8rem;
        }

        .novel-cover {
          height: 280px;
          margin-bottom: 20px;
        }

        .btn-read,
        .btn-bookmark {
          width: 100%;
          justify-content: center;
          margin-bottom: 10px;
        }
      }
    </style>
  </head>
  <body>
    <div class="container py-4">
      <!-- Breadcrumb -->
      <nav class="mb-4">
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="index.html"><i class="fas fa-home me-1"></i> Trang chủ</a>
          </li>
          <li class="breadcrumb-item">
            <a href="quan_ly_truyen.html">Truyện</a>
          </li>
          <li class="breadcrumb-item active">
            <?= htmlspecialchars($truyen['tieu_de']) ?>
          </li>
        </ol>
      </nav>

      <!-- Novel header -->
      <div class="novel-header">
        <div class="row align-items-center">
          <div class="col-md-4 mb-4 mb-md-0">
            <img
              src="<?= htmlspecialchars($truyen['anh_bia'] ?: 'https://via.placeholder.com/300x400/14425d/ffffff?text=Không+có+ảnh') ?>"
              alt="<?= htmlspecialchars($truyen['tieu_de']) ?>"
              class="novel-cover"
            />
          </div>
          <div class="col-md-8">
            <h1 class="novel-title">
              <?= htmlspecialchars($truyen['tieu_de']) ?>
            </h1>

            <div class="novel-meta">
              <div class="meta-item">
                <i class="fas fa-user"></i>
                <span><?= htmlspecialchars($truyen['tac_gia']) ?></span>
              </div>
              <div class="meta-item">
                <i class="fas fa-bookmark"></i>
                <span><?= htmlspecialchars($truyen['the_loai']) ?></span>
              </div>
              <div class="meta-item">
                <i class="fas fa-sync-alt"></i>
                <span><?= count($chapters) ?> chương</span>

              </div>
            </div>

<div class="d-flex align-items-center mb-4"> 
  <div class="rating-stars" data-truyen-id="<?= $truyen['id'] ?>">
    <?php
    $filledStars = floor($diemTB);
    $halfStar = ($diemTB - $filledStars) >= 0.5;
    for ($i = 1; $i <= 5; $i++) {
        if ($i <= $filledStars) {
            echo '<i class="fas fa-star" data-star="' . $i . '"></i>';
        } elseif ($i === $filledStars + 1 && $halfStar) {
            echo '<i class="fas fa-star-half-alt" data-star="' . $i . '"></i>';
        } else {
            echo '<i class="far fa-star" data-star="' . $i . '"></i>';
        }
    }
    ?>
  </div>
  <div class="text-white ms-2"><?= $diemTB ?>/5 (<?= $soLuot ?> đánh giá)</div>
</div>




            <div class="d-flex flex-wrap gap-3">
              <?php if (!empty($chapters)): ?>
              <a
                href="doc_chuong.php?id=<?= $chapters[0]['id'] ?>"
                class="btn btn-read"
              >
                <i class="fas fa-book-reader"></i> Đọc truyện
              </a>
              <?php else: ?>
              <button class="btn btn-read" disabled>
                <i class="fas fa-book-reader"></i> Chưa có chương
              </button>
              <?php endif; ?>

              <button class="btn btn-bookmark">
                <i class="fas fa-bookmark"></i> Đánh dấu
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Giới thiệu truyện -->
      <div class="bg-white rounded-3 shadow p-4 mb-4">
        <h2 class="section-title">Giới thiệu truyện</h2>
        <div class="novel-description">
  <?php
    $mo_ta = trim($truyen['mo_ta'] ?? '');
    if ($mo_ta !== '') {
        echo nl2br(htmlspecialchars($mo_ta));
    } else {
        echo '<i>Chưa có mô tả cho truyện này.</i>';
    }
  ?>
</div>
      </div>

      <!-- Danh sách chương -->
      <div class="chapters-container">
        <h2 class="section-title">Danh sách chương</h2>

        <?php if (!empty($chapters)): ?>
        <ul class="chapters-list">
          <?php foreach ($chapters as $chapter): ?>
          <li class="chapter-item">
            <a href="doc_chuong.php?id=<?= $chapter['id'] ?>">
              <span
                >Chương
                <?= $chapter['thu_tu'] ?>:
                <?= htmlspecialchars($chapter['tieu_de']) ?></span
              >
              <span class="chapter-date"
                ><?= date('d/m/Y', strtotime($chapter['created_at'])) ?></span
              >
            </a>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php else: ?>
        <div class="text-center py-4">
          <i class="fas fa-book fa-3x text-muted mb-3"></i>
          <h4>Chưa có chương nào</h4>
          <p class="text-muted">Truyện này chưa có chương nào được đăng tải.</p>
        </div>
        <?php endif; ?>
      </div>
<!-- Đánh giá trung bình và form đánh giá sao -->
<div class="text-center my-4">
  <!-- Đánh giá trung bình -->
  <p class="text-dark mb-3 fw-semibold" id="avg-rating-text">
    <?php if ($soLuot > 0): ?>
      Truyện này được đánh giá trung bình là <strong><?= $diemTB ?>/5 sao</strong> từ <strong><?= $soLuot ?></strong> người đọc.
    <?php else: ?>
      Truyện này chưa có đánh giá nào.
    <?php endif; ?>
  </p>

  <!-- Giao diện đánh giá sao -->
  <?php if ($isLoggedIn): ?>
    <div class="user-rating-stars d-inline-block" data-truyen-id="<?= $truyen_id ?>">
      <label class="text-dark fw-bold d-block mb-2">Bạn muốn đánh giá mấy sao?</label>
      <?php for ($i = 1; $i <= 5; $i++): ?>
        <i class="far fa-star text-warning fs-4 mx-1" data-star="<?= $i ?>"></i>
      <?php endfor; ?>
    </div>
  <?php else: ?>
    <p class="text-muted fst-italic">Bạn cần <a href="dang_nhap.php">đăng nhập</a> để đánh giá truyện này.</p>
  <?php endif; ?>
</div>

      <!-- Bình luận -->
       
      <div class="comments-section">
        <h2 class="section-title">Bình luận truyện</h2>

        <!-- Form bình luận -->
        <div class="comment-form">
          <?php if ($isLoggedIn): ?>
          <form method="POST">
            <div class="mb-3">
              <label class="form-label fw-bold mb-2"
                >Viết bình luận của bạn:</label
              >
              <textarea
                class="form-control"
                name="noi_dung"
                rows="4"
                placeholder="Viết bình luận tại đây..."
                required
              ></textarea>
            </div>
            <button type="submit" name="submit_comment" class="btn btn-submit">
              <i class="fas fa-paper-plane me-2"></i> Gửi bình luận
            </button>
          </form>
          <?php else: ?>
          <div class="login-required">
            <i class="fas fa-user-lock fa-2x text-primary mb-3"></i>
            <h4 class="mb-3">Bạn cần đăng nhập để bình luận</h4>
            <p>
              Vui lòng
              <a href="dang_nhap.php" class="login-link">đăng nhập</a> hoặc
              <a href="dang_ky.php" class="login-link">đăng ký</a> tài khoản để
              tham gia bình luận.
            </p>
          </div>
          <?php endif; ?>
        </div>

        <!-- Danh sách bình luận -->
        <div id="commentsList">
          <?php if (!empty($comments)): ?>
          <?php foreach ($comments as $comment): ?>
          <div class="comment-item">
            <div class="comment-header">
              <div class="user-avatar">
                <?= strtoupper(substr($comment['email'], 0, 1)) ?>
              </div>
              <div>
                <h5 class="mb-0"><?= htmlspecialchars($comment['email']) ?></h5>
                <small class="comment-date"
                  ><?= date('d/m/Y H:i', strtotime($comment['created_at'])) ?></small
                >
              </div>
            </div>
            <div class="comment-content">
              <p><?= nl2br(htmlspecialchars($comment['noi_dung'])) ?></p>
            </div>
          </div>
          <?php endforeach; ?>
          <?php else: ?>
          <div class="text-center py-4">
            <i class="fas fa-comments fa-3x text-muted mb-3"></i>
            <h4>Chưa có bình luận nào</h4>
            <p class="text-muted">
              Hãy là người đầu tiên bình luận về truyện này.
            </p>
          </div>
          <?php endif; ?>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.querySelectorAll(".user-rating-stars i").forEach(star => {
  star.addEventListener("click", () => {
    const rating = parseInt(star.dataset.star);
    const container = star.closest(".user-rating-stars");
    const truyenId = parseInt(container.dataset.truyenId);

    fetch("api/gui_danh_gia.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ truyen_id: truyenId, so_sao: rating })
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert(`Cảm ơn bạn đã đánh giá ${rating} sao!`);

        // Highlight ngôi sao vừa đánh giá
        container.querySelectorAll("i").forEach((icon, idx) => {
          icon.className = idx < rating ? "fas fa-star text-warning fs-4 me-1" : "far fa-star text-warning fs-4 me-1";
        });

        // Cập nhật đánh giá trung bình
        fetch(`api/lay_danh_gia.php?id=${truyenId}`)
          .then(res => res.json())
          .then(newData => {
            if (newData.success) {
              const text = document.getElementById("avg-rating-text");
              if (text) {
                text.textContent = `Truyện này được đánh giá trung bình là ${newData.diem_tb}/5 sao từ ${newData.so_luot} người đọc.`;
              }
            }
          });
      } else {
        alert("Lỗi: " + (data.message || "Không rõ nguyên nhân"));
      }
    })
    .catch(err => {
      console.error("Lỗi gửi đánh giá:", err);
      alert("Không thể gửi đánh giá.");
    });
  });
});
</script>



  </body>
</html>
