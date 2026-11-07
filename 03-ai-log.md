# 03 – Nhật ký tương tác AI

> **Lưu ý khi nộp:** đây là bản nháp dựa trên những gì thực sự diễn ra trong phiên làm việc với Claude. Các phần đánh dấu **[BẠN BỔ SUNG]** cần bạn viết lại bằng trải nghiệm thật của mình (ví dụ lần bạn dùng ChatGPT/Gemini, hoặc lần bạn tự sửa prompt). Hãy chỉnh giọng văn cho giống bạn trước khi nộp.

## 1. Bối cảnh

Mình dùng AI để hỗ trợ tìm kiếm thông tin về các công ty trong tập đoàn, các vấn đề 

## 2. AI đã giúp được gì

- **Mở rộng và cấu trúc hóa nhanh.** Từ một card, AI đề xuất thêm các bài toán ở Xanh SM, VinFast, Vinhomes và dựng bảng chấm điểm, nên mình tiết kiệm được nhiều thời gian brainstorm ban đầu.
- **Phân vai Rule / LLM / Agentic loop.** AI tách rõ phần nào cần quy tắc xác định (phân quyền, chuẩn hóa đơn vị), phần nào cần LLM (đọc ghi chú tự do), phần nào cần vòng lặp có giới hạn. Nhờ đó mình hiểu vì sao không nên dùng LLM cho mọi bước.
- **Nghĩ tới rủi ro mình dễ bỏ sót:** human-in-the-loop bắt buộc, fallback khi AI lỗi, golden set để đo chất lượng, ràng buộc dữ liệu y tế.
- **Vẽ sơ đồ bằng code.** AI tạo sơ đồ swimlane có Handoff và Bottleneck, tự mở ảnh kiểm tra và sửa các lỗi hiển thị.

## 3. AI sai hoặc "bịa" ở đâu, và mình đã xử lý ra sao

**3.1. Tự đặt ra cấu trúc worksheet.** Đề bài yêu cầu "copy nội dung từ `01-worksheet.md`", nhưng mình chưa đưa file đó cho AI. Thay vì hỏi, AI tự đặt tên cột bảng SCAN, thang điểm QUICK-ASSESS và 6 trường Problem Statement. Kết quả trông hợp lý nhưng có thể không khớp mẫu của giảng viên.
*Cách sửa:* mình nhận ra đây là phần AI suy đoán, nên đối chiếu lại với worksheet gốc và đổi tên cột/trường cho đúng mẫu. **[BẠN BỔ SUNG: bạn đã đổi những gì]**

**3.2. Con số được bịa ra nghe rất thuyết phục.** AI đưa vào các số như 40 lần tóm tắt/bác sĩ/tuần, 8 ca hội chẩn khó/khoa/tuần, tỉ lệ chuyển sai bộ phận 15% ở Xanh SM, hay ngưỡng 95% trường trọng yếu đúng. Đây là giả định của AI, không phải dữ liệu thật. Ở sơ đồ, thời gian từng bước (2 / 1,5 / 0,5 / 0,5 / 0,5 phút cho ca cơ bản; 15 / 20 / 10 / 5 / 10 phút cho ca khó) cũng được AI chia ra sao cho cộng lại đúng 5 và 60 phút, chứ không đo từ thực tế.
*Cách sửa:* mình yêu cầu AI ghi rõ "ước tính/giả định" ở đầu mỗi file, và sẽ thay bằng số đo thực tế (time study, phỏng vấn bác sĩ/thư ký) trước khi dùng làm bằng chứng. **[BẠN BỔ SUNG: số liệu thật bạn đã đo hoặc hỏi được]**

**3.3. Sai số học trong chú thích.** Trong bản sơ đồ đầu tiên, AI ghi "Bước 1 và 2 chiếm ~70% thời gian ca hội chẩn khó". Mình kiểm tra lại: (15 + 20) / 60 ≈ 58%; con số 70% chỉ đúng với ca cơ bản (3,5 / 5). AI đã sửa chú thích thành "~58% ca khó, ~70% ca cơ bản".
*Bài học:* luôn tự tính lại các tỉ lệ AI đưa ra.

