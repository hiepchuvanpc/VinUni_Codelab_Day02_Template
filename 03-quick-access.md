# PHASE 2 — QUICK-ASSESS

## QUICK PROBLEM CARD #1 — Vinhomes

**Bài toán:** Tự động phân loại và điều hướng phản ánh cư dân đến đúng bộ phận xử lý.

**Ai đang đau?**  
Nhân viên chăm sóc khách hàng, Ban quản lý tòa nhà và cư dân.

**Workflow thủ công hiện tại:**

1. Cư dân gửi phản ánh qua ứng dụng hoặc tổng đài.
2. Nhân viên đọc nội dung và xác định loại vấn đề.
3. Nhân viên xác định bộ phận chịu trách nhiệm.
4. Ticket được chuyển đến đội kỹ thuật, an ninh hoặc vận hành.
5. Nhân viên theo dõi phản hồi.

**Bước tốn thời gian/lỗi nhất:**  
Đọc nội dung tự do và xác định đúng loại vấn đề, đội xử lý.

**AI có thể hỗ trợ:**  
LLM đọc nội dung phản ánh và đề xuất category, priority và đội xử lý.

**Success Metric đề xuất:**

- Giảm thời gian phân loại ban đầu.
- Đạt độ chính xác cao trên bộ dữ liệu kiểm thử.
- Giảm số ticket bị chuyển sai bộ phận.

**Quick Architecture:** Rule + LLM Feature.

---

## QUICK PROBLEM CARD #2 — Vinpearl

**Bài toán:** Phân tích phản hồi khách hàng để phát hiện các vấn đề cần ưu tiên xử lý.

**Ai đang đau?**  
Quản lý khách sạn, đội trải nghiệm khách hàng và đội vận hành.

**Workflow thủ công:**

1. Thu thập phản hồi.
2. Nhân viên đọc nội dung.
3. Phân loại chủ đề.
4. Xác định phản hồi nghiêm trọng.
5. Tổng hợp báo cáo.

**Bottleneck:**  
Đọc và tổng hợp một lượng lớn phản hồi bằng ngôn ngữ tự nhiên.

**AI có thể hỗ trợ:**  
Tóm tắt, gắn chủ đề và đánh dấu các phản hồi có tín hiệu cần được con người xem xét.

**Quick Architecture:** LLM Feature.

---

## QUICK PROBLEM CARD #3 — VinFast

**Bài toán:** Hỗ trợ tiếp nhận mô tả lỗi xe và chuẩn hóa thông tin cho đội kỹ thuật.

**Ai đang đau?**  
Nhân viên dịch vụ, kỹ thuật viên và khách hàng.

**Workflow thủ công:**

1. Khách hàng mô tả hiện tượng.
2. Nhân viên hỏi thêm thông tin.
3. Nhân viên ghi nhận triệu chứng.
4. Thông tin được chuyển đến bộ phận phù hợp.

**Bottleneck:**  
Diễn giải mô tả ngôn ngữ tự nhiên thành thông tin kỹ thuật có cấu trúc.

**AI có thể hỗ trợ:**  
Tóm tắt triệu chứng và đề xuất các câu hỏi làm rõ.

**Quick Architecture:** LLM Feature + Rule.

**Operational Boundary:**  
AI không được tự chẩn đoán hoặc đưa ra quyết định liên quan đến an toàn xe mà không có chuyên gia phê duyệt.

---

# QUYẾT ĐỊNH CHỌN BÀI TOÁN

## Vinhomes — AI hỗ trợ phân loại và định tuyến phản ánh cư dân

### Lý do lựa chọn

Bài toán có sự cân bằng tốt giữa:

- Giá trị vận hành.
- Khả năng áp dụng LLM cho tiếng Việt tự nhiên.
- Rủi ro có thể kiểm soát.
- Khả năng xây dựng prototype và stress-test.

Các bài toán có mức rủi ro cao hơn, đặc biệt liên quan đến y tế hoặc an toàn phương tiện, chưa phù hợp để làm prototype đầu tiên nếu chưa có dữ liệu và quy trình kiểm soát đầy đủ.
