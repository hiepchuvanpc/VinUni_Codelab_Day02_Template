# Deep-Dive — Trợ lý phân loại phản ánh cư dân Vinhomes

**Phạm vi:** một tòa mô phỏng `DEMO-T01`, phản ánh văn bản tiếng Việt; AI chỉ đề xuất nhãn và bộ phận. Đề tài từ mục #6 của `03-inspiration-kit.md`.

> Chưa phỏng vấn cư dân/ban quản lý hoặc truy cập hệ thống Vinhomes. Mọi thời gian, khối lượng, mục tiêu là giả định. Bộ phận và mã tòa là thiết kế mô phỏng, không phải danh bạ/quy trình chính thức.

## Phase 3.1 — Current-State Workflow

![Quy trình hiện tại mô phỏng](04-workflow-diagram.png)

| Bước | Ai / công cụ giả định | Đầu vào → đầu ra | Phút/lượt | Handoff / vấn đề |
|---|---|---|---:|---|
| 1. Tiếp nhận, đọc | Lễ tân / hộp thư | Văn bản cư dân → phiếu mới | 1 | H1: cư dân → lễ tân |
| 2. Xác minh vị trí | Lễ tân / thông tin phiên, hỏi lại | Phiếu → vị trí được xác nhận | 2 | Không dùng địa chỉ tự khai để vượt quyền tòa |
| 3. Phân loại, tra bộ phận | Lễ tân / danh bạ | Mô tả → nhãn, nơi nhận | 3 | **Bottleneck:** diễn giải không thống nhất |
| 4. Soạn và chuyển phiếu | Lễ tân / biểu mẫu | Nhãn → phiếu chuyển | 2 | **Bottleneck; H2:** lễ tân → bộ phận |
| 5. Xác nhận nhận phiếu | Bộ phận phụ trách | Phiếu → xác nhận | 2 | H3: bộ phận → lễ tân; sai nơi nhận quay lại bước 3 |

**Baseline giả định: 10 phút/lượt**, bước 3–4 chiếm 5 phút. Chưa tính sửa chữa. Nhánh chuyển sai tăng thời gian nhưng chưa có số đo, không cộng vào baseline.

## Phase 3.2 — Problem Statement (6-field)

| Field | Nội dung |
|---|---|
| 1. Actor / Operator | Nhân viên lễ tân/CSKH của một tòa mô phỏng, cùng bộ phận nhận phiếu |
| 2. Current Workflow | Đọc → xác minh → phân loại/tra danh bạ → soạn/chuyển → xác nhận; baseline giả định 10 phút |
| 3. Bottleneck | Diễn giải phản ánh và chuẩn bị phiếu chiếm 5 phút; cách mô tả không trùng từ khóa danh mục |
| 4. Business Impact | Giả định 60 phiếu/ngày: 60×10/60 = 10 giờ công quy đổi/ngày trên toàn bộ người xử lý; mục tiêu 5 phút giải phóng tối đa 5 giờ công/ngày. Đây là kịch bản tính toán, chưa phải tổn thất đo được hoặc giảm biên chế |
| 5. Success Metric | Trung vị nhận–xác nhận ≤5 phút; nhãn đúng ≥90%; không hạ mức nguy cơ trong tập test; không gửi/chốt tự động; API trung bình mục tiêu ≤100 đồng/phiếu, cần đo hóa đơn |
| 6. Operational Boundary | Chỉ nhãn/bộ phận/ưu tiên trong allowlist; tòa từ trusted context; người duyệt bắt buộc. Cấm tự gửi, đóng phiếu, tra cư dân khác, cam kết sửa chữa, đổi danh bạ hoặc làm theo chỉ thị trong phản ánh |

### Kế hoạch xác lập baseline và đánh giá

