// Dữ liệu truyện với URL trực tiếp
const novelsData = {
  editorPicks: [
    {
      id: 1,
      image: "https://placehold.co/96x128/047857/FFFFFF?text=Quái+Đàm",
      title: "Quái đàm cửa hàng phố kinh doanh hằng ngày",
      description:
        "️ ĐQL không được tự sửa raw/up file/xóa file bao gồm thêm tên phó bản etc M…",
      chapters: 108,
      category: "Khoa huyễn",
      url: "https://truyenchu.com.vn/truyen/quai-dam-cua-hang-pho-kinh-doanh-hang-ng.html", // THÊM URL
    },
    {
      id: 2,
      image: "https://placehold.co/96x128/3B82F6/FFFFFF?text=Sono+Mono",
      title: "Sono Mono Nochi Ni…",
      description:
        "Wazu một người thành thị bình thường,vì một vài nguyên nhân anh đã tự bế q…",
      chapters: 8,
      category: "Sắc",
      url: "https://truyenchu.com.vn/truyen/sono-mono-nochi-ni.html", // THÊM URL
    },
    {
      id: 3,
      image: "https://placehold.co/96x128/EF4444/FFFFFF?text=Sinh+Hoạt",
      title: "Sinh hoạt chức nghiệp nhất phế? Nhưng ta có thần cấp thiên phú!",
      description:
        "Văn án toàn dân chuyển chức trò chơi xâm lấn mạt thế sảng văn nữ cường vô…",
      chapters: 160,
      category: "Huyền huyễn",
      url: "https://truyenchu.com.vn/truyen/sinh-hoat-chuc-nghiep-nhat-phe-nhung-ta-.html", // THÊM URL
    },
    {
      id: 4,
      image: "https://placehold.co/96x128/8B5CF6/FFFFFF?text=Tang+Thi",
      title: "Tang thi? Thiêu ủ phân",
      description:
        "Bảo hộ khu ra ngoài thám hiểm nhân viên trong rừng rậm lạc đường ngoài mu…",
      chapters: 137,
      category: "Huyền huyễn",
      url: "https://truyenchu.com.vn/tang-thi-thieu-u-phan", // THÊM URL
    },
    {
      id: 5,
      image: "https://placehold.co/96x128/10B981/FFFFFF?text=Chết+Thảm",
      title:
        "Chết thảm trọng sinh sau, thành vaiác quyền thần chưởng thượng kiều",
      description:
        "Lâm vọng thư mẫu thân chết sớm phụ không từ hầu phủ gian nan độ nhật vài …",
      chapters: 385,
      category: "Huyền huyễn",
      url: "https://truyenchu.com.vn/chet-tham-trong-sinh-sau-thanh-vaiac-quyen-than-chuong-thuong-kieu", // THÊM URL
    },
    {
      id: 6,
      image: "https://placehold.co/96x128/F59E0B/FFFFFF?text=Nhà+Giàu",
      title: "Nhà giàu số một ba mẹ bị đoạt, manh nhãi con mê điên đại lão c…",
      description:
        "đoàn sủng ba tuổi rưỡi vô CP vạn nhân mê ngọt sủng thân tình văn Manh ma…",
      chapters: 320,
      category: "Đô thị",
      url: "https://truyenchu.com.vn/nha-giau-so-mot-ba-me-bi-doat-manh-nhai-con-me-dien-dai-lao-c", // THÊM URL
    },
  ],
  readingNow: [
    {
      id: 1,
      title: "Hoàng thúc hảo eo nhỏ, kiều kiều vương phi…",
      url: "https://truyenchu.com.vn/hoang-thuc-hao-eo-nho-kieu-kieu-vuong-phi",
      category: "Ngôn tình", // THÊM THỂ LOẠI
    },
    {
      id: 2,
      title: "Đại đế thế gia nghèo dưỡng ta? Nhưng ta ngộ…",
      url: "https://truyenchu.com.vn/dai-de-the-gia-ngheo-duong-ta-nhung-ta-ngo",
      category: "Xuyên không", // THÊM THỂ LOẠI
    },
    {
      id: 3,
      title: "Cùng đối thủ một mất một còn thành hôn sau",
      url: "https://truyenchu.com.vn/cung-doi-thu-mot-mat-mot-con-thanh-hon-sau",
      category: "Ngôn tình", // THÊM THỂ LOẠI
    },
    {
      id: 4,
      title: "Ở sinh tồn trò chơi bị khắc kim đại lão theo dõi",
      url: "https://truyenchu.com.vn/o-sinh-ton-tro-choi-bi-khac-kim-dai-lao-theo-doi",
      category: "Võng du", // THÊM THỂ LOẠI
    },
    {
      id: 5,
      title: "Bị quốc đủ phong sát sau, ở tây giáp gan thuộc…",
      url: "https://truyenchu.com.vn/bi-quoc-du-phong-sat-sau-o-tay-giap-gan-thuoc",
      category: "Đô thị", // THÊM THỂ LOẠI
    },
    {
      id: 6,
      title: "Luyến ái muốn ở nạp đao sau [ Sakamoto Days ]",
      url: "https://truyenchu.com.vn/luyen-ai-muon-o-nap-dao-sau-sakamoto-days",
      category: "Hài hước", // THÊM THỂ LOẠI
    },
    {
      id: 7,
      title: "Người chơi đã buông xuống, đạo hữu thỉnh chịu…",
      url: "https://truyenchu.com.vn/nguoi-choi-da-buong-xuong-dao-huu-thinh-chiu",
      category: "Tiên hiệp", // THÊM THỂ LOẠI
    },
  ],
};

