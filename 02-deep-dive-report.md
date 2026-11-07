# 🏗️ Báo Cáo Phân Tích Chuyên Sâu (Deep-Dive Report)
## Dự án: Trợ lý Điều vận Thông minh Xanh SM — Xử lý Sự cố Sạc pin & Hết pin Thực địa
**Đơn vị phụ trách:** Vin Smart Future — AI Engineering Team  
**Đối tác vận hành:** Xanh SM (GSM — Green Smart Mobility)

---

# 🏛️ 1. Lựa chọn bài toán

Dựa trên kết quả đánh giá nhanh tại **Phase 2 (QUICK-ASSESS)**, nhóm quyết định chọn **Card #1 — Xanh SM: Điều vận cứu hộ & trạm sạc khi xe hết pin thực địa** để thực hiện phân tích sâu.

### Lý do lựa chọn:
* **Tính cấp thiết thời gian thực (Real-time Urgency):** Taxi điện hết pin trên đường đón khách hoặc giờ cao điểm gây ùn tắc giao thông, rò rỉ cuốc xe và ảnh hưởng trực tiếp đến trải nghiệm của khách hàng cũng như thu nhập của tài xế Xanh SM.
* **Ranh giới an toàn (Operational Boundary) sống còn:** Có ngưỡng định lượng cụ thể: pin `< 5%` tuyệt đối không được hướng dẫn xe chạy tới trạm sạc xa quá 5km (nguy cơ chết máy giữa đường) mà phải điều ngay xe sạc pin lưu động (Mobile Charger).
* **Khả thi về công nghệ:** Quy trình nghiệp vụ rõ ràng, giải pháp ở mức **LLM Feature** kết hợp Rule-based checking, vừa mang lại ROI cao vừa kiểm soát được rủi ro ảo giác (hallucination) qua cơ chế Human-in-the-loop.

---

# 📊 3.1. Current-State Workflow Mapping (Quy trình hiện tại)

### 🔄 Mô tả chi tiết 5 bước vận hành thủ công:
1. **Bước 1 — Tiếp nhận thông báo sự cố (⏱ 2 phút):**  
   * *Actor:* Tài xế Xanh SM & Điều phối viên (Dispatcher).
   * *Handoff:* Tài xế gọi hotline điều vận khẩn cấp báo xe sắp cạn pin/gặp sự cố sạc. Điều phối viên ghi nhận biển số xe và tình trạng ban đầu.
2. **Bước 2 — Tra cứu vị trí và tình trạng xe (⏱ 2 phút):**  
   * *Actor:* Điều phối viên.
   * *Công cụ:* Dashboard quản lý đội xe (Fleet Telematics).
   * *Handoff:* Nhập biển số để lấy tọa độ GPS thực tế và mức dung lượng pin hiện tại (SoC %).
3. **Bước 3 — Tra cứu trạm sạc khả dụng (⏱ 5 phút 🔴 Bottleneck):**  
   * *Actor:* Điều phối viên.
   * *Công cụ:* Hệ thống giám sát trạm sạc VinFast.
   * *Vấn đề:* Điều phối viên phải đối chiếu thủ công khoảng cách giữa xe và các trạm sạc lân cận, đồng thời kiểm tra xem trạm còn cổng sạc trống phù hợp với dòng xe (VF5, VF8, VF9 - cổng CCS2) hay không.
4. **Bước 4 — Soạn thảo tin nhắn hướng dẫn tài xế (⏱ 5 phút 🔴 Bottleneck):**  
   * *Actor:* Điều phối viên.
   * *Công cụ:* Hệ thống tin nhắn nội bộ / App tài xế Xanh SM Driver.
   * *Vấn đề:* Phải gõ tay địa chỉ trạm sạc, hướng dẫn lộ trình di chuyển ngắn nhất và lưu ý về tình trạng giao thông. Dễ gõ sai chính tả hoặc nhầm lẫn địa chỉ trong giờ cao điểm.
