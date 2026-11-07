# Problem Scan — Cơ hội AI trong vận hành

**Bối cảnh:** mô phỏng vai trò AI Product Engineer tại Vin Smart Future.
**Phạm vi cá nhân:** các bài toán dưới đây là giả thuyết scoping, chưa phải khảo sát nội bộ của doanh nghiệp. Thời gian, sản lượng và mục tiêu đều cần đo lại trước pilot.

## Phase 1 — Scan

| # | Công ty | Lens | Bài toán | Người chịu ảnh hưởng |
|---|---|---|---|---|
| 1 | Xanh SM/VinFast | Stakeholder Pain | Dự báo tải trạm và đề xuất trạm sạc phù hợp để giảm thời gian xe phải chờ vào giờ cao điểm | Tài xế, điều phối, khách hàng |
| 2 | Vinhomes | Repetitive | Phân loại phản ánh cư dân và gợi ý bộ phận tiếp nhận | Lễ tân, cư dân, kỹ thuật |
| 3 | Xanh SM | AI-upgrade | Dự báo thời gian đón, phát hiện GPS lệch và hỗ trợ điều phối lại cuốc bị hủy | Tài xế, điều phối, khách hàng |
| 4 | VinFast | Repetitive | Phân loại yêu cầu bảo hành từ mô tả lỗi và tra cứu lịch sử sửa chữa | CSKH, kỹ thuật, chủ xe |
| 5 | Vinmec | Time-consuming | Dự báo nhu cầu khám để hỗ trợ xếp lịch và phân bổ tài nguyên | Bệnh nhân, lễ tân, bác sĩ |

## Phase 2 — Quick Problem Cards

### Card 1 — Dự báo và điều phối trạm sạc Xanh SM

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Dự báo nhu cầu và hàng chờ tại các trạm sạc, sau đó đề xuất trạm/thời điểm sạc phù hợp cho xe không có khách. |
| Actor | Tài xế GSM; điều phối đội xe; đơn vị vận hành trạm; khách hàng chờ xe. |
| Workflow hiện tại | 1. Kiểm tra SOC → 2. Tìm trạm trên app → 3. Di chuyển → 4. Chờ hoặc đổi trạm khi quá tải → 5. Sạc xong và quay lại khai thác. |
| Bottleneck | Bước 2–4: trạng thái trạm không cho biết hàng chờ tương lai; tài xế có thể chọn trạm gần nhưng đang quá tải. |
| AI hỗ trợ | Rule kiểm tra SOC và tương thích; ML dự báo tải/hàng chờ; optimization xếp hạng trạm. |
| Metric thiết kế | Thời gian chờ, tỷ lệ đổi trạm, MAPE dự báo tải, fleet availability. Chưa có baseline thực tế. |
| Ranh giới | Chỉ đề xuất; không điều xe đang chở khách, không vượt ngưỡng SOC an toàn, không tự gửi lệnh. |
| Kiến trúc | Rule + Predictive ML + Optimization; không cần agent tự trị. |
| PoC | Đo baseline trước, sau đó shadow tại một nhóm trạm trong 4–6 tuần; so sánh quy trình hiện tại, rule-only và hybrid. |

### Card 2 — Phân loại phản ánh cư dân Vinhomes

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Gợi ý nhãn, mức ưu tiên và bộ phận tiếp nhận từ phản ánh văn bản tiếng Việt. |
| Bottleneck | Cách diễn đạt tự do khiến lễ tân tra danh mục và chuyển phiếu không nhất quán. |
| AI hỗ trợ | LLM trích xuất ý; rule kiểm tra nhãn, tòa và mức nguy cơ; người duyệt trước khi chuyển. |
| Metric thiết kế | Thời gian nhận–xác nhận và chất lượng nhãn trên holdout được gán nhãn. |
| Ranh giới | Không truy xuất dữ liệu cư dân khác, không tự gửi/đóng phiếu, không hạ mức nguy hiểm. |

### Card 3 — Phân loại yêu cầu bảo hành VinFast

| Trường | Nội dung |
|---|---|
| Bài toán một câu | Chuẩn hóa mô tả lỗi của khách thành nhóm yêu cầu để kỹ thuật viên tiếp nhận nhanh hơn. |
| Bottleneck | Mô tả tiếng Việt không đồng nhất và cần hỏi lại nhiều lần. |
| AI hỗ trợ | LLM gợi ý nhóm lỗi; rule kiểm tra trường bắt buộc; kỹ sư xác nhận. |
| Metric thiết kế | Tỷ lệ trường bắt buộc đúng, thời gian tiếp nhận và tỷ lệ phải phân loại lại. |
| Ranh giới | Không chẩn đoán an toàn, không cam kết bảo hành, không thay thế kỹ sư. |

## Lựa chọn deep-dive

Chọn **Card 1 — Xanh SM** vì đầu ra có thể giới hạn thành đề xuất có cấu trúc, các ràng buộc an toàn có thể kiểm tra bằng rule, và có thể đánh giá offline mà không tích hợp hệ thống thật.

| Bài toán chưa chọn | Lý do | Điều kiện xem xét lại |
|---|---|---|
| Vinhomes | Cần dữ liệu phản ánh đã ẩn danh và danh mục chính thức | Có holdout và quy trình duyệt được xác nhận |
| VinFast | Sai phân loại có thể ảnh hưởng xử lý kỹ thuật/an toàn | Có bộ mã lỗi và kỹ sư gán nhãn |

## Kết luận Phase 1–2

- Đã sử dụng đủ 4 lenses và hoàn thiện 3 cards có actor, workflow, bottleneck, metric và ranh giới.
- Các số mục tiêu trong card là **metric thiết kế**, không phải kết quả đo.
- Prototype và test ranh giới không chứng minh lợi ích kinh doanh hoặc readiness của pilot.
- Card 1 được chuyển sang [Deep-Dive Report](02-deep-dive-report.md).
