// Xử lý thay đổi theme
document.querySelectorAll(".theme-select").forEach((item) => {
  item.addEventListener("click", function (e) {
    e.preventDefault();

    // Lấy theme được chọn
    const theme = this.getAttribute("data-theme");

    // Xóa tất cả các class theme hiện có
    document.body.classList.remove(
      "theme-light",
      "theme-dark",
      "theme-blue",
      "theme-pink",
      "theme-purple",
      "theme-green"
    );

    // Thêm class theme mới
    document.body.classList.add("theme-" + theme);

    // Lưu vào localStorage
    localStorage.setItem("theme", theme);

    // Đóng dropdown
    const dropdown = bootstrap.Dropdown.getInstance(
      document.getElementById("settingsDropdown")
    );
    dropdown.hide();
  });
});