// Hàm render truyện đề cử - ĐÃ CẬP NHẬT VỚI URL TRỰC TIẾP
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
      // Tạo thẻ a như một container liên kết
      const novelLink = document.createElement("a");
      novelLink.href = novel.url; // SỬ DỤNG URL TRỰC TIẾP
      novelLink.className = "novel-link";

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

      novelLink.appendChild(novelItem);
      container.appendChild(novelLink);
    });
  }, 800);
}

// Hàm render truyện đang đọc - ĐÃ CẬP NHẬT VỚI URL TRỰC TIẾP
function renderReadingNow() {
  const container = document.getElementById("readingNowContainer");

  // Hiển thị skeleton loading
  const skeleton = document.getElementById("readingSkeleton");
  skeleton.classList.remove("d-none");

  // Giả lập thời gian load
  setTimeout(() => {
    container.innerHTML = "";
    skeleton.classList.add("d-none");

    novelsData.readingNow.forEach((novel) => {
      // Tạo thẻ a như một container liên kết
      const readingLink = document.createElement("a");
      readingLink.href = novel.url; // SỬ DỤNG URL TRỰC TIẾP
      readingLink.className = "reading-link";

      const readingItem = document.createElement("div");
      readingItem.className = "reading-item";
      readingItem.innerHTML = `
        <h3 class="reading-title">${novel.title}</h3>
        <span class="continue-reading">
          Đọc tiếp <i class="fas fa-arrow-right"></i>
        </span>
      `;

      readingLink.appendChild(readingItem);
      container.appendChild(readingLink);
    });
  }, 800);
}

// Khởi chạy khi tài liệu được tải
document.addEventListener("DOMContentLoaded", () => {
  renderEditorPicks();
  renderReadingNow();

  // Thêm hiệu ứng khi di chuột vào container
  const container = document.querySelector(".editor-container");
  container.addEventListener("mouseenter", () => {
    container.style.boxShadow = "0 25px 50px -12px rgba(0, 0, 0, 0.25)";
  });

  container.addEventListener("mouseleave", () => {
    container.style.boxShadow = "var(--shadow)";
  });
});
