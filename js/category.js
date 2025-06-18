// Sửa lại hàm setTheme
function setTheme(themeName) {
  // Xóa tất cả các class theme hiện có
  document.body.classList.remove(
    "theme-dark",
    "theme-blue",
    "theme-pink",
    "theme-purple",
    "theme-green"
  );

  // Thêm class theme mới nếu có
  if (themeName) {
    document.body.classList.add(`theme-${themeName}`);
  }

  // Lưu vào localStorage
  localStorage.setItem("theme", themeName);
}

// Sửa lại hàm loadTheme
function loadTheme() {
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme) {
    setTheme(savedTheme);
  }
}

// Xử lý theme từ dropdown
document.querySelectorAll(".theme-select").forEach((item) => {
  item.addEventListener("click", function (e) {
    e.preventDefault();
    const theme = this.getAttribute("data-theme");
    setTheme(theme);
  });
});

// Xử lý theme từ floating buttons
document.querySelectorAll(".theme-selector").forEach((button) => {
  button.addEventListener("click", () => {
    const theme = button.getAttribute("data-theme");
    setTheme(theme);
  });
});

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
  const resultsGrid = document.getElementById("resultsGrid");
  const categoryName = document.getElementById("categoryName");
  const currentCategory = document.getElementById("currentCategory");
  const novelCount = document.getElementById("novelCount");

  // Đặt tên thể loại
  categoryName.textContent = genre;
  currentCategory.textContent = genre;

  // Hiển thị loading
  resultsGrid.innerHTML = `
          <div class="loading-spinner">
            <div class="spinner"></div>
          </div>
        `;

  try {
    // Tải dữ liệu từ file JSON
    const response = await fetch("Json/truyenchu_full_data.json");
    if (!response.ok) {
      throw new Error("Không thể tải dữ liệu");
    }
    const data = await response.json();

    // Gom tất cả truyện từ tất cả các mục trong data
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

    // Lọc truyện theo thể loại
    const filteredStories = uniqueStories.filter((story) => {
      if (story.the_loai) {
        const genres = story.the_loai
          .split(",")
          .map((g) => g.trim().toLowerCase());
        return genres.includes(genre.toLowerCase());
      }
      return false;
    });

    // Cập nhật số lượng truyện
    novelCount.textContent = filteredStories.length + " truyện";

    // Xóa nội dung cũ
    resultsGrid.innerHTML = "";

    if (filteredStories.length === 0) {
      resultsGrid.innerHTML = `
              <div class="no-results">
                <div class="no-results-icon">
                  <i class="fas fa-book"></i>
                </div>
                <h2 class="no-results-title">Không có truyện nào</h2>
                <p class="no-results-text">Hiện chưa có truyện nào trong thể loại "${genre}"</p>
                <a href="categories.html" class="back-to-home">
                  <i class="fas fa-arrow-left"></i> Quay lại danh mục
                </a>
              </div>
            `;
      return;
    }

    // Hiển thị truyện
    filteredStories.forEach((story) => {
      const novelLink = document.createElement("a");
      novelLink.href = story.link;
      novelLink.className = "novel-link";
      novelLink.target = "_blank";

      novelLink.innerHTML = `
    <div class="novel-item">
        <img src="${story.anh}" alt="${story.ten}" loading="lazy"
             onerror="this.onerror=null;this.src='./assets/img/no-image.webp';">
        <div class="novel-info">
            <h3 class="novel-title">${story.ten}</h3>
            <p class="novel-description">${story.mo_ta}</p>
            <div class="novel-meta">
                <span class="chapter-count">
                    <i class="fas fa-book"></i>
                    ${story.so_chuong}
                </span>
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

  // Lấy tham số thể loại từ URL
  const genre = getUrlParameter("genre") || "Tiên Hiệp";

  // Hiển thị kết quả
  displayGenreResults(genre);
});
// Thêm sự kiện cho thanh tìm kiếm
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
