// Hàm setTheme
function setTheme(themeName) {
  document.body.classList.remove(
    "theme-dark",
    "theme-blue",
    "theme-pink",
    "theme-purple",
    "theme-green"
  );
  if (themeName) {
    document.body.classList.add(`theme-${themeName}`);
  }
  localStorage.setItem("theme", themeName);
}

// Hàm loadTheme
function loadTheme() {
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme) {
    setTheme(savedTheme);
  }
}

// Hàm lấy tham số từ URL
function getUrlParameter(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
  var results = regex.exec(location.search);
  return results === null
    ? ""
    : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// Hàm hiển thị kết quả theo thể loại
async function displayGenreResults(genre) {
  // ... (giữ nguyên code cũ) ...
}

// Hàm tìm kiếm theo tên truyện
async function displaySearchResults(searchTerm) {
  const resultsGrid = document.getElementById("resultsGrid");
  const categoryName = document.getElementById("categoryName");
  const currentTerm = document.getElementById("currentTerm");
  const novelCount = document.getElementById("novelCount");
  const breadcrumbIcon = document.getElementById("breadcrumbIcon");
  const breadcrumbText = document.getElementById("breadcrumbText");
  const breadcrumbLink = document.getElementById("breadcrumbLink");
  const searchInTitle = document.getElementById("searchInTitle").checked;
  const searchInDescription = document.getElementById(
    "searchInDescription"
  ).checked;

  // Đặt tiêu đề
  categoryName.textContent = `Kết quả tìm kiếm: "${searchTerm}"`;
  currentTerm.textContent = searchTerm;

  // Cập nhật breadcrumb
  breadcrumbIcon.className = "fas fa-search";
  breadcrumbText.textContent = "Tìm Kiếm";
  breadcrumbLink.href = "javascript:void(0)";

  // Hiển thị loading
  resultsGrid.innerHTML = `
                <div class="loading-spinner">
                    <div class="spinner"></div>
                </div>
            `;

  try {
    // Tải dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    if (!response.ok) throw new Error("Không thể tải dữ liệu");
    const data = await response.json();

    // Gom tất cả truyện
    let allStories = [];
    for (const key in data) {
      if (Array.isArray(data[key])) {
        allStories = allStories.concat(data[key]);
      }
    }

    // Loại bỏ truyện trùng dựa trên link
    const uniqueStories = [];
    const seenLinks = new Set();
    for (const story of allStories) {
      if (!seenLinks.has(story.link)) {
        seenLinks.add(story.link);
        uniqueStories.push(story);
      }
    }

    // Lọc truyện theo từ khóa tìm kiếm
    const filteredStories = uniqueStories.filter((story) => {
      const lowerSearchTerm = searchTerm.toLowerCase();

      if (!searchInTitle && !searchInDescription) return false;

      let matches = false;

      if (
        searchInTitle &&
        story.ten &&
        story.ten.toLowerCase().includes(lowerSearchTerm)
      ) {
        matches = true;
      }

      if (
        !matches &&
        searchInDescription &&
        story.mo_ta &&
        story.mo_ta.toLowerCase().includes(lowerSearchTerm)
      ) {
        matches = true;
      }

      return matches;
    });

    // Cập nhật số lượng truyện
    novelCount.textContent = filteredStories.length + " truyện";

    // Xóa nội dung cũ
    resultsGrid.innerHTML = "";

    if (filteredStories.length === 0) {
      resultsGrid.innerHTML = `
                        <div class="no-results">
                            <div class="no-results-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <h2 class="no-results-title">Không tìm thấy truyện</h2>
                            <p class="no-results-text">Không có truyện nào phù hợp với từ khóa "${searchTerm}"</p>
                            <button id="tryAgainBtn" class="btn btn-primary mt-3">
                                <i class="fas fa-redo"></i> Thử lại với từ khóa khác
                            </button>
                        </div>
                    `;

      document
        .getElementById("tryAgainBtn")
        .addEventListener("click", function () {
          document.getElementById("advancedSearchInput").focus();
        });
      return;
    }

    // Hiển thị truyện
    filteredStories.forEach((story) => {
      const novelLink = document.createElement("a");
      novelLink.href = story.link;
      novelLink.className = "novel-link";
      novelLink.target = "_blank";

      // Highlight từ khóa tìm kiếm trong tiêu đề
      let highlightedTitle = story.ten;
      if (searchInTitle) {
        const regex = new RegExp(`(${searchTerm})`, "gi");
        highlightedTitle = story.ten.replace(
          regex,
          '<span class="highlight">$1</span>'
        );
      }

      // Highlight từ khóa tìm kiếm trong mô tả
      let highlightedDescription = story.mo_ta;
      if (searchInDescription && highlightedDescription) {
        const regex = new RegExp(`(${searchTerm})`, "gi");
        highlightedDescription = story.mo_ta.replace(
          regex,
          '<span class="highlight">$1</span>'
        );
      }

      novelLink.innerHTML = `
    <div class="novel-item">
        <img src="${story.anh}" alt="${story.ten}" loading="lazy"
             onerror="this.onerror=null;this.src='./assets/img/no-image.webp';">
        <div class="novel-info">
            <h3 class="novel-title">${highlightedTitle}</h3>
            <p class="novel-description">${
              highlightedDescription || "Không có mô tả"
            }</p>
            <div class="novel-meta">
                <span class="chapter-count">
                    <i class="fas fa-book"></i>
                    ${story.so_chuong}
                </span>
                <span class="genre-tag">${
                  story.the_loai ? story.the_loai.split(",")[0] : "Không rõ"
                }</span>
            </div>
        </div>
    </div>
`;

      resultsGrid.appendChild(novelLink);
    });
  } catch (error) {
    console.error("Lỗi khi tải dữ liệu:", error);
    resultsGrid.innerHTML = `
                    <div class="no-results">
                        <div class="no-results-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <h2 class="no-results-title">Đã xảy ra lỗi</h2>
                        <p class="no-results-text">Không thể tải dữ liệu truyện. Vui lòng thử lại sau.</p>
                        <a href="categories.html" class="back-to-home">
                            <i class="fas fa-arrow-left"></i> Quay lại danh mục
                        </a>
                    </div>
                `;
  }
}

// Khi trang được tải
document.addEventListener("DOMContentLoaded", () => {
  // Tải theme
  loadTheme();

  // Lấy tham số từ URL
  const genre = getUrlParameter("genre");
  const query = getUrlParameter("query");
  const breadcrumbIcon = document.getElementById("breadcrumbIcon");
  const breadcrumbText = document.getElementById("breadcrumbText");
  const breadcrumbLink = document.getElementById("breadcrumbLink");

  // Hiển thị kết quả tùy theo tham số
  if (genre) {
    // Cập nhật breadcrumb cho thể loại
    breadcrumbIcon.className = "fas fa-tags";
    breadcrumbText.textContent = "Thể Loại";
    breadcrumbLink.href = "categories.html";

    displayGenreResults(genre);
  } else if (query) {
    // Cập nhật breadcrumb cho tìm kiếm
    breadcrumbIcon.className = "fas fa-search";
    breadcrumbText.textContent = "Tìm Kiếm";
    breadcrumbLink.href = "javascript:void(0)";

    displaySearchResults(query);
    document.getElementById("advancedSearchInput").value = query;
  } else {
    // Mặc định nếu không có tham số nào
    resultsGrid.innerHTML = `
                    <div class="no-results">
                        <div class="no-results-icon">
                            <i class="fas fa-info-circle"></i>
                        </div>
                        <h2 class="no-results-title">Không có tiêu chí tìm kiếm</h2>
                        <p class="no-results-text">Vui lòng nhập từ khóa tìm kiếm hoặc chọn thể loại</p>
                        <a href="categories.html" class="back-to-home">
                            <i class="fas fa-arrow-left"></i> Quay lại danh mục
                        </a>
                    </div>
                `;
  }

  // Xử lý tìm kiếm nâng cao
  document
    .getElementById("advancedSearchBtn")
    .addEventListener("click", function () {
      const searchTerm = document
        .getElementById("advancedSearchInput")
        .value.trim();
      if (searchTerm) {
        // Cập nhật URL với tham số query mới
        const newUrl = new URL(window.location.href);
        newUrl.searchParams.set("query", searchTerm);
        window.history.pushState({}, "", newUrl);

        // Hiển thị kết quả
        displaySearchResults(searchTerm);
      }
    });

  // Xử lý nhấn Enter trong ô tìm kiếm nâng cao
  document
    .getElementById("advancedSearchInput")
    .addEventListener("keypress", function (e) {
      if (e.key === "Enter") {
        document.getElementById("advancedSearchBtn").click();
      }
    });
});

// Sự kiện cho thanh tìm kiếm ở header
document
  .querySelector(".search-input")
  .addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
      const searchTerm = this.value.trim();
      if (searchTerm) {
        window.location.href = `search-results.html?query=${encodeURIComponent(
          searchTerm
        )}`;
      }
    }
  });
