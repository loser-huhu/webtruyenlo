// Tải theme từ localStorage khi trang được tải
document.addEventListener("DOMContentLoaded", function () {
  const savedTheme = localStorage.getItem("theme") || "light";
  document.body.classList.add("theme-" + savedTheme);

  // Khởi tạo các dropdown menu
  initMegaMenus();
});

// ======== Xử lý tìm kiếm ========
function setupSearch() {
  const searchInput = document.querySelector(".search-input");
  const searchIcon = document.querySelector(".search-icon");

  // Xử lý khi click vào icon tìm kiếm
  searchIcon.addEventListener("click", function () {
    performSearch();
  });

  // Xử lý khi nhấn Enter trong ô tìm kiếm
  searchInput.addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
      performSearch();
    }
  });

  // Hàm thực hiện tìm kiếm
  function performSearch() {
    const searchTerm = searchInput.value.trim();

    if (searchTerm) {
      // Chuyển hướng sang trang kết quả với từ khóa tìm kiếm
      window.location.href = `search-results.html?query=${encodeURIComponent(
        searchTerm
      )}`;
    }
  }
}

// Gọi hàm setup khi DOM được tải
document.addEventListener("DOMContentLoaded", function () {
  // ... các code khác ...

  // Khởi tạo chức năng tìm kiếm
  setupSearch();
});
// Khởi tạo mega menu
function initMegaMenus() {
  // Lấy các nút và menu
  const theLoaiBtn = document.getElementById("theLoaiBtn");
  const boiCanhBtn = document.getElementById("boiCanhBtn");
  const luuPhaiBtn = document.getElementById("luuPhaiBtn");
  const danhSachBtn = document.getElementById("danhSachBtn");

  const theLoaiMenu = document.getElementById("theLoaiMenu");
  const boiCanhMenu = document.getElementById("boiCanhMenu");
  const luuPhaiMenu = document.getElementById("luuPhaiMenu");
  const danhSachMenu = document.getElementById("danhSachMenu");

  const overlay = document.getElementById("megaOverlay");

  // Tạo mảng menu
  const menus = [theLoaiMenu, boiCanhMenu, luuPhaiMenu, danhSachMenu];

  // Hàm đóng tất cả menu
  function closeAllMenus() {
    menus.forEach((menu) => {
      menu.style.display = "none";
    });
    overlay.style.display = "none";
  }

  // Xử lý nút Thể loại
  theLoaiBtn.addEventListener("click", function (e) {
    e.preventDefault();

    if (theLoaiMenu.style.display === "block") {
      closeAllMenus();
    } else {
      closeAllMenus();
      theLoaiMenu.style.display = "block";
      overlay.style.display = "block";
    }
  });

  // Xử lý nút Bối cảnh thế giới
  boiCanhBtn.addEventListener("click", function (e) {
    e.preventDefault();

    if (boiCanhMenu.style.display === "block") {
      closeAllMenus();
    } else {
      closeAllMenus();
      boiCanhMenu.style.display = "block";
      overlay.style.display = "block";
    }
  });

  // Xử lý nút Lưu phái
  luuPhaiBtn.addEventListener("click", function (e) {
    e.preventDefault();

    if (luuPhaiMenu.style.display === "block") {
      closeAllMenus();
    } else {
      closeAllMenus();
      luuPhaiMenu.style.display = "block";
      overlay.style.display = "block";
    }
  });

  // Xử lý nút Danh sách
  danhSachBtn.addEventListener("click", function (e) {
    e.preventDefault();

    if (danhSachMenu.style.display === "block") {
      closeAllMenus();
    } else {
      closeAllMenus();
      danhSachMenu.style.display = "block";
      overlay.style.display = "block";
    }
  });

  // Xử lý nút đóng
  document.querySelectorAll(".mega-close-btn").forEach((btn) => {
    btn.addEventListener("click", function () {
      closeAllMenus();
    });
  });

  // Xử lý overlay
  overlay.addEventListener("click", function () {
    closeAllMenus();
  });

  // Đóng menu khi click ra ngoài
  document.addEventListener("click", function (e) {
    if (
      !e.target.closest(".mega-menu") &&
      !e.target.closest(".nav-link.dropdown-toggle") &&
      !e.target.closest(".mega-close-btn")
    ) {
      closeAllMenus();
    }
  });
}

// Hiệu ứng cho icon đăng nhập
const loginIcon = document.querySelector(".bi-person");
loginIcon.addEventListener("click", function () {
  alert("Vui lòng đăng nhập để sử dụng tính năng này!");
});
//

// Hàm render truyện đề cử
function renderEditorPicks() {
  const container = document.getElementById("editorPicksContainer");

  // Hiển thị skeleton loading
  const skeleton = document.getElementById("skeletonLoader");
  skeleton.classList.remove("d-none");

  // Giả lập thời gian load
  setTimeout(() => {
    container.innerHTML = "";
    skeleton.classList.add("d-none");

    novelsData.editorPicks.forEach((novel) => {
      const novelItem = document.createElement("div");
      novelItem.className = "novel-item";
      novelItem.innerHTML = `
                        <img src="${novel.image}" alt="${novel.title}" loading="lazy">
                        <div class="novel-info">
                            <h3 class="novel-title">${novel.title}</h3>
                            <p class="novel-description">${novel.description}</p>
                            <div class="novel-meta">
                                <span class="chapter-count">
                                    <i class="fas fa-book"></i>
                                    ${novel.chapters} chương
                                </span>
                                <span class="novel-category">${novel.category}</span>
                            </div>
                        </div>
                    `;
      container.appendChild(novelItem);
    });
  }, 800);
}
