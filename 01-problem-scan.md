# Problem Scan — Cơ hội AI trong vận hành dịch vụ

**Bài cá nhân trên branch:** `NguyenDacThe`. **Bối cảnh:** mô phỏng vai trò AI Product Engineer tại Vin Smart Future.

Nguồn ý tưởng: `03-inspiration-kit.md`, các mục #3, #6, #7, #8, #9. Các mô tả là giả thuyết nghiệp vụ, chưa phải kết quả khảo sát doanh nghiệp. Toàn bộ thời gian, sản lượng và mục tiêu là **giả định phục vụ lab**, cần đo lại trước pilot. Các thời gian trong card là thời lượng quy trình, có thể gồm chờ bàn giao; chưa đủ để tính chi phí nhân công tiết kiệm.

## Phase 1 — SCAN: 5 bài toán, đủ 4 lenses

| # | Công ty | Lens | Bài toán cụ thể | Người gặp khó khăn |
|---|---|---|---|---|
| 1 | Vinhomes | Lặp lại | Lễ tân đọc phản ánh, xác định nhóm sự cố và chuyển bộ phận; dễ chuyển sai khi mô tả khác danh mục chuẩn | Lễ tân, cư dân, kỹ thuật |
| 2 | Vinpearl | Pain từ người khác | Quản lý phải đọc nhiều review để tìm phàn nàn cần can thiệp, dễ bỏ sót vấn đề lặp lại | Khách lưu trú, quản lý |
| 3 | Vinpearl | Tốn thời gian | Nhân viên chép ngày, số phòng, yêu cầu từ email đoàn vào biểu mẫu; thiếu trường cần hỏi lại | Reservation, đối tác lữ hành |
| 4 | Vinhomes | AI có thể tốt hơn | Cư dân hỏi thủ tục gửi xe/thi công bằng nhiều cách; cần nháp hướng dẫn từ chính sách được duyệt | Cư dân, bộ phận dịch vụ |
| 5 | VinFast | Lặp lại | Tài chính so khớp hóa đơn sạc với giao dịch, tách sai lệch cần đối soát | Kế toán, đối tác |

## Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards

### Card 1 — Phân loại và điều hướng phản ánh cư dân Vinhomes

**Tham chiếu SCAN #1 — Vinhomes; gợi ý #6 trong inspiration kit.**

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Giảm thời gian phân loại phản ánh và chuẩn bị chuyển đúng bộ phận, có người duyệt |
| Actor | Lễ tân/CSKH của một tòa; cư dân chịu thời gian chờ |
| Workflow | 1. Đọc (1 phút) → 2. Xác minh vị trí (2 phút) → 3. Phân loại/tra danh bạ (3 phút) → 4. Soạn và chuyển phiếu (2 phút) → 5. Bộ phận xác nhận (2 phút) |
| Bottleneck | Bước 3–4: 5/10 phút; diễn giải tiếng Việt tự do và tra nơi nhận |
| AI hỗ trợ | Gợi ý nhãn; rule ánh xạ nhãn sang bộ phận; lễ tân duyệt |
| Metric | Trung vị nhận–xác nhận ≤5 phút, baseline giả định 10 phút; nhãn đúng ≥90% trên holdout |
| Quick Architecture | LLM Feature + rule kiểm tra schema/route; không agent tự trị |
| Rủi ro/điều kiện | Có danh mục và danh bạ; không gửi tự động/lộ dữ liệu; nguy cơ khẩn cấp phải đưa người trực xem |

### Card 2 — Tổng hợp review khách sạn Vinpearl

