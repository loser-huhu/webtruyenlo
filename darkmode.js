document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("dn");

  if (!toggle) return; // Nếu không tìm thấy phần tử thì không làm gì cả

  // Áp dụng theme đã lưu khi tải trang
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme === "dark") {
    document.body.classList.add("dark-mode");
    toggle.checked = true;
  }

  // Bắt sự kiện toggle để đổi theme
  toggle.addEventListener("change", function () {
    if (this.checked) {
      document.body.classList.add("dark-mode");
      localStorage.setItem("theme", "dark");
    } else {
      document.body.classList.remove("dark-mode");
      localStorage.setItem("theme", "light");
    }
  });
});
