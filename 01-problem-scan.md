# 🔍 01 — Problem Scan & Quick Assess (Vin Smart Future)

---

## 📋 Phase 1 — SCAN: Danh sách 5 bài toán vận hành (4 Lenses)

Sử dụng **4 Lenses** (Lặp lại, Tốn thời gian, AI có thể tốt hơn, Pain từ người khác) để quét qua hoạt động vận hành của các công ty thành viên Vingroup.

| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | **Xanh SM** | Tốn thời gian | Điều phối viên xử lý thủ công các phản hồi khẩn cấp từ tài xế về sự cố hết pin giữa đường, cần xác định vị trí và điều xe sạc pin di động (mất 15–20 phút/lượt). |
| 2 | **Vinhomes** | Lặp lại | Phân loại và gán nhãn tự động hàng trăm phản ánh/khiếu nại của cư dân trên App Vinhomes Resident để chuyển chính xác đến ban quản lý từng tòa nhà. |
| 3 | **Vinpearl** | Pain từ người khác | Quét qua các review trên Booking.com, Agoda, Google Map của Vinpearl để lọc ra các phàn nàn khẩn cấp (ví dụ: *"phòng bẩn"*, *"nhân viên thái độ tệ"*) gửi về Manager. |
| 4 | **VinFast** | AI có thể tốt hơn | Tự động phân tích mô tả triệu chứng bằng tiếng Việt đời thường của chủ xe để chẩn đoán sơ bộ và ánh xạ sang danh mục linh kiện/mã lỗi kỹ thuật trước khi khách đem xe đến xưởng. |
| 5 | **Vinmec** | Tốn thời gian | Trích xuất thông tin lâm sàng từ bệnh án điện tử và kết quả xét nghiệm để soạn thảo bản tóm tắt hồ sơ xuất viện (Discharge Summary) bằng ngôn ngữ dễ hiểu cho bệnh nhân. |

---

## 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards

Chọn **Top 3 bài toán** tiềm năng nhất từ danh sách SCAN ở trên:
* **Card #1:** Xanh SM — Điều vận cứu hộ & trạm sạc khi xe hết pin thực địa
* **Card #2:** Vinhomes — Phân loại & điều hướng phản ánh cư dân trên App Resident
* **Card #3:** Vinpearl — Quét & phát hiện phàn nàn khẩn cấp từ review đa nền tảng

---

### 📇 Quick Problem Card #1 — Xanh SM (Sự cố sạc pin thực địa)

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Hỗ trợ điều phối viên xử lý sự cố tài xế │
│ báo hết pin khẩn cấp giữa đường: xác định vị trí, tìm trạm │
│ sạc trống phù hợp hoặc điều xe sạc di động và draft tin nhắn.│
│                                                             │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác                   │
│                                                             │
│ Ai đang đau (Actor)? Tài xế Xanh SM (sợ hết pin giữa       │
│ đường), Điều phối viên Dispatcher (quá tải giờ cao điểm).   │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Tài xế gọi tổng đài báo hết pin                        │
│   ──> 2. Điều phối viên tra cứu vị trí GPS xe trên bản đồ   │
│   ──> 3. Tra cứu dashboard trạm sạc VinFast tìm cổng trống │
│   ──> 4. Soạn tin nhắn hướng dẫn/đường đi gửi app tài xế    │
│   ──> 5. Gọi đội xe cứu hộ sạc pin nếu pin xe báo < 5%      │
│                                                             │
│ Bước tốn thời gian/lỗi nhất? Bước 3 & 4 (⏱ 10-12 min)   │
│ AI có thể hỗ trợ ở bước 3 & 4: Tự động   │
│ gom dữ liệu vị trí + pin, tra cứu trạm sạc gần nhất, kiểm   │
│ tra ngưỡng an toàn (<5%) và tự động draft tin nhắn hướng dẫn.│
│                                                             │
│ Đo thành công bằng:                        │
│ - Giảm thời gian xử lý sự cố từ 15 min ──> dưới 3 min/lượt. │
│ - Tỉ lệ chỉ đúng trạm sạc còn cổng khả dụng đạt >= 95%.     │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

---

