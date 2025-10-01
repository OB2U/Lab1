#!/bin/bash

URL="http://localhost:5050"
EXPECTED_TEXT="OK"     # hoặc cái chuỗi bạn dùng để nhận diện thành công

# Gọi curl, lấy status code và nội dung
response=$(curl -s -w "%{http_code}" "$URL")
# Tách ra phần mã HTTP (cuối) và phần nội dung (đầu)
http_code="${response: -3}"         # 3 ký tự cuối là mã HTTP
body="${response::-3}"               # phần trước là nội dung thực tế

echo "URL: $URL"
echo "HTTP Code: $http_code"
echo "Body: $body"

# Kiểm tra mã HTTP có phải là 200 → và nội dung có chứa EXPECTED_TEXT
if [[ "$http_code" == "200" && "$body" == *"$EXPECTED_TEXT"* ]]; then
  echo "Health check passed."
  exit 0
else
  echo "Health check failed."
  # Bạn có thể in thêm log chi tiết nếu muốn
  exit 1
fi
