import os
import json
import time
import pickle
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

# ----------------- CẤU HÌNH ĐƯỜNG DẪN ------------------
# Lấy đường dẫn thư mục hiện tại (nơi file python này nằm)
current_dir = os.path.dirname(os.path.abspath(__file__))

# Đường dẫn tới thư mục Json (nằm cùng cấp với thư mục code hiện tại)
json_dir = os.path.join(current_dir, "..", "Json")

# Đảm bảo thư mục Json tồn tại
os.makedirs(json_dir, exist_ok=True)

# Đường dẫn đầy đủ cho 2 file json cần lưu
raw_next_data_path = os.path.join(json_dir, "raw_next_data.json")
full_data_path = os.path.join(json_dir, "truyenchu_full_data.json")

# -------------------------------------------------------

# Cấu hình trình duyệt
options = Options()
options.add_argument("--headless")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920,1080")
options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")

# Khởi tạo driver
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

# Tải cookie nếu có
try:
    with open("cookies.pkl", "rb") as f:
        cookies = pickle.load(f)
    driver.get("https://truyenchu.com.vn/")
    for cookie in cookies:
        driver.add_cookie(cookie)
except FileNotFoundError:
    print("🔍 Không tìm thấy cookie, sẽ thử đăng nhập...")

# Truy cập trang chủ
url = "https://truyenchu.com.vn/"
print("🔍 Đang tải trang chủ...")
driver.get(url)
time.sleep(3)

# Lấy dữ liệu JSON từ script
try:
    script_tag = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, '//script[@id="__NEXT_DATA__"]'))
    )
    json_data = script_tag.get_attribute("textContent")
except Exception as e:
    print(f"❌ Lỗi khi lấy dữ liệu JSON: {e}")
    driver.quit()
    exit()

# Parse JSON
try:
    data = json.loads(json_data)
    page_props = data["props"]["pageProps"]
    
    # Lưu dữ liệu thô để debug (lưu toàn bộ dữ liệu gốc)
    with open(raw_next_data_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"✅ Đã lưu dữ liệu thô vào {raw_next_data_path}")
    
    # Tạo dictionary để lưu trữ tất cả các mục
    all_data = {}
    
    # Thu thập dữ liệu từ các mục khác nhau
    if "editorChoice" in page_props:
        editor_choice_books = page_props["editorChoice"]
        all_data["Biên tập viên đề cử"] = editor_choice_books[:8]
        all_data["Đang đọc"] = editor_choice_books[8:]
    if "lastUpdate" in page_props:
        all_data["Mới cập nhật"] = page_props["lastUpdate"]
    if "topRead" in page_props:
        all_data["Đọc nhiều"] = page_props["topRead"]
    if "topPopular" in page_props:
        all_data["Thịnh Hành"] = page_props["topPopular"]
    if "topPromote" in page_props:
        all_data["Đề Cử"] = page_props["topPromote"]
    if "topRate" in page_props:
        all_data["Đánh giá cao"] = page_props["topRate"]
    if "lastComplete" in page_props:
        all_data["Mới hoàn thành"] = page_props["lastComplete"]
    
    print(f"✅ Đã tìm thấy {len(all_data)} mục truyện")
    
except Exception as e:
    print(f"❌ Lỗi khi parse JSON: {e}")
    driver.quit()
    exit()

# Đóng trình duyệt
driver.quit()

# Ánh xạ thể loại
genre_map = {
    1: "Tiên hiệp", 2: "Huyền huyễn", 3: "Khoa huyễn", 4: "Võng du", 5: "Đô thị",
    6: "Lịch sử", 7: "Quân sự", 8: "Trinh thám", 9: "Linh dị", 10: "Tình cảm",
    11: "Đam mỹ", 12: "Nữ hiệp", 13: "Cổ đại", 14: "Hiện đại", 15: "Xuyên không",
    16: "Trọng sinh", 17: "Hài hước", 18: "Điền văn", 19: "Cung đấu", 20: "Gia đấu",
    21: "Dị giới", 22: "Dị năng", 23: "Trùng sinh", 24: "Nhan sắc", 25: "Ngọt sủng",
    26: "Cường thủ hào đoạt", 27: "Sủng", 28: "Ngược", 29: "Hệ thống", 30: "Thanh mai trúc mã",
    31: "Mạt thế", 32: "Truyền thuyết", 33: "Vườn trường", 34: "Tây phương", 35: "Cổ điển",
    36: "Thần thoại", 37: "Quỷ dị", 38: "Tái sinh", 39: "Tu chân", 40: "Tiên lữ kỳ duyên"
}

# Cấu trúc dữ liệu kết quả
results = {key: [] for key in all_data.keys()}

# Xử lý từng mục
for category_name, books in all_data.items():
    print(f"\n📚 Đang xử lý mục: {category_name} - Số truyện: {len(books)}")
    
    for idx, book in enumerate(books, 1):
        try:
            slug = book.get("slug", "") or book.get("bookId", "")
            if not slug:
                continue
                
            link = f"https://truyenchu.com.vn/{slug}" if slug else book.get("url", "")
            
            # Xử lý ảnh bìa
            cover_url = book.get("coverUrl", "") or book.get("cover", "") or book.get("image", "")
            if cover_url:
                if not cover_url.startswith("http"):
                    cover_url = f"https://static.truyenchu.com.vn{cover_url}"
            else:
                cover_url = f"https://static.truyenchu.com.vn/Data/{slug}/300.jpg"
            
            # Xử lý thể loại
            genre_ids = book.get("genres", []) or book.get("genreIds", [])
            genres = [genre_map.get(id, f"Thể loại {id}") for id in genre_ids if id in genre_map]
            
            # Xử lý tên truyện
            name = book.get("name", "") or book.get("bookName", "") or book.get("title", "Không rõ")
            
            # Xử lý số chương
            chapter_count = book.get("chapterCount", 0) or book.get("totalChapter", 0) or book.get("chapters", 0)
            
            # Thêm vào kết quả
            results[category_name].append({
                "ten": name.strip(),
                "link": link,
                "mo_ta": book.get("introduction", "") or book.get("description", "").strip(),
                "so_chuong": f"{chapter_count} chương",
                "the_loai": ", ".join(genres),
                "anh": cover_url
            })
            
            print(f"✅ [{idx}/{len(books)}] Đã xử lý: {name}")

        except Exception as e:
            print(f"⚠️ Lỗi khi xử lý truyện: {name} - {e}")

# Lưu kết quả xử lý vào file đầy đủ
with open(full_data_path, "w", encoding="utf-8") as f:
    json.dump(results, f, ensure_ascii=False, indent=2)

# Thống kê
total_books = sum(len(books) for books in results.values())
print(f"\n✅ Đã xử lý thành công {total_books} truyện")
for category, books in results.items():
    print(f"- {category}: {len(books)} truyện")
print(f"🎉 Dữ liệu đã được lưu vào {full_data_path}")
