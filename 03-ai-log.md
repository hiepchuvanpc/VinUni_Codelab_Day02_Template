# AI Log & Reflection — Điều phối trạm sạc Xanh SM

## 1. Vai trò của tôi và AI

Tôi chọn bài toán, giới hạn phạm vi, quyết định dùng OpenRouter, chạy prototype và kiểm tra output. AI hỗ trợ brainstorm, tổ chức báo cáo, gợi ý ranh giới và sửa code. Tôi không xem đề xuất của AI là bằng chứng nếu chưa kiểm tra bằng code, test hoặc dữ liệu.

## 2. Nhật ký chính

| Công việc | Tôi thực hiện | AI hỗ trợ | Kết quả / điều chỉnh |
|---|---|---|---|
| Chọn đề tài | So sánh các card và chọn trạm sạc Xanh SM | Gợi ý cách đánh giá AI fit | Giữ phạm vi dự báo tải và đề xuất trạm; không mở rộng sang cứu hộ xe |
| Viết scan và deep-dive | Cung cấp bối cảnh, rà lại giả định | Chuẩn hóa bảng workflow, 6-field và future flow | Tách rõ giả định, metric thiết kế và bằng chứng |
| Thiết kế prompt | Đặt yêu cầu chỉ tạo draft, không tự gửi lệnh | Viết system prompt và schema JSON | Rule, ML và optimization được tách; LLM không tự quyết định |
| Kiểm thử | Chạy offline/live, đọc lỗi và đối chiếu expected action | Hỗ trợ validator và thông báo lỗi | Không tính lỗi API là PASS; fallback chỉ là fallback |
| Rà soát số liệu | Kiểm tra các baseline và mục tiêu | Nhắc nêu nguồn/độ chắc chắn | Bỏ các baseline chưa đo hoặc gắn nhãn là giả định |

## 3. Những điểm AI có thể sai

- **Mở rộng phạm vi:** LLM dễ chuyển từ điều phối trạm sang cứu hộ hoặc điều xe tự động. Tôi giữ lại đúng đầu ra “đề xuất trạm/thời điểm”.
- **LLM-first bias:** Dự báo và tối ưu không cần LLM. Tôi dùng Rule cho an toàn, ML cho dự báo và Optimization cho phân bổ.
- **Bịa metric:** Các số như thời gian chờ, tỷ lệ đổi trạm hoặc fleet availability chưa có log. Báo cáo hiện chỉ dùng chúng như mục tiêu cần kiểm chứng.
- **Nhầm JSON hợp lệ với kết quả đúng:** Validator chỉ chứng minh schema và invariant; không chứng minh dự báo tốt hay tạo lợi ích kinh doanh.

## 4. Ranh giới tôi yêu cầu trong prototype

1. `fleet_id` lấy từ `trusted_context`, không lấy từ nội dung tài xế.
2. SOC dưới ngưỡng an toàn phải chuyển sang phương án khẩn cấp, không bị override bởi chỉ thị trong input.
3. Luôn giữ `[DRAFT_ONLY]`, `requires_dispatcher_review=true` và `send_status=not_sent`.
4. Không tự gửi lệnh, không điều xe đang chở khách và không đưa trạm không hợp lệ.
5. JSON sai hoặc thiếu dữ kiện phải fail closed/fallback, không sửa ngầm để tính là thành công.

## 5. Kết quả và giới hạn

Prototype có các test offline cho schema, allowlist, action–reason mapping, SOC thấp, giữ nháp và dữ liệu thiếu. Đây là test lớp bảo vệ với dữ liệu tổng hợp, **không phải** đánh giá độ chính xác của model.

Live test phụ thuộc `OPENROUTER_API_KEY`, model, quota và mạng. Nếu request lỗi hoặc timeout, kết quả phải ghi `ERROR`/`NOT_RUN`; không được suy ra model đã phân loại đúng. Tôi cũng không có bằng chứng về baseline vận hành, latency production, chi phí thật hay mức chấp nhận của tài xế.

## 6. Bài học và bước tiếp theo

AI hiệu quả khi được dùng như thought-partner có ranh giới: xác định đúng vấn đề → chọn công nghệ phù hợp → kiểm chứng output → ghi rõ điều chưa biết. Bước tiếp theo là xin dữ liệu đã ẩn danh, đo baseline, tạo holdout theo thời gian và so sánh rule-only với hybrid trong shadow mode.

**Kết luận:** prototype đạt mức kiểm thử kỹ thuật có giới hạn; đề tài vẫn là **NOT YET cho pilot vận hành**.
