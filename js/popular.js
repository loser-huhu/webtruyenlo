// popular.js

// Hàm render danh sách phổ biến
async function renderPopularLists() {
  try {
    // Load dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    const data = await response.json();

    // Render skeleton loading
    renderSkeleton();

    // Lấy dữ liệu cho các phần
    const docNhieuData = data["Đọc nhiều"].slice(0, 10);
    const thinhHanhData = data["Thịnh Hành"].slice(0, 10);
    const deCuData = data["Đề Cử"].slice(0, 10);

    // Render từng danh sách
    renderPopularList("docNhieuContainer", docNhieuData);
    renderPopularList("thinhHanhContainer", thinhHanhData);
    renderPopularList("deCuContainer", deCuData);
  } catch (error) {
    console.error("❌ Lỗi khi tải dữ liệu truyện phổ biến:", error);
    // Ẩn skeleton khi có lỗi
    document.querySelectorAll(".popular-skeleton").forEach((el) => {
      el.style.display = "none";
    });
  }
}

// Hàm render skeleton loading
function renderSkeleton() {
  const containers = [
    "docNhieuContainer",
    "thinhHanhContainer",
    "deCuContainer",
  ];

  containers.forEach((containerId) => {
    const container = document.getElementById(containerId);
    container.innerHTML = "";

    for (let i = 0; i < 10; i++) {
      const skeletonItem = document.createElement("div");
      skeletonItem.className = "popular-skeleton";

      if (i === 0) {
        skeletonItem.innerHTML = `
          <div class="skeleton-rank"></div>
          <div style="flex-grow:1; padding-right:15px;">
            <div class="skeleton skeleton-text" style="height:20px; width:90%; margin-bottom:8px"></div>
            <div class="skeleton skeleton-text" style="width:70%; margin-bottom:8px"></div>
            <div class="skeleton skeleton-text" style="width:50%"></div>
          </div>
          <div style="width:65px; height:95px; background:var(--skeleton-end); border-radius:4px;"></div>
        `;
      } else {
        skeletonItem.innerHTML = `
          <div class="skeleton-rank"></div>
          <div class="skeleton skeleton-text" style="flex-grow:1"></div>
        `;
      }

      container.appendChild(skeletonItem);
    }
  });
}

// Hàm render một danh sách phổ biến
function renderPopularList(containerId, novels) {
  const container = document.getElementById(containerId);
  container.innerHTML = "";

  novels.forEach((novel, index) => {
    const rank = index + 1;

    // Tạo phần tử chính
    const item = document.createElement("a");
    item.href = novel.link || "#";
    item.target = "_blank";
    item.className = index === 0 ? "popular-first" : "popular-item";

    // Tạo badge xếp hạng
    const rankEl = document.createElement("div");
    rankEl.className = "popular-rank";

    if (rank <= 3) {
      const medalImg = document.createElement("img");
      medalImg.src = `./assets/img/medal-${rank}.svg`;
      medalImg.alt = `Top ${rank}`;
      medalImg.width = 24;
      medalImg.height = 32;
      medalImg.style.filter =
        rank === 1
          ? "drop-shadow(0 0 4px rgba(255, 215, 0, 0.8))"
          : rank === 2
          ? "drop-shadow(0 0 4px rgba(192, 192, 192, 0.8))"
          : "drop-shadow(0 0 4px rgba(205, 127, 50, 0.8))";
      rankEl.appendChild(medalImg);
    } else {
      rankEl.textContent = rank;
      rankEl.style.fontWeight = "bold";
      rankEl.style.color = "var(--text-color)";
    }

    // Phần thông tin
    const infoEl = document.createElement("div");
    infoEl.className = "popular-info";

    const titleEl = document.createElement("h3");
    titleEl.className = "popular-title";
    titleEl.textContent = novel.ten;
    infoEl.appendChild(titleEl);

    if (index === 0) {
      // Meta data cho item đầu tiên
      const authorEl = document.createElement("div");
      authorEl.className = "popular-author";
      authorEl.innerHTML = `<i class="fas fa-user"></i> ${
        novel.tac_gia || "Đang cập nhật"
      }`;

      const categoryEl = document.createElement("div");
      categoryEl.className = "popular-category";
      categoryEl.innerHTML = `<i class="fas fa-tag"></i> ${novel.the_loai
        .split(",")[0]
        .trim()}`;

      const metaEl = document.createElement("div");
      metaEl.className = "popular-meta";
      metaEl.appendChild(authorEl);
      metaEl.appendChild(categoryEl);
      infoEl.appendChild(metaEl);

      // Ảnh bìa
      const coverEl = document.createElement("div");
      coverEl.className = "popular-cover";
      const img = document.createElement("img");
      img.src = novel.anh;
      img.alt = novel.ten;

      // Xử lý lỗi khi load ảnh bị lỗi
      img.onerror = function () {
        this.onerror = null;
        this.src = "./assets/img/no-image.webp";
      };

      coverEl.appendChild(img);
      item.appendChild(rankEl);
      item.appendChild(infoEl);
      item.appendChild(coverEl);
    } else {
      item.appendChild(rankEl);
      item.appendChild(titleEl);
    }

    container.appendChild(item);
  });
}

// Khởi động sau khi trang đã load xong
document.addEventListener("DOMContentLoaded", () => {
  renderPopularLists();
});
