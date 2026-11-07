# 📊 BÁO CÁO PHÂN TÍCH SÂU (DEEP-DIVE REPORT) — LAB 02
**Bài toán:** Dự báo nhu cầu sạc và tối ưu điều phối lựa chọn trạm sạc cho đội xe taxi điện Xanh SM (GSM) & Hệ sinh thái VinFast

---

# 🗳️ 1. QUYẾT ĐỊNH LỰA CHỌN BÀI TOÁN TỪ QUICK CARDS

## 1.1. So sánh đánh giá 3 thẻ bài toán
Sau khi hoàn thành Phase 2 (Quick-Assess), nhóm tiến hành so sánh 3 bài toán:
1. **Card #01 (Vinmec - Quản lý & tối ưu lịch khám):** Bài toán có giá trị nhưng tác động đến y tế, rủi ro sai sót lâm sàng cao, chu kỳ thẩm định pháp lý và quy trình y tế phức tạp.
2. **Card #03 (Vinhomes - Phân loại & xử lý phản ánh cư dân):** Có thể giải quyết phần lớn bằng Rule Engine phân luồng ticket ban đầu; chưa tạo ra đột phá về doanh thu ngay lập tức.
3. **Card #02 (VinFast & Xanh SM - Tối ưu điều phối và dự báo tải trạm sạc):** **ĐƯỢC LỰA CHỌN**.

## 1.2. Lý do lựa chọn Card #02
* **Tác động kinh doanh trực tiếp (High Business Impact):** Xe taxi điện không thể đón khách khi đang phải chờ sạc. Giảm thời gian chờ sạc 20 phút mỗi cuốc tương đương với việc tăng thêm hàng nghìn giờ khai thác đón khách mỗi ngày cho toàn đội xe GSM.
* **Bài toán AI rõ ràng (High AI Fit):** Không thể giải quyết bài toán phân bổ trạm sạc chỉ bằng các quy tắc cố định (Rule-based đơn thuần), vì tình trạng hàng chờ và giao thông thay đổi liên tục theo thời gian thực. Cần sự kết hợp giữa **Dự báo nhu cầu (Predictive ML)** và **Giải thuật tối ưu hóa điều phối (Optimization Engine)**.
* **Tính sẵn sàng của dữ liệu (Data Readiness):** VinFast và GSM đã sở hữu dữ liệu telemetry xe thời gian thực (vị trí GPS, SOC pin, mức tiêu hao kWh/km) và dữ liệu vận hành trụ sạc VinFast.

---

# 🏗️ 2. PHASE 3 — DEEP-DIVE

## 2.1. Current-State Workflow Mapping (Quy trình vận hành hiện tại)

Hiện tại, việc sạc pin hoàn toàn do tài xế tự quyết định mang tính cảm tính và phân tán:
* **Bước 1: Kiểm tra pin (2 phút):** Tài xế nhìn đồng hồ SOC trên xe, thấy pin thấp (~15-20%) thì bắt đầu tính chuyện đi sạc.
* **Bước 2: Tìm kiếm trạm sạc trên ứng dụng (10 phút 🔴 Bottleneck):** Mở app tìm các trạm sạc lân cận. Ứng dụng chỉ hiển thị trạng thái tĩnh của trạm tại thời điểm hiện tại, không dự báo được 15 phút nữa khi xe đến nơi thì trạm có bị xe khác chiếm hết chỗ hay không.
* **Bước 3: Di chuyển đến trạm sạc đã chọn (15 phút):** Lái xe đến trạm dựa trên phán đoán cá nhân.
* **Bước 4: Chờ sạc hoặc đổi trạm khi quá tải (15 - 60 phút 🔴 Bottleneck nghiêm trọng nhất):** Đến nơi gặp tình trạng các trụ sạc đều đang có xe cắm, hàng chờ đông đúc vào giờ cao điểm. Tài xế rơi vào tình thế tiến thoái lưỡng nan: hoặc tắt máy đứng chờ 30-45 phút, hoặc quay đầu xe đi tìm trạm khác (tốn thêm pin và thời gian).
* **Bước 5: Sạc và quay lại khai thác (30 - 45 phút):** Cắm sạc và tiếp tục đón khách.