**3.4. Lỗi hiển thị khi vẽ sơ đồ.** Lần render đầu có ký hiệu đồng hồ không hiển thị được trong font, hộp "Bắt đầu" đè lên bước 1 và nhãn HANDOFF đè lên chữ trong bước 4, 5. AI chỉ phát hiện sau khi mở ảnh ra xem.
*Cách sửa:* bỏ ký hiệu không hỗ trợ, dời hộp bắt đầu, dời nhãn HANDOFF ra cạnh đường nối rồi render lại và kiểm tra bằng mắt.
*Bài học:* không tin sơ đồ "đã xong" nếu chưa nhìn ảnh thật.

**3.5. Chọn bài toán không nhất quán.** Ở file 01, AI đề xuất đi sâu Card #2 (Xanh SM, điểm 18) vì điểm cao nhất, nhưng ở file 02 lại phân tích Card #1 (Vinmec, điểm 14) mà không hỏi. Lý do là Card #1 do mình viết, nhưng AI không nói rõ sự đổi hướng này và hai file nhìn như mâu thuẫn.
*Cách sửa:* mình quyết định rõ bài toán nào là bài chính và yêu cầu giải thích lý do chọn trong báo cáo (ví dụ: rủi ro lâm sàng cao hơn nhưng phù hợp để minh họa human-in-the-loop và fallback). **[BẠN BỔ SUNG: lý do thật của bạn]**

**3.6. Trích dẫn pháp lý từ trí nhớ.** AI nêu Nghị định 13/2023/NĐ-CP về bảo vệ dữ liệu cá nhân như một ràng buộc. Đây là thông tin AI nhớ lại, không tra cứu tại thời điểm viết.
*Cách sửa:* mình coi đó là gợi ý cần kiểm chứng với văn bản gốc hoặc pháp chế trước khi ghi như một căn cứ chắc chắn. **[BẠN BỔ SUNG: bạn đã tra lại chưa]**

## 4. Prompt và ranh giới mình đã điều chỉnh

| Vấn đề | Prompt/ranh giới ban đầu | Prompt/ranh giới sau khi sửa |
|---|---|---|
| AI tự đoán cấu trúc | "Làm file 02 theo worksheet" (không đính kèm worksheet) | Đính kèm `01-worksheet.md` và yêu cầu "dùng đúng tên cột/trường trong mẫu, thiếu gì thì hỏi lại" |
| AI bịa số | Không có ràng buộc | "Chỉ dùng số tôi cung cấp; số nào AI tự đặt phải ghi *ước tính* và liệt kê riêng để tôi kiểm chứng" |
| Sơ đồ lỗi hiển thị | "Vẽ sơ đồ quy trình" | "Render xong phải mở ảnh kiểm tra chồng lấn/ký tự lỗi và sửa trước khi gửi" |
| Chọn bài toán | Không nói rõ | "Hỏi tôi trước khi đổi bài toán; nếu khác với đề xuất trước đó phải nêu lý do" |
| Số liệu/pháp lý | Không có ràng buộc | "Tỉ lệ phải kèm phép tính; căn cứ pháp lý phải có nguồn hoặc ghi cần xác minh" |

## 5. Nhận xét chung

AI rất mạnh ở việc dựng khung, mở rộng ý tưởng và nhắc các rủi ro mình dễ quên, nhưng nó có xu hướng **điền cho đầy** những chỗ còn thiếu bằng nội dung nghe hợp lý: số liệu, cấu trúc biểu mẫu, căn cứ pháp lý. Vai trò của mình là người đặt ranh giới (cái gì AI được suy đoán, cái gì phải có nguồn), kiểm tra lại phép tính, và là người quyết định cuối cùng. Với bài toán y tế, nguyên tắc này càng quan trọng: AI chỉ hỗ trợ, con người duyệt, và mọi con số phải được kiểm chứng bằng dữ liệu thật.

