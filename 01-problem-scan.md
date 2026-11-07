# Báo cáo Quét Bài toán - Xanh SM / Vin Smart Future

## 1. Phạm vi quét

Danh sách dưới đây quét các pain point vận hành tại các công ty thành viên, sử dụng đủ 4 lens bắt buộc: Repetitive, Time-consuming, AI-upgrade và Stakeholder Pain.

| # | Công ty thành viên | Lens | Mô tả bài toán |
|---:|---|---|---|
| 1 | Xanh SM | Lặp lại | Điều phối viên phải tra cứu vị trí xe, tình trạng pin và trạm sạc trống cho từng cuộc gọi hỗ trợ trên đường. |
| 2 | VinFast | Tốn thời gian | Đối chiếu dữ liệu phiên sạc tại trụ đối tác với hóa đơn tài chính hàng tuần giữa nhiều nguồn dữ liệu. |
| 3 | Vinhomes | AI-upgrade | Phân loại phản ánh cư dân về nước, điện, an ninh và chuyển tới đúng bộ phận quản lý tòa nhà. |
| 4 | Vinpearl | Pain từ người khác | Tổng hợp review khách sạn theo khu vực nhưng chưa ưu tiên kịp các cảnh báo nghiêm trọng cho quản lý ca. |
| 5 | Vinmec | Tốn thời gian | Bác sĩ tổng hợp hồ sơ xét nghiệm và ghi chú để soạn tóm tắt xuất viện bằng ngôn ngữ dễ hiểu cho bệnh nhân. |
| 6 | VinFast | AI-upgrade | Phân loại mô tả tiếng Việt về tiếng động hoặc lỗi xe thành hướng kỹ thuật ban đầu để điều phối kiểm tra bảo dưỡng. |

## 2. Ba Quick Problem Cards

### Card #1 - Sự cố pin nghiêm trọng của tài xế Xanh SM

- **Bài toán:** Điều phối viên mất nhiều bước thủ công để quyết định trạm sạc hay xe cứu hộ khi pin tài xế dưới ngưỡng nguy cấp.
- **Công ty thành viên:** Xanh SM.
- **Actor đang đau:** Tài xế đang dừng xe giữa tuyến; điều phối viên chịu áp lực thời gian thực; đội cứu hộ phụ thuộc lệnh điều phối.
- **Workflow thủ công:** 1) Nhận cuộc gọi -> 2) Tra cứu GPS và SOC -> 3) Kiểm tra trạm sạc/trụ trống -> 4) Ước tính khoảng cách -> 5) Soạn tin và gọi cứu hộ.
- **Bottleneck:** Bước tra cứu trạm và soạn chỉ dẫn, ước tính **12 phút/lượt**; sai lệch dữ liệu có thể khiến xe cạn pin.
- **AI hỗ trợ:** Tổng hợp dữ liệu vị trí, SOC và trạm còn trụ trống thành một bản nháp có rõ [DRAFT_ONLY].
- **Metric:** Giảm thời gian xử lý sự cố từ **15 phút xuống dưới 3 phút**; ít nhất **95%** bản nháp theo đúng trạng thái pin.
- **Quick Architecture:** LLM Feature, kết hợp Rule cho ngưỡng pin và khoảng cách.

### Card #2 - Đối chiếu hóa đơn sạc VinFast

- **Bài toán:** Nhân viên tài chính phải đối chiếu hàng nghìn phiên sạc từ trạm đối tác với hóa đơn và hợp đồng.
- **Công ty thành viên:** VinFast.
- **Actor đang đau:** Nhân viên tài chính và quản lý trạm đối tác.
- **Workflow thủ công:** 1) Xuất phiên sạc -> 2) Chuẩn hóa định dạng -> 3) Ghép mã trụ và mã hóa đơn -> 4) Điều tra sai lệch -> 5) Xác nhận thanh toán.
- **Bottleneck:** Chuẩn hóa và ghép dữ liệu chéo, ước tính **3 giờ/ngày**.
- **AI hỗ trợ:** Phát hiện bản ghi khả nghi, lý giải nguyên nhân ghép sai và đề xuất danh mục cần nhân sự kiểm tra.
- **Metric:** Giảm thao tác thủ công **60%** và giữ **98%** tỷ lệ ghép chính xác.
- **Quick Architecture:** Rule ưu tiên; LLM hỗ trợ giải thích sai lệch.

### Card #3 - Phân loại phản ánh cư dân Vinhomes

- **Bài toán:** Phản ánh trên ứng dụng cư dân được phân loại và chuyển đi bằng nhiều thao tác thủ công.
- **Công ty thành viên:** Vinhomes.
- **Actor đang đau:** Nhân viên chăm sóc cư dân, Ban quản lý tòa nhà và cư dân chờ phản hồi.
- **Workflow thủ công:** 1) Thu thập phản ánh -> 2) Phân loại chủ đề -> 3) Xác định tòa/đơn vị -> 4) Gắn mức ưu tiên -> 5) Điều phối nhân sự.
- **Bottleneck:** Phân loại và điều hướng, ước tính **8 phút/vé** vào giờ cao điểm.
- **AI hỗ trợ:** Classify bằng taxonomy có sẵn, sinh tóm tắt ngắn và đề xuất phòng ban.
- **Metric:** Phân loại đúng **92%** và giảm thời gian trung bình xuống dưới **3 phút/vé**.
- **Quick Architecture:** Rule/Classifier kết hợp LLM khi nội dung thiếu cấu trúc.

## 3. Lựa chọn bài toán

Nhóm chọn **Card #1 — sự cố pin nghiêm trọng của tài xế Xanh SM** vì tác động thời gian thực, ranh giới an toàn có thể kiểm chứng bằng ngưỡng 5%/5 km và dữ liệu đầu vào tương đối dễ mô phỏng trong lab. Card #2 và #3 vẫn có giá trị nhưng ít phù hợp để kiểm chứng prompt boundary ngay trong buổi lab.
