// document.addEventListener("DOMContentLoaded", function () {
//   // Lấy các phần tử cần dùng
//   const loginIcon = document.getElementById("loginIcon");
//   const authModal = document.getElementById("authModal");
//   const overlay = document.getElementById("authOverlay");
//   const closeModal = document.getElementById("closeModal");

//   const showRegister = document.getElementById("authModalShowRegister");
//   const showLogin = document.getElementById("authModalShowLogin");
//   const forgotPasswordLink = document.getElementById(
//     "authModalForgotPasswordLink"
//   );
//   const backToLogin = document.getElementById("authModalBackToLogin");

//   const loginForm = document.getElementById("authModalLoginForm");
//   const registerForm = document.getElementById("authModalRegisterForm");
//   const forgotPasswordForm = document.getElementById(
//     "authModalForgotPasswordForm"
//   );

//   // Regex kiểm tra email hợp lệ
//   const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

//   // Regex kiểm tra độ mạnh mật khẩu
//   const passwordStrongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;

//   // Hàm mở modal
//   function openModal() {
//     overlay.classList.add("active");
//     authModal.classList.add("active");
//     document.body.style.overflow = "hidden";
//   }

//   // Hàm đóng modal
//   function closeModalFunc() {
//     overlay.classList.remove("active");
//     authModal.classList.remove("active");
//     document.body.style.overflow = "";
//   }

//   // Mở modal khi click icon đăng nhập
//   loginIcon.addEventListener("click", openModal);
//   closeModal.addEventListener("click", closeModalFunc);
//   overlay.addEventListener("click", closeModalFunc);

//   // Chuyển đổi form
//   showRegister.addEventListener("click", function (e) {
//     e.preventDefault();
//     loginForm.classList.add("auth-form--hidden");
//     registerForm.classList.remove("auth-form--hidden");
//   });

//   showLogin.addEventListener("click", function (e) {
//     e.preventDefault();
//     registerForm.classList.add("auth-form--hidden");
//     forgotPasswordForm.classList.add("auth-form--hidden");
//     loginForm.classList.remove("auth-form--hidden");
//   });

//   forgotPasswordLink.addEventListener("click", function (e) {
//     e.preventDefault();
//     loginForm.classList.add("auth-form--hidden");
//     forgotPasswordForm.classList.remove("auth-form--hidden");
//   });

//   backToLogin.addEventListener("click", function (e) {
//     e.preventDefault();
//     forgotPasswordForm.classList.add("auth-form--hidden");
//     loginForm.classList.remove("auth-form--hidden");
//   });

//   // Toggle hiển thị mật khẩu
//   document.querySelectorAll(".toggle-password").forEach(function (toggle) {
//     toggle.addEventListener("click", function () {
//       const passwordInput = this.parentElement.querySelector("input");
//       const icon = this.querySelector("i");
//       if (!passwordInput || !icon) return;

//       if (passwordInput.type === "password") {
//         passwordInput.type = "text";
//         icon.classList.remove("fa-eye");
//         icon.classList.add("fa-eye-slash");
//       } else {
//         passwordInput.type = "password";
//         icon.classList.remove("fa-eye-slash");
//         icon.classList.add("fa-eye");
//       }
//     });
//   });

//   // Submit form đăng nhập
//   loginForm.addEventListener("submit", function (e) {
//     e.preventDefault();
//     const email = loginForm.querySelector('input[type="email"]').value.trim();
//     const passwordInput = loginForm.querySelector(
//       'input[placeholder="Nhập mật khẩu của bạn"]'
//     );
//     const password = passwordInput ? passwordInput.value.trim() : "";

//     if (!email || !password) {
//       alert("Vui lòng nhập đầy đủ email và mật khẩu!");
//       return;
//     }
//     if (!emailRegex.test(email)) {
//       alert("Email không hợp lệ!");
//       return;
//     }
//     if (password.length < 8) {
//       alert("Mật khẩu phải có ít nhất 8 ký tự!");
//       return;
//     }
//     alert("Đăng nhập thành công!\nEmail: " + email);
//     closeModalFunc();
//   });

//   // Submit form đăng ký
//   registerForm.addEventListener("submit", function (e) {
//     e.preventDefault();
//     const email = registerForm
//       .querySelector('input[type="email"]')
//       .value.trim();
//     const passwordInput = registerForm.querySelector(
//       'input[placeholder="Nhập mật khẩu của bạn"]'
//     );
//     const confirmPasswordInput = registerForm.querySelector(
//       'input[placeholder="Xác nhận mật khẩu"]'
//     );
//     const password = passwordInput.value.trim();
//     const confirmPassword = confirmPasswordInput.value.trim();

//     if (!email || !password || !confirmPassword) {
//       alert("Vui lòng nhập đầy đủ thông tin!");
//       return;
//     }
//     if (!emailRegex.test(email)) {
//       alert("Email không hợp lệ!");
//       return;
//     }
//     if (password !== confirmPassword) {
//       alert("Mật khẩu xác nhận không khớp!");
//       return;
//     }
//     if (!passwordStrongRegex.test(password)) {
//       alert(
//         "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số!"
//       );
//       return;
//     }
//     alert("Đăng ký thành công!\nEmail: " + email);
//     closeModalFunc();
//   });

//   // Submit form quên mật khẩu
//   forgotPasswordForm.addEventListener("submit", function (e) {
//     e.preventDefault();
//     const email = forgotPasswordForm
//       .querySelector('input[type="email"]')
//       .value.trim();

//     if (!email) {
//       alert("Vui lòng nhập email của bạn!");
//       return;
//     }
//     if (!emailRegex.test(email)) {
//       alert("Email không hợp lệ!");
//       return;
//     }
//     alert("Yêu cầu đặt lại mật khẩu đã được gửi đến: " + email);
//     closeModalFunc();
//   });
// });
