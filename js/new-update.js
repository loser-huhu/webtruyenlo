// Hàm render phần "Mới cập nhật"
function renderUpdateList(novels) {
  const container = document.getElementById("updateContainer");
  const skeleton = document.getElementById("updateSkeleton");

  // Ẩn hiệu ứng skeleton loading
  skeleton.classList.add("d-none");
  container.innerHTML = "";

  novels.forEach((novel) => {
    const novelLink = document.createElement("a");
    novelLink.href = novel.link;
    novelLink.target = "_blank";
    novelLink.className = "update-link";

    const updateRow = document.createElement("div");
    updateRow.className = "update-row";

    // Lấy thể loại đầu tiên
    const firstCategory = novel.the_loai.split(",")[0].trim();

    // Format thời gian (giả sử dữ liệu có trường update_time)
    // Nếu không có, dùng giá trị mặc định
    const updateTime = novel.update_time || "8 giờ trước";

    updateRow.innerHTML = `
      <div class="novel-category">${firstCategory}</div>
      <div class="novel-title">${novel.ten}</div>
      <div class="novel-chapter">${novel.so_chuong}</div>
      <div class="novel-author">${novel.tac_gia || "Đang cập nhật"}</div>
      <div class="update-time">${updateTime}</div>
    `;

    novelLink.appendChild(updateRow);
    container.appendChild(novelLink);
  });
}

// Cập nhật hàm loadNovelData
async function loadNovelData() {
  try {
    // Load dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    const data = await response.json();

    // Lấy dữ liệu cho phần Biên tập viên đề cử
    const editorPicksData = data["Biên tập viên đề cử"];

    // Lấy dữ liệu cho phần Đang đọc (chỉ lấy 7 truyện đầu)
    const readingNowData = data["Đang đọc"].slice(0, 7);

    // Lấy dữ liệu cho phần Mới cập nhật (lấy 10 truyện đầu)
    const updateData = data["Mới cập nhật"].slice(0, 10);

    // Render cả ba phần
    renderEditorPicks(editorPicksData);
    renderReadingNow(readingNowData);
    renderUpdateList(updateData);
  } catch (error) {
    console.error("❌ Lỗi khi tải dữ liệu truyện:", error);
    // Ẩn hiệu ứng skeleton khi có lỗi
    document.getElementById("skeletonLoader").classList.add("d-none");
    document.getElementById("readingSkeleton").classList.add("d-none");
    document.getElementById("updateSkeleton").classList.add("d-none");
  }
}

// Đảm bảo gọi hàm loadNovelData khi DOM đã tải xong
document.addEventListener("DOMContentLoaded", () => {
  loadNovelData();

  // Hiệu ứng đổ bóng khi hover vào container (nếu cần)
  const containers = document.querySelectorAll(
    ".editor-container, .update-container"
  );
  containers.forEach((container) => {
    container.addEventListener("mouseenter", () => {
      container.style.boxShadow = "0 25px 50px -12px rgba(0, 0, 0, 0.25)";
    });

    container.addEventListener("mouseleave", () => {
      container.style.boxShadow = "0 4px 12px rgba(0, 0, 0, 0.05)";
    });
  });
});
