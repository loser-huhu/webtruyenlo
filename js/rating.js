// Hàm load dữ liệu từ JSON và render giao diện
async function loadReviewData() {
  try {
    // Load dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    const data = await response.json();

    // Lấy dữ liệu cho phần Đánh giá cao (lấy 8 truyện)
    const highRatedData = data["Đánh giá cao"].slice(0, 8);

    // Lấy dữ liệu cho phần Mới hoàn thành (lấy 4 truyện)
    const newCompletedData = data["Mới hoàn thành"].slice(0, 4);

    // Render cả hai phần
    renderHighRated(highRatedData);
    renderNewCompleted(newCompletedData);
  } catch (error) {
    console.error("❌ Lỗi khi tải dữ liệu truyện:", error);
  }
}

// Hàm render phần "Đánh giá cao"
function renderHighRated(novels) {
  const container = document.getElementById("highRatedContainer");
  container.innerHTML = "";

  // Chia thành 2 cột, mỗi cột 4 truyện
  const col1 = novels.slice(0, 4);
  const col2 = novels.slice(4, 8);

  [col1, col2].forEach((col) => {
    const colDiv = document.createElement("div");
    colDiv.className = "col-md-6";
    col.forEach((novel) => {
      const novelLink = document.createElement("a");
      novelLink.href = novel.link;
      novelLink.target = "_blank";
      novelLink.className = "novel-link";

      const novelItem = document.createElement("div");
      novelItem.className = "novel-item";

      novelItem.innerHTML = `
        <img src="${novel.anh}" alt="${novel.ten}" loading="lazy"
             onerror="this.onerror=null;this.src='./assets/img/no-image.webp';">
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
      colDiv.appendChild(novelLink);
    });
    container.appendChild(colDiv);
  });
}

// Hàm render phần "Mới hoàn thành"
function renderNewCompleted(novels) {
  const container = document.getElementById("newCompletedContainer");
  container.innerHTML = "";

  novels.forEach((novel) => {
    const novelLink = document.createElement("a");
    novelLink.href = novel.link;
    novelLink.target = "_blank";
    novelLink.className = "novel-link";

    const novelItem = document.createElement("div");
    novelItem.className = "novel-item";

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

// Khởi động sau khi trang đã load xong
document.addEventListener("DOMContentLoaded", () => {
  loadReviewData(); // Gọi hàm chính để tải và hiển thị dữ liệu
});