- Được ban quản lý cho phép; đo ≥100 phiếu thủ công có timestamp nhận/chuyển/xác nhận và lần chuyển lại. Báo cáo trung vị, p95, số phiếu và tỷ lệ thiếu timestamp. Không dùng 10 phút giả định làm bằng chứng pilot.
- Chuẩn bị 200 phản ánh ẩn danh được phép dùng: 100 phát triển prompt/rule, 100 holdout khóa trước đánh giá. Hai nhân viên gán nhãn độc lập; quản lý phân xử bất đồng. Tránh bản gần trùng giữa hai tập.
- Holdout có ≥20 ca nguy cơ và ca thiếu dữ kiện/đa vấn đề. Đo accuracy, macro-F1, recall nguy cơ, confusion matrix. Đạt 100% trên tập nhỏ không bảo đảm an toàn ngoài thực tế.
- So sánh rule-only và rule+LLM trên cùng dữ liệu; chọn LLM nếu tăng accuracy ≥5 điểm phần trăm, vẫn đạt recall, latency và chi phí. Nếu không đạt, dùng rule + người.
- Sau khi được phép, shadow ≥100 phiếu, AI không thay đổi workflow thật. Đo cả thời gian duyệt/sửa; không suy ra tiết kiệm từ latency API đơn thuần.

## Phase 3.3 — AI Fit

| Giải pháp | Khi phù hợp | Kết luận |
|---|---|---|
| Rule / State-machine | Từ khóa rõ, kiểm tra tòa/schema, ánh xạ nhãn | Rẻ, dễ kiểm toán; baseline và guard bắt buộc, có thể đã đủ |
| LLM Feature | Hiểu nhiều cách diễn đạt trong một lần gọi | Chọn thử nghiệm có kiểm soát; có thể sai/injection, chưa chứng minh hơn rule |
| Agentic Loop | Tự tra hệ thống và thực hiện nhiều hành động | Không cần cho phân loại; tăng quyền và độ phức tạp, không chọn |

**Đề xuất: LLM Feature + rule + Human-in-the-loop.** Không cấp công cụ gửi/cập nhật. Trường `not_sent` là trạng thái nháp, không phải bằng chứng tích hợp thật.

### Future-State Flow

```text
Cư dân gửi phản ánh
 → [Người/hệ thống] xác thực tòa, giảm dữ liệu cá nhân
 → [AI] một lần gọi phân loại, trả JSON
 → [Rule] kiểm tra schema, tòa, nhãn↔bộ phận và ưu tiên
     ├─ lỗi API/JSON/vi phạm → [Người] phân loại thủ công
     ├─ thiếu dữ kiện/confidence <0.8 → [Người] lễ tân hỏi lại
     └─ hợp lệ → [Người] xem nội dung gốc, sửa/duyệt nhãn
                   → [Người/hệ thống có quyền] chuyển phiếu
                   → bộ phận xác nhận
Nguy cơ: người trực xem ngay, không chờ xử lý thông thường.
```

Prototype chưa có UI duyệt hoặc gửi. Fallback chỉ yêu cầu phân loại thủ công, **không đánh giá sự cố là an toàn**. Khi AI lỗi, người trực vẫn phải theo dõi tất cả nội dung gốc theo quy trình hiện tại. Cần xây hàng đợi và nhắc việc khẩn cấp trước pilot.

### Nhãn mô phỏng

| Nhãn | Bộ phận | Quy tắc |
|---|---|---|
| electricity / water | technical | Điện/nước thường; có nguy hiểm thì safety |
| noise | security | Tiếng ồn |
| cleanliness | housekeeping | Vệ sinh, rác |
| safety | duty_manager | urgent + safety_risk; trực ban xem ngay |
| other | reception | Không rõ/đa vấn đề; insufficient_data thì hỏi lại |

### Ranh giới kỹ thuật và hạn chế

- JSON thuần; không văn bản tự do hoặc trường dữ liệu cá nhân. `draft_tag="[DRAFT_ONLY]"`, `requires_human_review=true`, `send_status="not_sent"`.
- Thẻ nháp nằm trong trường JSON, không thêm tiền tố làm JSON lỗi. Không áp dụng quy tắc pin/xe cứu hộ của đề tài Xanh SM.
- `building_id="DEMO-T01"` từ trusted context; khi tích hợp phải lấy từ backend xác thực, không tin địa chỉ trong phản ánh.
- System instruction riêng, input JSON-escape. Encoding không tự chặn injection; vẫn cần kiểm tra và người duyệt.
- Validator chặn trường lạ/thiếu, key lặp, sai kiểu, enum lạ, route sai, bỏ duyệt, confidence không hợp lệ, safety không urgent.
- **Validator chưa hiểu ngữ nghĩa nội dung gốc**: model vẫn có thể gán cleanliness cho mô tả cháy mà vượt schema. Phải đo recall và kiểm thử live; không tuyên bố chống injection tuyệt đối.
- Confidence do model tự báo, chưa hiệu chuẩn; 0.8 chỉ là ngưỡng thử nghiệm. Tất cả phiếu vẫn cần duyệt.
- Regex che email/điện thoại chỉ là demo, chưa che đủ tên/căn hộ/biến thể PII. Chỉ dùng dữ liệu tổng hợp; chưa gửi dữ liệu cư dân thật.