**Tham chiếu SCAN #2 — Vinpearl; gợi ý #8 trong inspiration kit.**

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Rút ngắn việc đọc review và tổng hợp vấn đề cho quản lý xem xét |
| Actor | Quản lý trải nghiệm khách hàng |
| Workflow | 1. Thu review được phép dùng (10 phút) → 2. Đọc/gắn nhãn (25 phút) → 3. Gộp chủ đề (15 phút) → 4. Soạn báo cáo/kiểm tra (10 phút) |
| Bottleneck | Bước 2–3: 40/60 phút cho một lô giả định 50 review |
| AI hỗ trợ | Gợi ý chủ đề, tóm tắt kèm ID review nguồn, quản lý kiểm chứng |
| Metric | Thời gian/lô 60 → ≤25 phút; ≥95% nhận định truy được review hỗ trợ |
| Quick Architecture | LLM Feature; rule lọc trùng/kiểm tra ID nguồn |
| Rủi ro/điều kiện | Quyền dùng review, bộ gán nhãn; không xem lời phàn nàn là sự kiện đã xác thực; không tự đăng phản hồi |

### Card 3 — Trích xuất email đặt phòng đoàn Vinpearl

**Tham chiếu SCAN #3 — Vinpearl; gợi ý #9 trong inspiration kit.**

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Trích xuất email thành phiếu đặt phòng nháp để nhân viên kiểm tra |
| Actor | Nhân viên reservation |
| Workflow | 1. Đọc (3 phút) → 2. Chép ngày/số phòng/yêu cầu (4 phút) → 3. Đối chiếu trường và quỹ phòng (3 phút) → 4. Viết thư hỏi lại/xác nhận nháp (2 phút) |
| Bottleneck | Bước 1–2: 7/12 phút, email nhiều định dạng và chuỗi sửa yêu cầu |
| AI hỗ trợ | Trích xuất trường, báo trường thiếu; rule kiểm tra ngày; nhân viên xem tồn phòng |
| Metric | Chuẩn bị phiếu 12 → ≤6 phút; trường ngày và số phòng đúng ≥98% trên holdout |
| Quick Architecture | LLM Feature + kiểm tra kiểu/ngày; không agent tự đặt phòng |
| Rủi ro/điều kiện | Email được phép dùng; không tự giữ phòng, báo giá hay cam kết tồn kho |

## Lựa chọn để deep-dive

Chọn **Card 1 — Vinhomes**, vì đầu ra nhỏ, nhãn hữu hạn, dễ tạo test tổng hợp mà không tích hợp hệ thống thật. Giá trị kỳ vọng là giảm công phân loại/sửa phiếu; không tuyên bố rút ngắn việc sửa chữa thực địa.

| Card chưa chọn | Lý do | Điều kiện xem xét lại |
|---|---|---|
| Review Vinpearl | Cần kiểm chứng nguồn và quyền dùng; tóm tắt sai khó đánh giá chỉ bằng schema | Review gắn nhãn, quy tắc dẫn chứng |
| Email đặt phòng | Sai ngày/số phòng ảnh hưởng đặt chỗ; cần kiểm tra quỹ phòng | Email ẩn danh, schema và sandbox tồn kho |

### Phản biện và điều chỉnh

1. **Vì sao không rule-only?** Rule từ khóa là baseline bắt buộc. Chỉ dùng LLM nếu cải thiện cách diễn đạt tự do; hiện chưa có bằng chứng tốt hơn.
2. **Metric có đo sai?** Đo thời gian tiếp nhận–xác nhận và nhãn đúng, không lấy thời gian sửa chữa làm metric bộ phân loại.
3. **Giá trị có bị phóng đại?** Thời gian giải phóng phải trừ công duyệt/ngoại lệ/chi phí, không mặc định tương đương tiền tiết kiệm.

## Kết quả chuyển sang Deep-Dive

Đã quét 5 bài toán với đủ **4 lenses**, hoàn thiện 3 cards có actor, workflow, bottleneck, vị trí AI, metric và kiến trúc. Rubric I1 nhắc 3 lenses, nhưng hướng dẫn Phase 1 liệt kê 4; bài sử dụng cả 4 để đáp ứng yêu cầu chi tiết hơn.

Card 1 được đưa sang [báo cáo Deep-Dive](02-deep-dive-report.md). Phần lựa chọn này là đề xuất cá nhân để nhóm review, chưa khẳng định đã tổ chức họp hay được doanh nghiệp chấp thuận. Quyết định cuối cùng sau thử nghiệm là **NOT YET cho pilot vận hành**; việc có prototype và một số test đạt chưa chứng minh lợi ích kinh doanh thực tế.
