# PHASE 1 — SCAN: TÌM KIẾM CƠ HỘI

## Bối cảnh

Bài tập áp dụng tư duy **Problem First, AI Second** để tìm kiếm các cơ hội ứng dụng AI trong hệ sinh thái Vingroup. Các ý tưởng dưới đây dựa trên bối cảnh hoạt động thực tế của các công ty thành viên; các số liệu vận hành cụ thể sẽ chỉ được xem là giả định scoping nếu chưa có dữ liệu nội bộ được công bố.

## Các cơ hội AI

| # | Công ty thành viên | Lens | Cơ hội |
|---|---|---|---|
| 1 | Vinhomes | Lặp lại | Nhân viên CSKH/Ban quản lý phải đọc và phân loại thủ công phản ánh cư dân như mất nước, hỏng đèn, tiếng ồn, vệ sinh và an ninh trước khi chuyển đến bộ phận xử lý. |
| 2 | VinFast | AI có thể hỗ trợ tốt hơn | Khách hàng mô tả lỗi xe bằng ngôn ngữ tự nhiên, nhưng thông tin không đồng nhất và cần được chuẩn hóa trước khi chuyển đến bộ phận kỹ thuật. |
| 3 | Vinpearl | Pain từ stakeholder | Quản lý cần đọc nhiều phản hồi khách hàng để phát hiện các vấn đề nghiêm trọng cần xử lý nhanh. |
| 4 | Xanh SM | Tốn thời gian | Các phản hồi sau chuyến đi cần được tổng hợp để tìm ra các nguyên nhân phổ biến ảnh hưởng đến trải nghiệm khách hàng. |
| 5 | Vinmec | Tốn thời gian | Nhân viên phải tổng hợp nhiều nguồn thông tin để hỗ trợ chuẩn bị tài liệu và tóm tắt thông tin; đây là bài toán có yêu cầu kiểm soát chuyên môn cao. |

## Nhận xét sau khi SCAN

Các bài toán được ưu tiên cần có:

1. Khối lượng xử lý ngôn ngữ hoặc thông tin lặp lại.
2. Workflow hiện tại tương đối rõ ràng.
3. AI hỗ trợ một bước cụ thể thay vì thay thế toàn bộ con người.
4. Rủi ro có thể kiểm soát bằng Human-in-the-loop (HITL).

Từ các cơ hội trên, bài toán tại **Vinhomes** được ưu tiên để đánh giá sâu hơn vì có workflow rõ ràng, dữ liệu đầu vào chủ yếu là ngôn ngữ tự nhiên và có thể giới hạn AI ở vai trò hỗ trợ phân loại.