5. **Bước 5 — Điều xe cứu hộ pin lưu động (⏱ 1 phút - nếu cần):**  
   * *Actor:* Điều phối viên & Đội Mobile Charger.
   * *Thực hiện:* Nếu pin dưới 5%, điều phối viên phải gọi điện sang đội xe cứu hộ sạc pin để điều xe đến vị trí của tài xế.

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Bước 1          │       │ Bước 2          │       │ Bước 3          │
│ Tiếp nhận cuộc  │ ────> │ Tra cứu định    │ ────> │ Tra cứu trạm    │
│ gọi từ tài xế   │ 🔄    │ vị GPS & pin %  │ 🔄    │ sạc trống       │
│ ⏱ 2 phút        │       │ ⏱ 2 phút        │       │ ⏱ 5 phút 🔴     │
│ In: Điện thoại  │       │ In: Biển số xe  │       │ In: GPS, SoC %  │
│ Out: Ticket sự cố│      │ Out: Toạ độ xe  │       │ Out: Trạm sạc   │
└─────────────────┘       └─────────────────┘       └─────────────────┘
                                                             │
                                                             ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Kết thúc        │       │ Bước 5          │       │ Bước 4          │
│ Tài xế nạp sạc  │ <──── │ Điều xe cứu hộ  │ <──── │ Soạn tin hướng  │
│ hoặc cứu hộ đến │ 🔄    │ (nếu SoC < 5%)  │ 🔄    │ dẫn gửi tài xế  │
│                 │       │ ⏱ 1 phút        │       │ ⏱ 5 phút 🔴     │
└─────────────────┘       └─────────────────┘       └─────────────────┘

Ký hiệu:
🔴 = Bottleneck (Điểm nghẽn gây lãng phí thời gian nhiều nhất: Bước 3 & 4)
🔄 = Handoff (Điểm chuyển giao thông tin giữa người ↔ hệ thống)
⏱ Tổng thời gian xử lý thủ công: ~15 phút/lượt
```

---

# 🎯 3.2. Problem Statement (6-Field) — Vin Smart Future Standard

| Trường thông tin | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Điều phối viên (Dispatcher) thuộc Trung tâm Vận hành & Điều vận Xanh SM (GSM). |
| **2. Current Workflow** | Khi tài xế báo hết pin, điều phối viên tiếp nhận cuộc gọi, mở hệ thống Fleet Telematics tra vị trí xe, mở Dashboard trạm sạc VinFast tìm trụ sạc trống phù hợp loại xe, tự soạn tin nhắn SMS hướng dẫn đường đi gửi qua App tài xế, và gọi cứu hộ nếu pin nguy cấp. Gồm 5 bước thủ công hoàn toàn bằng tay. |
| **3. Bottleneck** | **Bước 3 & Bước 4 (Chiếm 10/15 phút):** Tra cứu thủ công trụ sạc trống phù hợp với cổng sạc của xe và gõ tay tin nhắn hướng dẫn đường đi chi tiết bằng Tiếng Việt. |
| **4. Business Impact** | • Trung bình **~80 sự cố hết pin/ngày** tại Hà Nội & TP.HCM.<br>• Tiêu tốn **20 giờ lao động/ngày** của đội ngũ điều phối viên trong giờ cao điểm.<br>• Tăng thời gian chết của xe, gây rò rỉ ước tính **15% doanh thu cuốc xe** và làm tăng nguy cơ ùn tắc giao thông đô thị khi xe chết máy giữa đường. |
| **5. Success Metric** | 1. **Hiệu suất (Efficiency):** Giảm thời gian xử lý sự cố từ **15 phút ──> dưới 3 phút/lượt**.<br>2. **Chất lượng (Quality):** Tỉ lệ đề xuất trạm sạc đúng loại cổng và còn trụ khả dụng đạt **≥ 95%**.<br>3. **Độ an toàn:** Không có trường hợp nào xe dưới 5% pin bị hướng dẫn đi xa dẫn đến chết máy giữa đường. |
| **6. Operational Boundary (Ranh giới)** | • **Được phép:** Tự động lấy tọa độ GPS xe, gọi API kiểm tra trạm sạc trống VinFast, tự động soạn thảo tin nhắn hướng dẫn dạng bản nháp.<br>• **CẤM TUYỆT ĐỐI:** AI không được tự động phát lệnh gửi tin nhắn cho tài xế khi chưa có điều phối viên bấm xác nhận (Bắt buộc Human-in-the-loop). Tin nhắn draft luôn phải mở đầu bằng thẻ `[DRAFT_ONLY]`.<br>• **Ngưỡng an toàn pin:** Nếu pin xe `< 5%`, AI **TUYỆT ĐỐI CẤM** gợi ý trạm sạc cách xa quá 5km, mà bắt buộc phải trả về lệnh kích hoạt xe sạc pin di động: `{"action": "dispatch_mobile_charger"}`. |

---

# 🚀 3.3. Future-State Flow & AI Fit

### 1. Phân tích AI-Fit Matrix:
* **Không chọn Rule-based đơn thuần:** Vì việc tổng hợp vị trí, tình trạng pin, điều kiện giao thông và sinh tin nhắn hướng dẫn thân thiện bằng tiếng Việt linh hoạt đòi hỏi khả năng xử lý ngôn ngữ tự nhiên.
* **Không chọn Autonomous Agent:** Vì quy trình có rủi ro an toàn thực địa rất cao; trao toàn quyền tự động cho Agent tự dispatch có thể gây lỗi điều vận nghiêm trọng.
* **LỰA CHỌN TỐI ƯU:** **`LLM Feature` (Dispatcher Co-pilot)** kết hợp Rule-based checking. AI đóng vai trò người trợ lý tổng hợp dữ liệu, đề xuất phương án và soạn sẵn bản nháp; điều phối viên con người giữ quyền quyết định cuối cùng.

### 2. Quy trình tương lai (Future-State Flow):

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Bước 1          │       │ Bước 2          │       │ Bước 3          │
│ Tài xế báo      │ ────> │ 🔵 AI Auto-pull │ ────> │ 🔵 AI Rule Check│
│ sự cố qua app   │       │ GPS, SoC % &    │       │ & LLM Draft     │
│                 │       │ Trạm sạc trống  │       │ Hướng dẫn       │
│                 │       │ (API tự động)   │       │ (Kèm DRAFT_ONLY)│
└─────────────────┘       └─────────────────┘       └─────────────────┘
                                                             │
                                                             ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ ↩️ Fallback     │       │ Gửi tin / Lệnh  │       │ 🟢 Human Step   │
│ Dispatcher tự xử│ <──── │ điều xe cứu hộ  │ <──── │ Điều phối viên  │
│ lý thủ công khi │(Lỗi)  │ phát đi tức thì │(Duyệt)│ xem & bấm Duyệt │
│ AI timeout/fail │       │ ⏱ < 10 giây     │       │ ⏱ 15-30 giây    │
└─────────────────┘       └─────────────────┘       └─────────────────┘

Chú thích:
🔵 AI Step: Hệ thống tự động gom dữ liệu và dùng LLM soạn thảo phương án tối ưu.
🟢 Human Step (HITL): Điều phối viên kiểm tra nhanh và bấm nút phê duyệt (Human-in-the-loop).
↩️ Fallback: Cơ chế chuyển mạch về quy trình thủ công cũ nếu LLM gặp sự cố hoặc timeout (> 5 giây).
```

