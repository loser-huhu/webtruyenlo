import json
import os

from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_cors import CORS

# --------- KHỞI TẠO ỨNG DỤNG ----------
app = Flask(__name__)
CORS(app)

# --------- CẤU HÌNH DATABASE ----------
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:1234@localhost/webtruyen'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'baomat'

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

# --------- CÁC BẢNG TRONG DATABASE ----------
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

class Truyen(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    tieude = db.Column(db.String(200), nullable=False)
    tacgia = db.Column(db.String(100), nullable=False)
    noidung = db.Column(db.Text, nullable=False)
    nguoidang = db.Column(db.String(80), nullable=False)

class BinhLuan(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    truyen_id = db.Column(db.Integer, nullable=False)
    noidung = db.Column(db.Text, nullable=False)
    nguoidung = db.Column(db.String(80), nullable=False)

# --------- API ĐĂNG KÝ ----------
@app.route('/register', methods=['POST'])
def register():
    data = request.json
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    user = User(username=data['username'], password=hashed_password)
    db.session.add(user)
    db.session.commit()
    return jsonify(message="Đăng ký thành công"), 201

# --------- API ĐĂNG NHẬP ----------
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = User.query.filter_by(username=data['username']).first()
    if user and bcrypt.check_password_hash(user.password, data['password']):
        token = create_access_token(identity=user.username)
        return jsonify(access_token=token), 200
    return jsonify(message="Sai tài khoản hoặc mật khẩu"), 401

# --------- API ĐĂNG TRUYỆN ----------
@app.route('/truyen', methods=['POST'])
@jwt_required()
def dang_truyen():
    data = request.json
    username = get_jwt_identity()
    truyen = Truyen(
        tieude=data['tieude'],
        tacgia=data['tacgia'],
        noidung=data['noidung'],
        nguoidang=username
    )
    db.session.add(truyen)
    db.session.commit()
    return jsonify(message="Đăng truyện thành công"), 201

# --------- API LẤY DANH SÁCH TRUYỆN MYSQL ----------
@app.route('/truyen', methods=['GET'])
def get_truyen():
    truyen_list = Truyen.query.all()
    result = []
    for truyen in truyen_list:
        result.append({
            'id': truyen.id,
            'tieude': truyen.tieude,
            'tacgia': truyen.tacgia,
            'noidung': truyen.noidung,
            'nguoidang': truyen.nguoidang
        })
    return jsonify(result)

# --------- API BÌNH LUẬN ----------
@app.route('/binhluan', methods=['POST'])
@jwt_required()
def binh_luan():
    data = request.json
    username = get_jwt_identity()
    binhluan = BinhLuan(
        truyen_id=data['truyen_id'],
        noidung=data['noidung'],
        nguoidung=username
    )
    db.session.add(binhluan)
    db.session.commit()
    return jsonify(message="Bình luận thành công"), 201

@app.route('/binhluan/<int:truyen_id>', methods=['GET'])
def get_binhluan(truyen_id):
    bl_list = BinhLuan.query.filter_by(truyen_id=truyen_id).all()
    result = []
    for bl in bl_list:
        result.append({
            'id': bl.id,
            'noidung': bl.noidung,
            'nguoidung': bl.nguoidung
        })
    return jsonify(result)

# --------- API FULL TRUYEN MYSQL + JSON ----------
@app.route('/full_truyen', methods=['GET'])
def get_full_truyen():
    result = []

    # Lấy từ MySQL
    truyen_list = Truyen.query.all()
    for truyen in truyen_list:
        result.append({
            'id': f"mysql_{truyen.id}",
            'tieude': truyen.tieude,
            'tacgia': truyen.tacgia,
            'noidung': truyen.noidung,
            'nguoidang': truyen.nguoidang
        })

    # Lấy từ file JSON crawl
    json_file_path = os.path.join(os.path.dirname(__file__), '..', 'Json', 'truyenchu_full_data.json')
    if os.path.exists(json_file_path):
        with open(json_file_path, 'r', encoding='utf-8') as f:
            json_data = json.load(f)
            for category in json_data.values():
                for item in category:
                    result.append({
                        'id': f"json_{item.get('id', '')}",
                        'tieude': item.get('name', ''),
                        'tacgia': item.get('author', ''),
                        'noidung': '',
                        'nguoidang': 'Crawler'
                    })
    else:
        print("Không tìm thấy file JSON!")

    return jsonify(result), 200

# --------- API GỘP TRUYENCHU_FULL_DATA + USER_UPLOADED ----------
@app.route('/all-stories', methods=['GET'])
def get_all_stories():
    try:
        # Đọc file JSON truyenchu_full_data.json (là dict)
        json_file_path = os.path.join(os.path.dirname(__file__), '..', 'Json', 'truyenchu_full_data.json')
        with open(json_file_path, 'r', encoding='utf-8') as f:
            data_crawled = []
            json_data = json.load(f)
            for category in json_data.values():
                for item in category:
                    data_crawled.append(item)

        # Đọc thêm file user_uploaded_stories.json (list)
        user_uploaded_file = os.path.join(os.path.dirname(__file__), '..', 'Json', 'user_uploaded_stories.json')
        user_uploaded = []
        if os.path.exists(user_uploaded_file):
            with open(user_uploaded_file, 'r', encoding='utf-8') as f:
                user_uploaded = json.load(f)

        # Gộp 2 danh sách lại
        combined = data_crawled + user_uploaded

        # Loại bỏ trùng lặp theo 'link'
        seen_links = set()
        merged_data = []
        for item in combined:
            if item.get('link') not in seen_links:
                seen_links.add(item.get('link'))
                merged_data.append(item)

        return jsonify(merged_data), 200

    except Exception as e:
        return jsonify(message="Đã xảy ra lỗi", error=str(e)), 500

# --------- CHẠY ỨNG DỤNG ----------
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='127.0.0.1')