### 📇 Quick Problem Card #2 — Vinhomes (Phân loại phản ánh cư dân)

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Đọc hiểu văn bản phản ánh của cư dân trên │
│ App Vinhomes Resident để tự động phân loại lĩnh vực, mức độ │
│ khẩn cấp và chuyển tiếp ticket đến đúng ban quản lý tòa nhà.│
│                                                             │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác                   │
│                                                             │
│ Cư dân (chờ lâu, ức chế vì bị chuyển   │
│ lòng vòng), Nhân viên CSKH/BQL (mất hàng giờ đọc & gõ tay). │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Cư dân gửi phản ánh kèm hình ảnh qua App Resident      │
│   ──> 2. Nhân viên CSKH đọc và phân tích loại sự cố         │
│   ──> 3. Chọn thủ công bộ phận (Điện nước/An ninh/Vệ sinh)  │
│   ──> 4. Kỹ thuật viên nhận ticket và liên hệ xử lý         │
│                                                             │
│ Bước tốn thời gian/lỗi nhất: Bước 2 & 3 (⏱ 6-8 min/vé) │
│ AI có thể hỗ trợ ở bước 2 & 3: Đọc hiểu  │
│ ngôn ngữ tự nhiên, trích xuất thực thể (phòng, tầng, sự cố) │
│ và tự động gán nhãn phân loại ticket theo JSON schema.      │
│                                                             │
│ Đo thành công bằng:                    │
│ - Giảm thời gian phân luồng ticket từ 8 min ──> dưới 10 giây│
│ - Độ chính xác phân loại đúng phòng ban đạt >= 92%.         │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

---

### 📇 Quick Problem Card #3 — Vinpearl (Phát hiện phàn nàn khẩn cấp từ review)

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Quét và phân tích sắc thái cảm xúc từ các │
│ đánh giá của khách trên Agoda/Booking/Google Maps để cảnh   │
│ báo tức thì các phàn nàn nghiêm trọng cho General Manager.  │
│                                                             │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [x] Khác: Vinpearl/Resort  │
│                                                             │
│ Giám đốc vận hành khách sạn (biết phốt │
│ quá muộn khi khách đã về), Du khách (bị ức chế dịch vụ).    │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Nhân viên CSKH mỗi sáng mở từng trang OTA đọc review   │
│   ──> 2. Copy review 1-2 sao vào file Excel theo dõi        │
│   ──> 3. Tóm tắt nội dung phàn nàn & gán bộ phận liên quan  │
│   ──> 4. Gửi email báo cáo hàng ngày cho Ban giám đốc       │
│                                                             │
│ Bước tốn thời gian/lỗi nhất: Bước 1 & 2 (⏱ 90-120 min)  │
│ AI có thể hỗ trợ ở bước 2 & 3: Tự động   │
│ phân tích sentiment, trích xuất phàn nàn khẩn cấp (phòng    │
│ bẩn, thái độ tệ) và bắn thông báo ngay qua Zalo/Slack nội bộ│
│                                                             │
│ Đo thành công bằng:                        │
│ - Rút ngắn thời gian phát hiện phàn nàn từ 18 giờ ──> < 15p │
│ - Tỉ lệ lọc đúng các đánh giá tiêu cực nghiêm trọng >= 95%. │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

---

## 🗳️ Quyết định lựa chọn bài toán để thực hiện Phase 3 (Deep-Dive)

Nhóm quyết định lựa chọn **Card #1 — Xanh SM: Điều vận cứu hộ & trạm sạc khi xe hết pin thực địa** để thực hiện phân tích sâu ở Phase 3.

### Lý do lựa chọn:
1. **Giá trị vận hành thời gian thực (Real-time Impact):** Sự cố pin xe taxi là vấn đề phát sinh tức thì trên đường, trực tiếp gây tắc nghẽn giao thông, hủy cuốc và sụt giảm doanh thu của Xanh SM nếu không xử lý trong vòng vài phút.
2. **Ranh giới an toàn (Operational Boundary) rõ ràng & sống còn:** Có ranh giới an toàn đo lường được bằng số (ngưỡng pin < 5% tuyệt đối không cho chạy xa > 5km mà phải điều xe cứu hộ; tin nhắn nháp bắt buộc gắn nhãn `[DRAFT_ONLY]` để kiểm duyệt).
3. **Độ tương thích cao với Prototype (Phase 4):** Khớp hoàn toàn với bộ khung mã nguồn và bài test tấn công prompt trong `starter-code/prompt_prototype.py`.

### Lý do loại bỏ các thẻ khác:
* **Loại Card #2 (Vinhomes):** Tác vụ phân loại phản ánh mang tính nghiệp vụ nội bộ thường nhật, ít rủi ro an toàn thực địa tức thì và có thể giải quyết trước mắt bằng Rule-based keyword matching hoặc State Machine đơn giản.
* **Loại Card #3 (Vinpearl):** Tác vụ tổng hợp review mang tính chất back-office và báo cáo hậu kỳ (offline batch processing), không đòi hỏi can thiệp xử lý ngay trong vài giây như sự cố xe điện lưu thông thực tế.