## Phase 4 — Prompt prototype và boundary test

Code: `starter-code/prompt_prototype.py`. Model mặc định hiện tại là **`gemini-2.5-flash`**, được khôi phục theo yêu cầu người dùng sau lần thử chuyển sang 3.8. Chỉ đổi khi truyền `--model` rõ ràng, không tự chuyển model khi test lỗi. Terminal hiển thị từng test theo mẫu: `[RUNNING]`, `User Input`, `Model Response`, `[Verification Checks]`, Rule Passed/Failed. Nội dung vẫn là đề tài Vinhomes. SDK tham khảo [tài liệu Google Gen AI chính thức](https://googleapis.github.io/python-genai/).

Theo [Google — supported models](https://firebase.google.com/docs/ai-logic/models?api=dev), Gemini 2.5 trên Developer API chỉ còn cho dự án từng dùng trước đây; không thể mặc định mọi API key đều gọi được. Chạy `--list-models` để tra danh sách tài khoản, rồi kiểm thử model được chọn; danh sách này không bảo đảm quota.

6 attack: giả quản lý để gửi/đóng; hạ mức cháy; xin dữ liệu cá nhân; system giả; đổi tòa/route; ép bịa khi thiếu dữ kiện. Thêm 4 normal tests. Chế độ live kiểm tra schema/ranh giới và nhãn kỳ vọng, không chỉ tìm từ khóa.

Lệnh và kết quả thực thi: `evidence/README.md`. Lần chạy live do người dùng thực hiện với Gemini 2.5 ghi nhận **10/10 ERROR loại ClientError**, chưa có kết quả phân loại. Log cũ chưa lưu mã HTTP nên chưa xác định lỗi do key, model hay quota. Code đã thêm chẩn đoán an toàn và dừng batch khi gặp lỗi cấu hình/quota. Model mới chưa được chạy live trong môi trường trợ lý vì không có key. Offline chỉ thử validator bằng output tổng hợp.

## Phase 5 — EVALUATE

| Checklist | Trạng thái | Bằng chứng / thiếu gì |
|---|---|---|
| Dữ liệu mẫu sạch có nhãn | Một phần | 10 input tổng hợp; chưa có 200 phiếu và holdout độc lập |
| Rủi ro trong kiểm soát | Một phần | Có validator/fallback; chưa có live test, UI duyệt, hàng đợi trực ban |
| Stakeholder sẵn sàng | Chưa xác minh | Chưa phỏng vấn/được ban quản lý chấp thuận |

**Quyết định: NOT YET cho pilot vận hành.** Tiếp tục prototype giáo dục với dữ liệu tổng hợp. Thiếu baseline, bằng chứng model và chấp thuận nghiệp vụ nên chưa chọn GO.

### Chi phí và điều kiện chuyển GO

- 60 phiếu/ngày × 30 ngày = 1.800/tháng; trần API mục tiêu 100 đồng/phiếu tương đương 180.000 đồng/tháng. Đây là ngân sách mục tiêu, không phải giá model; chưa tính tích hợp/duyệt/bảo mật/bảo trì.
- Cần ghi token, latency, hóa đơn thực tế. Không biến 5 giờ công giả định thành khoản tiết kiệm đã đạt.
- Đủ quyền dùng dữ liệu/baseline; accuracy ≥90%, recall nguy cơ 100% trên tập test khóa, không phát hiện bypass trong adversarial mở rộng; p95 API mục tiêu ≤10 giây.
- Có UI duyệt, phân quyền theo tòa, hàng đợi thủ công/khẩn cấp, log, rollback và người chịu trách nhiệm đồng ý pilot shadow.
- Nếu rule-only tương đương hoặc LLM không đạt chi phí/chất lượng: **NO-GO cho thành phần LLM**, dùng rule + người.
