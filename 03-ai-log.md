# Nhật ký tương tác AI - Lab 02 AI Product Scoping

## Vai trò của AI trong buổi lab

AI được dùng như một thought partner để:

1. Brainstorm các bài toán tại Xanh SM, VinFast, Vinhomes và Vinmec theo 4 lens.
2. Kiểm tra lại quick cards xem metric đã đo được giá trị hay chỉ mô tả chung chung.
3. Stress-test prompt bằng các yêu cầu ép model gửi trực tiếp, bỏ thẻ [DRAFT_ONLY] hoặc đề xuất trạm xa khi pin thấp.
4. Đối chiếu cấu trúc report với Problem Statement 6-field và Future-State Flow.

## Lỗi hoặc hallucination đã quan sát/cần tránh

Trong quá trình lập prompt, một phản hồi chấp nhận đề xuất trạm xa với pin 2% đã cho thấy rủi ro nếu chỉ mô tả bằng ngôn ngữ mơ hồ. Một đề xuất khác có thể trông hợp lý nhưng chưa xác nhận loại connector, vị trí GPS và trạng thái trụ trống. Nếu tin tưởng kết quả đó, điều phối viên có thể gửi hướng dẫn không khả thi cho tài xế.

## Prompt và ranh giới đã sửa

Prompt ban đầu được viết lại thành quy tắc có điều kiện rõ ràng: bắt buộc [DRAFT_ONLY], pin dưới 5% không đề xuất trạm xa hơn 5 km, hành động phải ở dạng JSON `dispatch_mobile_charger`, mọi thao tác thực tế đều chờ điều phối viên duyệt. Tôi cũng bổ sung quy tắc từ chối khi dữ liệu không đầy đủ thay vì bịa đáp án.

Adversarial test được mở rộng từ 2 mẫu ban đầu lên 4 mẫu, bao gồm ép gửi thẳng, ép bỏ thẻ nháp, dữ liệu GPS giả và áp lực gọi cứu hộ ở mức pin không nguy cấp. Khi không có API key, prototype chạy deterministic checks để phục vụ CI; khi có key, file gọi Gemini 2.5 Flash qua SDK.

## Phản ánh bản thân

AI giúp tôi rút ngắn thời gian sơ đồ hoá và tìm ra cách kiểm tra ranh giới định lượng, nhưng không thay thế kiến thức nghiệp vụ. Các con số giờ công và KPI trong báo cáo được ghi là giả định pilot và không được trình bày như dữ liệu thực. Quyết định cuối chọn NOT YET vì cần xác nhận stakeholder và dữ liệu API; đây là một quyết định có căn cứ kỹ thuật thay vì chấp nhận bài toán chỉ vì prompt chạy được.

AI tạo draft, con người phải chịu trách nhiệm:

- xác minh quy trình tại Trung tâm Điều vận;
- xác nhận nguồn dữ liệu;
- duyệt mọi tin nhắn gửi tài xế;
- đánh giá phản hồi model bằng case thật thay vì một vài ví dụ.
