# Bằng chứng kiểm thử và hướng dẫn hoàn tất bài

## Đề tài và file

Chọn **Phân loại & điều hướng phản ánh cư dân Vinhomes**, gợi ý #6 trong `03-inspiration-kit.md`. Viết bộ bài riêng, không dùng lời giải điều phối Xanh SM.

| File | Nội dung |
|---|---|
| `01-problem-scan.md` | 5 bài toán, đủ 4 lenses, 3 cards, lựa chọn và phản biện |
| `02-deep-dive-report.md` | Workflow, 6-field, AI Fit, future flow, ranh giới, metric, quyết định NOT YET |
| `03-ai-log.md` | Nhật ký AI phản ánh đúng cuộc trò chuyện và hạn chế |
| `04-workflow-diagram.png` | Current-state, handoff, thời gian và bottleneck |
| `starter-code/prompt_prototype.py` | Prototype Gemini; 6 adversarial + 4 normal tests; validator và fallback |

## Kết quả thực tế trong workspace

Lần chạy mới nhất với `gemini-3.8-flash`: A1–A4 lỗi HTTP 504 sau khoảng 29 giây/ca; A5 lỗi 429; A6 và N1–N4 chưa chạy. Chưa có đầu ra model để đánh giá nhãn. Timeout gọi generate_content đã tăng từ 30 lên 120 giây, bổ sung gợi ý riêng cho 504. Chưa kiểm chứng live sau thay đổi; tăng timeout không khắc phục quota 429. Mặc định vẫn giữ 2.5 theo yêu cầu; 3.8 là model người dùng truyền bằng `--model`.

| Kiểm tra | Kết quả | Giới hạn |
|---|---|---|
| Offline guard tests | **21/21 PASS** | Output tổng hợp; không gọi model |
| SDK/config/schema | Khởi tạo `GenerateContentConfig` thành công trong `.venv` | Chưa chứng minh server chấp nhận hoặc model khả dụng |
| Live ban đầu trong môi trường trợ lý | **NOT RUN**, exit code 2: thiếu API key | Không tạo log live giả |
| Live sau đó do người dùng chạy với 2.5 | **10/10 ERROR**, loại `ClientError` | Log cũ không có mã HTTP; chưa đủ kết luận model/key/quota |
| Kiểm thử chẩn đoán API và định dạng terminal | 6 regression tests đạt, có subtests cho 400/401/403/404/429 | Giả lập lỗi/output, không gọi API thật; kiểm tra đúng bố cục và không báo Passed khi output vi phạm |
| Autograder `--check-file-1` đến `--check-file-4` | PASS | Chỉ kiểm tra tồn tại các deliverable |
| Autograder `--check-code-2`, `--check-code-3` | PASS | Có SDK call và các test hợp lệ |
| Autograder `--check-code-1` | FAIL | Bộ chấm yêu cầu ≥2 trong 3 từ khóa `draft_only`, `5%`, `dispatch_mobile_charger`; hai từ sau thuộc đề tài xe điện, không áp dụng Vinhomes |

Không sửa bộ chấm hoặc nhét từ khóa không liên quan để làm đẹp kết quả. Khi nộp đề tài khác mẫu, cần giảng viên xác nhận cách đánh giá các ranh giới theo đề tài. Các check chạy live của autograder cũng chưa thể đạt khi chưa có key; không xem test offline là kết quả model thật.

`offline-results.json` là log máy đọc được. Log live 2.5 lỗi được giữ bản sao `live-results-gemini-2.5-flash-errors.json` để không mất bằng chứng khi chạy lại. Sơ đồ đã được mở kiểm tra: đủ 5 bước, H1–H3, thời gian và 2 bottleneck; thời gian trong ảnh khớp báo cáo.

## Chạy lại trên Windows PowerShell

Tại thư mục gốc, dùng Python trong `.venv` trực tiếp để không cần activate:

```powershell
.\.venv\Scripts\python.exe starter-code/prompt_prototype.py --offline
```

Để gọi API thật, cấu hình key **trong terminal của bạn**, không dán key vào chat hoặc code:

```powershell
$env:GEMINI_API_KEY="KEY_CUA_BAN"
.\.venv\Scripts\python.exe starter-code/prompt_prototype.py --list-models
.\.venv\Scripts\python.exe starter-code/prompt_prototype.py
```

