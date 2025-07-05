const fs = require("fs");
const path = require("path");

// Hàm đọc file JSON an toàn
function readJSONFile(filePath) {
  try {
    const rawData = fs.readFileSync(filePath, "utf8");
    return JSON.parse(rawData);
  } catch (err) {
    console.error(`Lỗi khi đọc file ${filePath}:`, err);
    return [];
  }
}

// Hàm chính để gộp dữ liệu
function getMergedData() {
  const mainDataPath = path.join(__dirname, "data", "truyenchu_full_data.json");
  const userDataPath = path.join(
    __dirname,
    "data",
    "user_uploaded_stories.json"
  );

  const mainData = readJSONFile(mainDataPath);
  let userData = [];

  if (fs.existsSync(userDataPath)) {
    userData = readJSONFile(userDataPath);
  }

  // Gộp 2 mảng lại
  const combinedData = [...mainData, ...userData];

  // Loại bỏ trùng lặp theo 'link'
  const uniqueMap = new Map();
  combinedData.forEach((item) => {
    if (!uniqueMap.has(item.link)) {
      uniqueMap.set(item.link, item);
    }
  });

  // Trả về mảng dữ liệu đã gộp
  return Array.from(uniqueMap.values());
}

// Export để dùng ở các file khác
module.exports = {
  getMergedData,
};
