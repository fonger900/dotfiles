#!/bin/bash

echo "--- 🛠️ Bắt đầu bảo trì hệ thống Debian/Sway ---"

# 1. Cập nhật và nâng cấp hệ thống
echo "👉 Đang kiểm tra cập nhật (APT)..."
sudo apt update && sudo apt full-upgrade -y

# 2. Dọn dẹp rác APT
echo "👉 Đang dọn dẹp gói thừa và cache..."
sudo apt autoremove --purge -y
sudo apt clean

# 3. Cập nhật và dọn dẹp Flatpak (nếu có dùng)
if command -v flatpak &> /dev/null; then
    echo "👉 Đang cập nhật Flatpak..."
    flatpak update -y
    flatpak uninstall --unused -y
fi

# 4. Dọn dẹp Nhật ký hệ thống (Chỉ giữ lại 3 ngày)
echo "👉 Đang hút bụi Log hệ thống..."
sudo journalctl --vacuum-time=3d

# 5. Cập nhật Font cache (Giúp Firefox/Chrome luôn nét)
echo "👉 Đang làm mới Font cache..."
fc-cache -fv > /dev/null

echo "--- ✅ Xong! Hệ thống đã sạch sẽ, nghỉ tay uống cafe thôi Phong! ---"