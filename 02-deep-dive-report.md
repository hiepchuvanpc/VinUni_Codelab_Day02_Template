# Báo cáo Deep-Dive: Trợ lý nháp sự cố pin Xanh SM

## 1. Current-State Workflow Mapping

```text
[Tài xế báo sự cố]
        |
        v
1. Điều phối viên nhận cuộc gọi; ghi SOC và vị trí      ⏱ 2 phút
        | 🔄 Handoff điện thoại/App điều vận
        v
2. Tra cứu GPS xe trên bản đồ; xác nhận vị trí          ⏱ 2 phút
        | 🔄 Handoff sang dashboard trạm
        v
3. Kiểm tra trạm/connector còn trống                    ⏱ 5 phút 🔴
        | 🔴 Bottleneck chính: nhiều dashboard, dữ liệu trễ
        v
4. Ước tính khả năng xe tới trạm theo pin/đường         ⏱ 4 phút 🔴
        | 🔄 Handoff sang tin nhắn tài xế
        v
5. Soạn tin và gọi đội xe cứu hộ nếu pin cực thấp       ⏱ 2 phút
        |
        v
[Tài xế tiếp nhận hướng dẫn; điều phối đóng ca]

Tổng thời gian hiện tại: 15 phút/lượt
```

Điểm chuyển giao hiện tại dễ sai: tài xế đọc SOC khác dashboard, vị trí GPS không đồng bộ, trạng thái trụ sạc không được xác nhận lần cuối. Điểm nghẽn lớn nhất nằm ở bước 3-4 vì phải ghép dữ liệu từ nhiều nguồn và tự tính khoảng cách.

## 2. Problem Statement 6-field

| Field | Nội dung chi tiết |
|---|---|
| 1. Actor / Operator | Điều phối viên Trung tâm Điều vận Xanh SM và đội cứu hộ xử lý pin thực địa. |
| 2. Current Workflow | Khi nhận báo hết pin, điều phối viên tra GPS, hỏi SOC, tra dashboard trạm sạc, chọn trạm phù hợp, soạn tin và quyết định gọi xe cứu hộ bằng quy trình thủ công. Mỗi sự cố mất khoảng 15 phút. |
| 3. Bottleneck | Ghép vị trí GPS, SOC, cổng sạc và trạng thái trụ trống vào một quyết định nhất quán; mất 9 phút ở bước tra cứu và ước tính an toàn. |
| 4. Business Impact | Với giả định pilot 80 sự cố/ngày, quy trình 15 phút/lượt tạo ra 20 giờ công điều vận/ngày. Tài xế chờ lâu làm tăng rủi ro xe không thể đón cuốc; sai trạm có thể khiến xe dừng giữa tuyến. |
| 5. Success Metric | Giảm thời gian trung bình từ 15 phút xuống dưới 3 phút; ít nhất 95% trường hợp dưới 5% được phân nhánh xe sạc di động; 98% bản nháp có đúng [DRAFT_ONLY] và loại trụ được xác minh trong test. |
| 6. Operational Boundary | AI được tổng hợp dữ liệu API, tính khoảng cách sơ bộ và sinh nháp. AI tuyệt đối không gửi tin, điều xe, cam kết trạng thái trụ hoặc chọn trạm khi dữ liệu chưa xác minh. Pin dưới 5% và trạm xa hơn 5 km phải chuyển sang đề xuất xe sạc di động. Điều phối viên duyệt trước mọi liên lạc. |

## 3. Future-State Flow & AI Fit

- **AI Fit:** LLM Feature kết hợp Rule-based State Machine. Rule xử định ngưỡng pin/khoảng cách; LLM chỉ tổng hợp và soạn nháp ngôn ngữ.
- **Lý do không dùng Agent:** Quy trình có số bước cố định, không cần Agent tự quyết định hoặc gọi nhiều công cụ bên ngoài.

```text
[Báo sự cố]
   |
   v
1. Điều phối viên xác nhận vị trí và SOC
   |
   v
2. Rule engine chuẩn hóa dữ liệu và kiểm tra SOC < 5%
   |                           |
   | SOC < 5%                  | SOC >= 5%
   v                           v
3. Nếu pin nguy cấp:          3. 🔵 LLM truy xuất trạm đủ điều kiện
   dispatch_mobile_charger          và chuẩn bị bản nháp
   |                           |
   +-------------+-------------+
                 v
4. 🟢 Điều phối viên kiểm tra bản đồ, khoảng cách và quyền gửi
                 |
                 v
5. Duyệt và gửi; nếu chưa chắc, giữ ca hoặc chuyển đội cứu hộ
                 |
                 v
↩️ FALLBACK: API trạm/LLM lỗi -> rollback quy trình thủ công 15 phút;
không sinh đề xuất trạm cụ thể.
```

## 4. Compare AI Approaches

| Phương án | Ưu điểm | Nhược điểm | Kết luận |
|---|---|---|---|
| Rule / State Machine | An toàn, dễ kiểm thử ngưỡng và khoảng cách, chi phí thấp | Không soạn ngôn ngữ linh hoạt và không giải thích ngữ cảnh phức tạp | Nên giữ cho safety boundary |
| LLM Feature | Tổng hợp dữ liệu, draft tiếng Việt, diễn đạt ngắn gọn | Có thể hallucinate trạm hoặc tự tin vượt giới hạn | Phù hợp ở bước sinh nháp |
| Agentic Loop | Có thể gọi nhiều công cụ và tự sửa lỗi | Quyền tác nghiệp lớn, khó audit, không cần cho scope này | Không dùng ở pilot |

## 5. Evaluate — AI Readiness Checklist

- [x] Có giả lập dữ liệu vị trí, pin, trụ trống để chạy adversarial test.
- [x] Rủi ro sai ở mức kiểm soát được nhờ rule ngưỡng, tag [DRAFT_ONLY] và human review.
- [ ] Stakeholder vận hành cần xác nhận quy trình thực tế và KPI trên dữ liệu pilot.
- [ ] API trạng thái trụ, GPS và SOC cần kết nối/live test trong môi trường thực.

### Quyết định: NOT YET

**Justification:** Bài toán có giá trị, quy trình tương lai rõ và prompt prototype đã có các kiểm soát bắt buộc. Tuy nhiên hệ thống chưa có dữ liệu vận hành, SLA API và xác nhận của Xanh SM. Vì vậy chưa nên GO toàn diện; bước tiếp theo là chạy sandbox 2 tuần với dữ liệu sạch và HITL. Điều kiện chuyển sang GO: API trả dữ liệu đúng trong 95% lượt gọi, không có vi phạm ngưỡng pin/5 km trong 100 test adversarial, thời gian nháp dưới 3 phút và 20 điều phối viên pilot xác nhận quy trình phù hợp.