⏱ **Tổng thời gian xe ngừng khai thác do tìm và chờ sạc:** **25 - 70 phút/lượt sạc**.

---

## 2.2. Problem Statement (6-Field Standard)

| Trường thông tin | Nội dung chi tiết |
| :--- | :--- |
| **1. Actor / Operator** | 1. **Tài xế Xanh SM:** Người trực tiếp tìm trạm, lái xe và chịu áp lực thời gian chờ sạc.<br>2. **Điều phối viên GSM & Quản lý đội xe:** Cần duy trì tỷ lệ xe sẵn sàng hoạt động (Fleet Availability) cao nhất trong giờ cao điểm.<br>3. **Đơn vị vận hành trạm VinFast:** Cần tối ưu hóa công suất khai thác trụ sạc, tránh tình trạng trạm thì quá tải nghẽn mạch, trạm thì bỏ trống lãng phí. |
| **2. Current Workflow** | Tài xế tự kiểm tra SOC ➔ Tự tìm trạm trên app ➔ Di chuyển theo cảm tính ➔ Đến nơi chờ sạc từ 15-60 phút nếu trạm quá tải, hoặc phải đổi trạm khác ➔ Sạc xong quay lại nhận khách. Toàn bộ quy trình phân tán, không có điều phối thông minh. |
| **3. Bottleneck** | **Bước 2 & Bước 4:** Thiếu thông tin dự báo về hàng chờ và tình trạng quá tải trong tương lai gần (15-60 phút tới). Tài xế đổ dồn vào một vài trạm sạc trung tâm, gây tắc nghẽn cục bộ và làm tăng thời gian chờ sạc lên 30-60 phút. |
| **4. Business Impact** | • Thời gian xe chết (downtime) do chờ sạc làm sụt giảm ~15-20% hiệu suất vận hành của đội xe GSM vào giờ cao điểm.<br>• Tỷ lệ phải đổi trạm do quá tải lên tới ~15%, làm tiêu hao thêm pin và tăng chi phí di chuyển rỗng.<br>• Tài xế căng thẳng, giảm thu nhập; khách hàng khó đặt xe do thiếu hụt phương tiện sẵn sàng phục vụ. |
| **5. Success Metric** | 1. **Thời gian chờ tại trạm:** Giảm từ baseline 30 phút xuống **dưới 10 phút**.<br>2. **Thời gian tìm và chọn trạm:** Giảm từ 10 phút xuống **dưới 3 phút**.<br>3. **Tỷ lệ phải đổi trạm do quá tải:** Giảm từ 15% xuống **dưới 5%**.<br>4. **Độ chính xác dự báo nhu cầu sạc trạm:** Sai số MAPE **dưới 20%**.<br>5. **Fleet Availability (Tỷ lệ xe sẵn sàng):** Tăng tối thiểu **5 điểm phần trăm** trong giờ cao điểm. |
| **6. Operational Boundary** | **AI ĐƯỢC PHÉP:** Phân tích dữ liệu pin SOC, vị trí GPS; dự báo tải trạm sạc; gợi ý lộ trình và đề xuất thời điểm + trạm sạc tối ưu trực tiếp trên app tài xế.<br>**AI TUYỆT ĐỐI CẤM:**<br>• Cấm ép buộc xe đi sạc khi tài xế đang có khách trên xe (ưu tiên tuyệt đối cho hành khách).<br>• Cấm điều hướng xe đến trạm có khoảng cách vượt quá phạm vi di chuyển an toàn của mức pin hiện tại.<br>• Cấm đề xuất các trạm đang báo lỗi kỹ thuật, bảo trì hoặc không có loại cổng sạc tương thích với dòng xe. |

---

## 2.3. Future-State Flow & AI Fit (Kiến trúc & Quy trình tương lai)