---

# 🏁 Phase 5 — EVALUATE: Đánh Giá Độ Sẵn Sàng & Quyết Định Đầu Tư

### 1. AI Readiness Checklist:
* [x] **Dữ liệu:** VinFast và Xanh SM đã có sẵn API Telematics (GPS, SoC %) và API trạng thái trạm sạc thời gian thực.
* [x] **Kiểm soát rủi ro:** Cơ chế Human-in-the-loop (bắt buộc điều phối viên duyệt) và Fallback đảm bảo không có rủi ro tự động phát tán tin nhắn sai.
* [x] **Sự sẵn sàng của Stakeholder:** Đội ngũ điều phối viên rất ủng hộ vì giải pháp giúp họ giảm 80% áp lực thao tác thủ công trong giờ cao điểm.

### 2. Quyết định cuối cùng của Hội đồng Vin Smart Future:
* **Quyết định:** **[x] GO (Bắt đầu phát triển Prototype)**

### 3. Lý giải quyết định (Justification):
1. **Giá trị kinh tế & vận hành rõ ràng:** Rút ngắn thời gian xử lý từ 15 phút xuống dưới 3 phút giúp tiết kiệm hơn 16 giờ làm việc/ngày cho bộ phận điều vận, giảm tỉ lệ xe dừng chờ sạc và tăng năng suất phục vụ khách hàng thêm 10–15%.
2. **Chi phí triển khai thấp:** Sử dụng mô hình **Gemini 2.5 Flash** cho chi phí suy luận (inference cost) cực kỳ rẻ (vài USD/tháng cho hàng nghìn lượt gọi API) với độ trễ phản hồi dưới 1.5 giây.
3. **An toàn kiểm soát tuyệt đối:** Ranh giới an toàn được lập trình chặt chẽ bằng System Prompt và Assertions kiểm tra trong code prototype, đảm bảo xe cạn pin nguy cấp luôn được điều xe cứu hộ kịp thời.

