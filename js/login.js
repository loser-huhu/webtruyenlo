document.addEventListener("DOMContentLoaded", function () {
  // ==== CÁC PHẦN TỬ GIAO DIỆN ====
  const loginIcon = document.getElementById("loginIcon");
  const logoutBtn = document.getElementById("logoutBtn");
  const uploadBar = document.querySelector(".upload-bar");

  const authModal = document.getElementById("authModal");
  const overlay = document.getElementById("authOverlay");
  const closeModal = document.getElementById("closeModal");

  const showRegister = document.getElementById("authModalShowRegister");
  const showLogin = document.getElementById("authModalShowLogin");
  const forgotPasswordLink = document.getElementById(
    "authModalForgotPasswordLink"
  );
  const backToLogin = document.getElementById("authModalBackToLogin");

  const loginForm = document.getElementById("authModalLoginForm");
  const registerForm = document.getElementById("authModalRegisterForm");
  const forgotPasswordForm = document.getElementById(
    "authModalForgotPasswordForm"
  );

  // ==== BIỂU THỨC KIỂM TRA ====
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const passwordStrongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;

  // ==== MỞ/ĐÓNG MODAL ====
  function openModal() {
    overlay.classList.add("active");
    authModal.classList.add("active");
    document.body.style.overflow = "hidden";
  }

  function closeModalFunc() {
    overlay.classList.remove("active");
    authModal.classList.remove("active");
    document.body.style.overflow = "";
  }

  loginIcon.addEventListener("click", openModal);
  closeModal.addEventListener("click", closeModalFunc);
  overlay.addEventListener("click", closeModalFunc);

  // ==== CHUYỂN ĐỔI GIỮA CÁC FORM ====
  showRegister.addEventListener("click", function (e) {
    e.preventDefault();
    loginForm.classList.add("auth-form--hidden");
    registerForm.classList.remove("auth-form--hidden");
  });

  showLogin.addEventListener("click", function (e) {
    e.preventDefault();
    registerForm.classList.add("auth-form--hidden");
    forgotPasswordForm.classList.add("auth-form--hidden");
    loginForm.classList.remove("auth-form--hidden");
  });

  forgotPasswordLink.addEventListener("click", function (e) {
    e.preventDefault();
    loginForm.classList.add("auth-form--hidden");
    forgotPasswordForm.classList.remove("auth-form--hidden");
  });

  backToLogin.addEventListener("click", function (e) {
    e.preventDefault();
    forgotPasswordForm.classList.add("auth-form--hidden");
    loginForm.classList.remove("auth-form--hidden");
  });

  // ==== NÚT ĐĂNG XUẤT ====
  if (logoutBtn) {
    logoutBtn.addEventListener("click", function () {
      fetch("auth/dangxuat.php").then(() => {
        alert("Đã đăng xuất");
        window.location.reload();
      });
    });
  }

  // ==== KIỂM TRA SESSION ====
  fetch("auth/kiemtra-dangnhap.php")
    .then((res) => res.json())
    .then((data) => {
      if (data.loggedIn) {
        loginIcon.style.display = "none";
        logoutBtn.style.display = "inline-block";
        if (uploadBar) uploadBar.style.display = "block";
      } else {
        loginIcon.style.display = "inline-block";
        logoutBtn.style.display = "none";
        if (uploadBar) uploadBar.style.display = "none";
      }
    });

  // ==== SUBMIT ĐĂNG NHẬP (GỬI LÊN SERVER) ====
  loginForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const email = loginForm.querySelector('input[type="email"]').value.trim();
    const passwordInput = loginForm.querySelector(
      'input[placeholder="Nhập mật khẩu của bạn"]'
    );
    const password = passwordInput ? passwordInput.value.trim() : "";

    if (!email || !password)
      return alert("Vui lòng nhập đầy đủ email và mật khẩu!");
    if (!emailRegex.test(email)) return alert("Email không hợp lệ!");

    try {
      const res = await fetch("auth/dangnhap.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password }),
      });
      const data = await res.json();

      if (data.success) {
        alert("Đăng nhập thành công!");
        closeModalFunc();
        window.location.reload();
      } else {
        alert(data.error);
      }
    } catch (err) {
      alert("Lỗi kết nối máy chủ!");
    }
  });

  // ==== SUBMIT ĐĂNG KÝ ====
  registerForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    const email = registerForm
      .querySelector('input[type="email"]')
      .value.trim();
    const passwordInput = registerForm.querySelector(
      'input[placeholder="Nhập mật khẩu của bạn"]'
    );
    const confirmPasswordInput = registerForm.querySelector(
      'input[placeholder="Xác nhận mật khẩu"]'
    );
    const password = passwordInput.value.trim();
    const confirmPassword = confirmPasswordInput.value.trim();

    if (!email || !password || !confirmPassword)
      return alert("Vui lòng nhập đầy đủ thông tin!");
    if (!emailRegex.test(email)) return alert("Email không hợp lệ!");
    if (password !== confirmPassword)
      return alert("Mật khẩu xác nhận không khớp!");
    if (!passwordStrongRegex.test(password))
      return alert(
        "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số!"
      );

    try {
      const res = await fetch("auth/dangky.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password }),
      });
      const data = await res.json();

      if (data.success) {
        alert("Đăng ký thành công! Vui lòng đăng nhập.");
        showLogin.click();
      } else {
        alert(data.error);
      }
    } catch (err) {
      alert("Lỗi kết nối máy chủ!");
    }
  });

  // ==== SUBMIT QUÊN MẬT KHẨU ====
  forgotPasswordForm.addEventListener("submit", function (e) {
    e.preventDefault();
    const email = forgotPasswordForm
      .querySelector('input[type="email"]')
      .value.trim();
    if (!email) return alert("Vui lòng nhập email của bạn!");
    if (!emailRegex.test(email)) return alert("Email không hợp lệ!");
    alert("Yêu cầu đặt lại mật khẩu đã được gửi đến: " + email);
    closeModalFunc();
  });

  // ==== TOGGLE HIỂN THỊ MẬT KHẨU ====
  document.querySelectorAll(".toggle-password").forEach(function (toggle) {
    toggle.addEventListener("click", function () {
      const passwordInput = this.parentElement.querySelector("input");
      const icon = this.querySelector("i");
      if (!passwordInput || !icon) return;

      if (passwordInput.type === "password") {
        passwordInput.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
      } else {
        passwordInput.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
      }
    });
  });
});
