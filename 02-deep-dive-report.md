# 02 – Deep-Dive Report: Trợ lý tóm tắt hồ sơ bệnh án (EMR) cho hội chẩn đa chuyên khoa – Vinmec

> Bài toán được chọn: **Quick Problem Card #1 (Vinmec – Tóm tắt & trích xuất EMR)**.
> Lưu ý: các số liệu là **ước tính ban đầu (giả định)**, cần kiểm chứng bằng đo đạc thực tế (time study) trong giai đoạn pilot.

---

## PHASE 3 – DEEP-DIVE

### 3.1 Problem Statement (6 trường)

| # | Trường | Nội dung |
|---|---|---|
| 1 | **Actor (Ai đau?)** | Bác sĩ điều trị, bác sĩ tham gia hội chẩn, thư ký y khoa tại Vinmec Times City (và các cơ sở khác trong hệ thống). |
| 2 | **Bài toán (Problem)** | Mỗi ca bệnh, người dùng phải mở nhiều tab/file EMR (lâm sàng, xét nghiệm, chẩn đoán hình ảnh, ghi chú điều dưỡng), đọc, tổng hợp và gõ lại thành phiếu tóm tắt/báo cáo hội chẩn. Việc này thủ công, lặp lại và dễ sót thông tin. |
| 3 | **Hiện trạng (Current workflow)** | (1) Mở từng tab EMR → (2) tự tổng hợp, gõ lại → (3) đối chiếu chéo các nguồn → (4) copy/paste vào mẫu báo cáo → (5) kiểm tra lại thủ công trước khi trình hội đồng. |
| 4 | **Tác động (Impact)** | ~5 phút/lần tóm tắt hồ sơ cơ bản; ~60 phút cho một ca hội chẩn khó. Với giả định 40 lần tóm tắt cơ bản/bác sĩ/tuần và 8 ca hội chẩn khó/khoa/tuần, thời gian chuyên môn quý giá bị chiếm bởi việc hành chính thay vì thăm khám và ra quyết định. Rủi ro sót thông tin quan trọng (dị ứng, tiền sử, kết quả bất thường) do copy/paste. |
| 5 | **Ràng buộc (Constraints)** | Dữ liệu y tế nhạy cảm (tuân thủ Nghị định 13/2023/NĐ-CP về bảo vệ dữ liệu cá nhân và quy định bảo mật bệnh án); AI không được đưa ra chẩn đoán/quyết định điều trị; bắt buộc có bác sĩ duyệt; dữ liệu phải ở trong hạ tầng được phê duyệt (on-prem/private cloud); cần tích hợp với EMR hiện có. |
| 6 | **Thước đo thành công (Metric)** | Thời gian tóm tắt hồ sơ cơ bản: 5 phút → < 1 phút. Thời gian tổng hợp báo cáo hội chẩn: 60 phút → < 10 phút. Thời gian tìm thông tin bệnh nhân: 3 phút → < 10 giây. Chất lượng: ≥ 95% trường dữ liệu trọng yếu trích xuất đúng; 0 trường hợp "bịa" (hallucination) lọt qua bước duyệt. |

### 3.2 Future-State Flow (quy trình tương lai có AI)

```
[Bác sĩ chọn ca bệnh / mở yêu cầu hội chẩn]
        │
        ▼
(1) RULE – Truy xuất & kiểm tra quyền
    • Kiểm tra quyền truy cập theo vai trò (RBAC) và mã bệnh nhân
    • Gom dữ liệu EMR có cấu trúc: sinh hiệu, xét nghiệm, đơn thuốc, dị ứng, chẩn đoán cũ
    • Rule chuẩn hóa đơn vị, ngày giờ; gắn cờ giá trị bất thường theo ngưỡng tham chiếu
        │
        ▼
(2) LLM – Trích xuất & tóm tắt có cấu trúc
    • Đọc ghi chú tự do (lâm sàng, điều dưỡng, báo cáo hình ảnh)
    • Xuất ra JSON theo schema cố định: lý do khám, tiền sử, diễn biến, xét nghiệm chính, vấn đề cần hội chẩn
    • Mỗi mục kèm trích dẫn nguồn (liên kết về đúng tab/dòng EMR gốc)
        │
        ▼
(3) AGENTIC LOOP (có giới hạn) – Soạn báo cáo hội chẩn nháp
    • Lặp: lập dàn ý theo mẫu khoa → điền từng mục → tự kiểm tra
      (đối chiếu số liệu trong bản nháp với dữ liệu gốc; kiểm tra mục thiếu)
    • Nếu phát hiện mâu thuẫn/thiếu dữ liệu → truy xuất thêm, hoặc đánh dấu "Cần xác nhận"
    • Giới hạn tối đa 3 vòng lặp; không có quyền ghi vào EMR
        │
        ▼
(4) HUMAN-IN-THE-LOOP – Bác sĩ/thư ký duyệt
    • Giao diện hiển thị bản nháp cạnh nguồn gốc, các mục "Cần xác nhận" nổi bật
    • Bác sĩ sửa, chấp nhận hoặc từ chối từng mục
    • Chỉ sau khi bác sĩ ký duyệt, bản tóm tắt mới được lưu/gửi hội đồng
        │
        ▼
(5) Ghi log & phản hồi
    • Lưu audit log (ai xem, AI tạo gì, ai sửa gì)
    • Thu thập chỉnh sửa của bác sĩ để cải thiện prompt/đánh giá
```

