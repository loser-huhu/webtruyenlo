// Hàm load dữ liệu từ JSON và render giao diện
async function loadNovelData() {
  try {
    // Load dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    const data = await response.json();

    // Lấy dữ liệu cho phần Biên tập viên đề cử
    const editorPicksData = data["Biên tập viên đề cử"];

    // Lấy dữ liệu cho phần Đang đọc (chỉ lấy 7 truyện đầu)
    const readingNowData = data["Đang đọc"].slice(0, 7);

    // Render cả hai phần
    renderEditorPicks(editorPicksData);
    renderReadingNow(readingNowData);
  } catch (error) {
    console.error("❌ Lỗi khi tải dữ liệu truyện:", error);
    // Ẩn hiệu ứng skeleton khi có lỗi
    document.getElementById("skeletonLoader").classList.add("d-none");
    document.getElementById("readingSkeleton").classList.add("d-none");
  }
}

// Hàm render phần "Biên tập viên đề cử"
function renderEditorPicks(novels) {
  const container = document.getElementById("editorPicksContainer");
  const skeleton = document.getElementById("skeletonLoader");

  // Ẩn hiệu ứng skeleton loading
  skeleton.classList.add("d-none");
  container.innerHTML = "";

  novels.forEach((novel) => {
    // Tạo thẻ <a> bao ngoài truyện
    const novelLink = document.createElement("a");
    novelLink.href = novel.link;
    novelLink.target = "_blank";
    novelLink.className = "novel-link";

    // Tạo phần hiển thị truyện
    const novelItem = document.createElement("div");
    novelItem.className = "novel-item";

    // HTML của mỗi truyện, có thêm xử lý ảnh lỗi bằng onerror
    novelItem.innerHTML = `
      <img src="${novel.anh}" alt="${novel.ten}" loading="lazy"
           onerror="this.onerror=null;this.src='../assets/img/no-image.webp';">
      <div class="novel-info">
        <h3 class="novel-title">${novel.ten}</h3>
        <p class="novel-description">${novel.mo_ta}</p>
        <div class="novel-meta">
          <span class="chapter-count">
            <i class="fas fa-book"></i>
            ${novel.so_chuong}
          </span>
          <span class="novel-category">${novel.the_loai
            .split(",")[0]
            .trim()}</span>
        </div>
      </div>
    `;

    novelLink.appendChild(novelItem);
    container.appendChild(novelLink);
  });
}

// Hàm render phần "Đang đọc"
function renderReadingNow(novels) {
  const container = document.getElementById("readingNowContainer");
  const skeleton = document.getElementById("readingSkeleton");

  // Ẩn hiệu ứng skeleton loading
  skeleton.classList.add("d-none");
  container.innerHTML = "";

  novels.forEach((novel) => {
    const readingLink = document.createElement("a");
    readingLink.href = novel.link;
    readingLink.target = "_blank";
    readingLink.className = "reading-link";

    const readingItem = document.createElement("div");
    readingItem.className = "reading-item";

    // HTML của truyện đang đọc (không có ảnh)
    readingItem.innerHTML = `
      <h3 class="reading-title">${novel.ten}</h3>
      <span class="continue-reading">
        Đọc tiếp <i class="fas fa-arrow-right"></i>
      </span>
    `;

    readingLink.appendChild(readingItem);
    container.appendChild(readingLink);
  });
}

// Khởi động sau khi trang đã load xong
document.addEventListener("DOMContentLoaded", () => {
  loadNovelData(); // Gọi hàm chính để tải và hiển thị dữ liệu

  // Hiệu ứng đổ bóng khi hover vào container
  const container = document.querySelector(".editor-container");
  container.addEventListener("mouseenter", () => {
    container.style.boxShadow = "0 25px 50px -12px rgba(0, 0, 0, 0.25)";
  });

  container.addEventListener("mouseleave", () => {
    container.style.boxShadow = "var(--shadow)";
  });
});