### 2.3.1. Phân định AI Fit (Công nghệ sử dụng)
Hệ thống là sự kết hợp **Hybrid AI**:
* **Rule Engine:** Kiểm tra các điều kiện an toàn cứng (SOC tối thiểu, kiểm tra loại cổng CCS2 tương thích với dòng xe VF5/VF8, cấm điều xe đang chở khách).
* **Predictive ML (Mô hình chuỗi thời gian / GBDT):** Dự báo nhu cầu sạc và thời gian chờ tại từng trạm trong 15-60 phút tới dựa trên lưu lượng xe di chuyển, thói quen sạc và lịch sử trạm.
* **Optimization Engine (Thuật toán tối ưu hóa / Linear Programming / Genetic Algorithm):** Giải bài toán phân bổ đội xe, đề xuất trạm sạc tối ưu cân bằng giữa: khoảng cách ngắn nhất, thời gian chờ ít nhất và chi phí sạc thấp nhất.

### 2.3.2. Sơ đồ quy trình tương lai (Future-State Flow)

```text
┌──────────────────────┐      ┌─────────────────────────────┐      ┌─────────────────────────────┐      ┌─────────────────────────────┐
│ Bước 1               │      │ Bước 2                      │      │ Bước 3                      │      │ Bước 4                      │
│ Hệ thống Telemetry   │      │ 🔵 Predictive ML            │      │ 🔵 Optimization Engine      │      │ 🟢 Tài xế xác nhận          │
│ giám sát SOC pin     │ ───> │ Dự báo hàng chờ & tình trạng│ ───> │ Đề xuất trạm sạc & thời điểm│ ───> │ Xem đề xuất trên app,       │
│ & trạng thái xe      │      │ quá tải của các trạm lân cận│      │ tối ưu nhất (giảm chờ đợi)  │      │ xác nhận và di chuyển       │
└──────────────────────┘      └─────────────────────────────┘      └─────────────────────────────┘      └─────────────────────────────┘
                                                                                  │                                    │
                                                                                  ▼                                    ▼
                                                                     ┌─────────────────────────────┐           Đến trạm có trụ trống,
                                                                     │ ↩️ Fallback Plan             │           cắm sạc ngay mà
                                                                     │ Nếu hệ thống tối ưu lỗi/mất │           không phải xếp hàng
                                                                     │ mạng, app quay về chế độ tìm│
                                                                     │ trạm theo khoảng cách cũ    │
                                                                     └─────────────────────────────┘
```

---

# 🏁 3. PHASE 5 — EVALUATE & KẾT LUẬN

### 3.1. AI Readiness Checklist
* [x] **Dữ liệu mẫu/logs sạch:** VinFast và GSM đã có sẵn logs sạc, lịch sử dòng sạc, telemetry GPS và trạng thái trụ sạc theo thời gian thực.
* [x] **Kiểm soát rủi ro:** Rủi ro được khoanh vùng bằng Rule Engine (luôn đảm bảo pin xe đủ đến trạm, có cơ chế Fallback tự tìm trạm nếu mạng chập chờn).
* [x] **Stakeholders sẵn sàng:** Tài xế GSM nhiệt liệt ủng hộ giải pháp giúp họ không phải xếp hàng chờ sạc vô ích vào giờ cao điểm.

### 3.2. Quyết định cuối cùng
👉 **QUYẾT ĐỊNH: GO (Triển khai PoC thử nghiệm có giới hạn)**

**Biện luận (Justification):**
* **Chi phí & Lợi nhuận:** Dự án có tỷ lệ ROI cực kỳ rõ ràng. Việc tăng thêm 5% tỷ lệ xe hoạt động (Fleet Availability) sẽ trực tiếp mang lại thêm hàng chục nghìn lượt đón khách mỗi tuần cho GSM mà không cần phải đầu tư mua thêm xe mới.
* **Khả thi kỹ thuật:** Bài toán dự báo chuỗi thời gian (Predictive ML) và thuật toán tối ưu hóa (Optimization) đã có nhiều giải pháp chín muồi trong ngành logistics và giao thông thông minh.
* **Lộ trình PoC:** Đề xuất thử nghiệm PoC tại 5-10 trạm sạc có lưu lượng cao nhất tại Hà Nội trong vòng 4-6 tuần trước khi triển khai trên toàn quốc.