### 3.3 AI Fit – Phân vai Rule / LLM / Agentic Loop

| Thành phần | Công nghệ | Lý do chọn | Không dùng cho |
|---|---|---|---|
| Truy xuất dữ liệu, phân quyền, chuẩn hóa đơn vị, gắn cờ bất thường | **Rule** | Cần xác định (deterministic), kiểm toán được, không được sai | Diễn giải ghi chú văn bản tự do |
| Trích xuất & tóm tắt ghi chú tự do thành schema | **LLM** | Văn bản y khoa không cấu trúc, nhiều cách viết | Đưa ra chẩn đoán, khuyến nghị điều trị |
| Soạn báo cáo hội chẩn nhiều mục, tự kiểm tra, tìm thêm dữ liệu | **Agentic loop (giới hạn)** | Nhiều bước phụ thuộc nhau, cần tự đối chiếu | Hành động có tác dụng phụ (ghi EMR, kê đơn) |

### 3.4 Human-in-the-Loop

- **Bắt buộc duyệt:** không có bản tóm tắt nào vào hồ sơ chính thức hay tới hội đồng khi chưa có chữ ký/xác nhận của bác sĩ.
- **Minh bạch:** mỗi câu/số liệu đều có link về nguồn EMR; mục AI không chắc chắn được tô nổi bật "Cần xác nhận".
- **Phạm vi:** AI chỉ tóm tắt và trích xuất; **không** chẩn đoán, **không** gợi ý thuốc/điều trị.
- **Trách nhiệm:** bác sĩ ký duyệt chịu trách nhiệm chuyên môn; hệ thống lưu vết ai sửa gì.

### 3.5 Fallback (khi AI lỗi hoặc không đủ tin cậy)

| Tình huống | Hành vi fallback |
|---|---|
| LLM/dịch vụ AI không phản hồi hoặc quá thời gian | Hiển thị thông báo, chuyển về quy trình thủ công hiện tại; vẫn cung cấp phần dữ liệu có cấu trúc do Rule gom (không cần LLM) |
| Độ tin cậy trích xuất thấp / mâu thuẫn dữ liệu | Đánh dấu "Cần xác nhận", hiển thị nguyên văn nguồn thay vì tóm tắt |
| Thiếu dữ liệu trọng yếu (VD: chưa có dị ứng) | Không tự suy diễn; ghi rõ "Không có dữ liệu" |
| Phát hiện bất thường (giá trị ngoài ngưỡng, nghi bịa) | Chặn xuất bản nháp, báo bác sĩ xem trực tiếp hồ sơ gốc |
| Sự cố bảo mật/rò rỉ nghi ngờ | Tắt tính năng, kích hoạt quy trình xử lý sự cố dữ liệu |

---

## PHASE 5 – EVALUATE

### 5.1 Checklist sẵn sàng