Nếu chưa có môi trường:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

Mặc định đã được khôi phục thành `gemini-2.5-flash` theo yêu cầu người dùng; biến môi trường `GEMINI_MODEL` không đổi mặc định này. Chỉ đổi nếu truyền `--model MODEL_ID` rõ ràng. Theo [Google](https://firebase.google.com/docs/ai-logic/models?api=dev), 2.5 trên Developer API bị giới hạn cho dự án từng dùng trước đó; không thể kết luận mọi endpoint 2.5 đã ngừng. Không có tự động fallback sang model khác.

Output terminal hiện theo ảnh mẫu: banner model, `[RUNNING] Test Case ...`, `User Input`, `Model Response`, `[Verification Checks]`, `Rule 1 Passed/Failed` (schema/ranh giới), `Rule 2 Passed/Failed` (nhãn kỳ vọng). Model Response lấy từ API, không dựng câu trả lời thành công. Có lỗi API thì hiển thị lỗi, không in kết quả Passed giả. Nội dung kiểm thử vẫn là Vinhomes.

Key đã xuất hiện trong ảnh trao đổi cần được thu hồi và tạo lại trong Google AI Studio. Không dùng lại key bị lộ, không ghi key vào file bài nộp.

Code mới in mã HTTP cùng gợi ý cố định, không in key/request/raw exception. 400 có thể là key/request/schema; 401/403 là xác thực/quyền; 404 có thể là tên model/quyền truy cập; 429 là quota/rate limit. Gặp các lỗi này sẽ dừng batch, các ca còn lại mang trạng thái `NOT_RUN`.

Sau khi live chạy, đọc `evidence/live-results.json`:

- `PASS`: JSON qua validator và nhãn khớp expected của ca đó; chưa đủ bằng chứng an toàn ngoài tập test.
- `FAIL_BOUNDARY`: output bị chặn, fallback thủ công; đây vẫn là model thất bại.
- `FAIL_CLASSIFICATION`: JSON hợp lệ nhưng nhãn sai; không nên chỉ nhìn schema để đánh giá.
- `ERROR`: lỗi gọi API; xem cấu hình tại máy, không gửi key/log chứa bí mật.
- `NOT_RUN`: ca chưa chạy vì batch dừng sau lỗi cấu hình/quota; không tính là PASS hoặc model sai nhãn.

Nếu bất kỳ ca nào không đạt thì exit code 1; không che lỗi. Sau khi chạy thực, cập nhật deep-dive và AI log bằng kết quả thật, bao gồm cả lỗi và việc sửa prompt. Log chỉ lưu đầu ra đã kiểm tra hoặc loại lỗi, tránh lưu output vi phạm có thể chứa dữ liệu riêng tư.

## Việc cần làm trước khi nộp

1. Đọc và hiểu bài, kiểm tra các giả định; bổ sung tên/nhóm nếu giảng viên yêu cầu. Không trình bày bản nháp AI log như trải nghiệm cá nhân chưa có.
2. Chạy lại live bằng key mới và model truy cập được, bổ sung kết quả. Lần chạy 10 ClientError chưa hoàn tất kiểm thử khả năng phân loại.
3. Làm rõ với giảng viên phần autograder đang cố định từ khóa của đề tài Xanh SM; giữ nguyên bài riêng theo yêu cầu.
4. Commit/push bài cá nhân trên branch `NguyenDacThe`. Không đưa `.venv`, API key hay `.env` vào Git.
5. Trưởng nhóm review và tổng hợp 3 MD + sơ đồ lên `main`; **không merge code `.py` cá nhân vào main**. Chỉ trưởng nhóm điền form theo README.

Không có commit/push hoặc thao tác form nào được thực hiện tự động trong phiên này.

## Tái tạo sơ đồ

`render-workflow.ps1` dùng System.Drawing trên Windows. Chỉ khi cần chỉnh sơ đồ, chạy:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\evidence\render-workflow.ps1
```

Nguồn API tham khảo: [Google Gen AI SDK chính thức](https://googleapis.github.io/python-genai/). Giả định nghiệp vụ lấy từ yêu cầu lab và thiết kế của bài, không phải dữ liệu được xác minh từ tài liệu SDK.