| # | Tiêu chí | Trạng thái | Ghi chú / Bằng chứng cần có |
|---|---|---|---|
| 1 | Bài toán rõ, có actor và pain point thật | ✅ Đạt | Đau lặp lại hằng ngày; cần xác nhận số liệu bằng time study |
| 2 | Có metric đo được bằng số (baseline → target) | ✅ Đạt | Baseline là ước tính, cần đo lại tuần đầu pilot |
| 3 | Dữ liệu EMR sẵn có và truy cập được | ⚠️ Một phần | Cần xác nhận API/xuất dữ liệu EMR, mức độ có cấu trúc, chất lượng ghi chú |
| 4 | Tuân thủ pháp lý & bảo mật dữ liệu y tế | ⚠️ Một phần | Cần phê duyệt DPO/pháp chế, môi trường xử lý nội bộ/được phê duyệt, ẩn danh khi thử nghiệm |
| 5 | AI phù hợp bài toán (không cần AI cho phần deterministic) | ✅ Đạt | Rule cho dữ liệu cấu trúc, LLM chỉ cho văn bản tự do |
| 6 | Có cơ chế Human-in-the-loop rõ ràng | ✅ Đạt | Bác sĩ duyệt bắt buộc, có trích dẫn nguồn |
| 7 | Có fallback khi AI lỗi | ✅ Đạt | Quay về quy trình thủ công + dữ liệu cấu trúc |
| 8 | Có cách đánh giá chất lượng AI (golden set) | ⚠️ Chưa có | Cần bộ 50–100 ca đã ẩn danh, bác sĩ gán nhãn chuẩn |
| 9 | Có sponsor lâm sàng/người dùng chủ chốt | ⚠️ Chưa xác nhận | Cần ít nhất 1 trưởng khoa và 1 thư ký y khoa tham gia pilot |
| 10 | Rủi ro chấp nhận được (không ảnh hưởng quyết định lâm sàng trực tiếp) | ✅ Đạt (có điều kiện) | AI chỉ hỗ trợ tóm tắt, có duyệt; theo dõi lỗi sót trọng yếu |
| 11 | Khả thi kỹ thuật & tích hợp trong 8–12 tuần cho pilot | ⚠️ Cần xác nhận | Phụ thuộc năng lực tích hợp EMR |

### 5.2 Rủi ro chính & biện pháp giảm thiểu

| Rủi ro | Mức | Giảm thiểu |
|---|---|---|
| Hallucination (AI bịa thông tin y khoa) | Cao | Bắt buộc trích dẫn nguồn, đối chiếu số liệu với dữ liệu gốc, bác sĩ duyệt, đo tỉ lệ lỗi trên golden set |
| Rò rỉ dữ liệu bệnh nhân | Cao | Xử lý trong hạ tầng được phê duyệt, RBAC, audit log, ẩn danh khi thử nghiệm |
| Bác sĩ phụ thuộc quá mức (automation bias) | Trung bình | Đánh dấu "Cần xác nhận", đào tạo, kiểm tra ngẫu nhiên |
| Chất lượng ghi chú EMR không đồng đều | Trung bình | Bắt đầu 1–2 khoa có dữ liệu tốt, mở rộng dần |
| Người dùng không chấp nhận | Trung bình | Đồng thiết kế với bác sĩ/thư ký, đo thời gian tiết kiệm thực tế |

### 5.3 Quyết định

> ## ✅ **GO** (có điều kiện – triển khai pilot giới hạn)

**Lý do:** nỗi đau rõ và lặp lại, giá trị thời gian đo được, AI chỉ ở vai trò hỗ trợ với duyệt bắt buộc và fallback rõ ràng, nên rủi ro lâm sàng trực tiếp thấp.

**Điều kiện bắt buộc trước khi mở rộng (nếu không đạt chuyển thành NOT YET):**
1. Hoàn tất rà soát pháp lý/bảo mật và chọn môi trường xử lý dữ liệu được phê duyệt.
2. Xác nhận khả năng truy cập dữ liệu EMR (API hoặc xuất dữ liệu) cho pilot.
3. Xây golden set 50–100 ca ẩn danh có bác sĩ gán nhãn.
4. Có 1 khoa pilot với sponsor lâm sàng rõ ràng.

**Tiêu chí thành công pilot (8–12 tuần, 1–2 khoa):**
- Thời gian tóm tắt cơ bản < 1 phút; báo cáo hội chẩn < 10 phút.
- ≥ 95% trường trọng yếu đúng; 0 lỗi sót trọng yếu lọt qua bước duyệt.
- ≥ 70% bác sĩ pilot muốn tiếp tục sử dụng.

**Tiêu chí dừng (NO-GO):** phát hiện lỗi nghiêm trọng lặp lại không khắc phục được, hoặc không đạt yêu cầu bảo mật dữ liệu.
