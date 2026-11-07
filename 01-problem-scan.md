# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 |Xanh SM (GSM)/VinFast|Stakeholder Pain|Tối ưu hóa điểm sạc & Điều phối thông minh: Giảm thời gian chờ sạc rỗng của tài xế vào giờ cao điểm bằng AI Dự báo tải trạm sạc & Cung-Cầu theo thời gian thực.|
| 2 | Vinhomes |Repetitive/Time-consuming |Trợ lý AI xử lý & Phân loại Phản ánh Cư dân: tự động phân loại, bóc tách thông tin từ các bài đăng/khiếu nại/yêu cầu của cư dân trên Vinhomes, xác định mức độ ưu tiên để hỗ trợ nhanh hoặc đẩy về đúng ban kỹ thuật/vệ sinh xử lý. |
| 3 | Xanh SM | Stakeholder Pain + AI-upgrade | Dự đoán thời gian đón khách chính xác hơn, phát hiện GPS sai lệch và tự động điều phối lại tài xế khi cuốc xe bị hủy hoặc tài xế di chuyển sai hướng. |
| 4 | VinFast | Time-consuming + Repetitive |  Tự động đọc mô tả lỗi, phân loại yêu cầu bảo hành, tra cứu lịch sử sửa chữa và gợi ý nguyên nhân lỗi nhằm giảm thời gian tiếp nhận và chẩn đoán xe. |
| 5 | Vinmec | Time-consuming + AI-upgrade | Dự báo lượng bệnh nhân theo khung giờ, tối ưu lịch khám và phân bổ bác sĩ, phòng khám, thiết bị nhằm giảm thời gian chờ đợi. |
| 6 | VinWonders | Stakeholder Pain + AI-upgrade | Đếm lượng khách tại các trò chơi, dự báo thời gian xếp hàng, phát hiện ùn tắc và đề xuất điều phối nhân sự. |
| 7 | VinFast | Repetitive + AI-upgrade |  Sử dụng Computer Vision phát hiện lỗi ngoại quan trên thân xe, sơn, linh kiện và các chi tiết lắp ráp trên dây chuyền sản xuất, giảm phụ thuộc vào kiểm tra thủ công. |
| 8 | Vinpearl | Repetitive + AI-upgrade | Tự động xử lý yêu cầu đặt phòng, thay đổi lịch, giải đáp chính sách, tư vấn dịch vụ và tiếp nhận khiếu nại đa ngôn ngữ, giảm tải cho nhân viên lễ tân và CSKH. |


# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

# QUICK PROBLEM CARD #01 – VINMEC

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #01                                      │
│                                                             │
│ Bài toán (1 câu):                                           │
│ Dự báo nhu cầu khám và sử dụng tài nguyên y tế theo khung  │
│ giờ, kết hợp tối ưu lịch khám và phân bổ bác sĩ, phòng      │
│ khám, thiết bị nhằm giảm thời gian chờ và tránh quá tải.   │
│                                                             │
│ Công ty thành viên:                                         │
│ [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes                      │
│ [x] Vinmec   [ ] Khác                                       │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│ - Bệnh nhân: Phải chờ lâu, không biết thời gian khám dự kiến│
│   và có thể phải chờ thêm khi phát sinh xét nghiệm.         │
│ - Lễ tân/điều phối: Khó xử lý bệnh nhân đến sớm, trễ lịch  │
│   hoặc dồn vào cùng một khung giờ.                          │
│ - Bác sĩ: Lịch khám không đồng đều, lúc quá tải lúc rảnh.   │
│ - Quản lý: Khó dự báo nhu cầu sử dụng phòng khám, thiết bị │
│   và nhân lực theo từng khung giờ.                          │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│ 1. Bệnh nhân đặt lịch hoặc đến trực tiếp.                   │
│ 2. Lễ tân tiếp nhận, xác nhận thông tin và chuyên khoa.     │
│ 3. Nhân viên phân bổ bệnh nhân vào bác sĩ, phòng khám và    │
│    khung giờ phù hợp.                                       │
│ 4. Bệnh nhân chờ khám, xét nghiệm hoặc chẩn đoán hình ảnh.  │
│ 5. Nhân viên xử lý trễ lịch, quá tải và điều chỉnh lịch.   │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│ Bước 3-5: Điều phối lịch khám và xử lý tình trạng dồn      │
│ bệnh nhân, phát sinh xét nghiệm hoặc thời gian khám kéo dài.│
│ Ước tính ban đầu: 5-10 phút/lượt cần điều phối thủ công.   │
│ Cần đo thời gian thực tế để xác nhận baseline.              │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│ - Bước 1: Rule-based kiểm tra lịch hẹn, thông tin bệnh nhân│
│   và điều kiện tiếp nhận.                                   │
│ - Bước 2-3: Predictive ML dự báo lượng bệnh nhân, thời gian│
│   khám và nhu cầu sử dụng tài nguyên theo khung giờ.        │
│ - Bước 3: Optimization đề xuất lịch bác sĩ, phòng khám và  │
│   thiết bị dựa trên các ràng buộc vận hành.                  │
│ - Bước 4: Dự báo thời gian chờ thực tế và cập nhật cho      │
│   bệnh nhân khi lịch khám thay đổi.                         │
│ - Bước 5: Rule Engine cảnh báo quá tải và kiểm tra các      │
│   điều kiện trước khi xác nhận điều chỉnh lịch.             │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Thời gian chờ khám trung vị: Baseline 60 phút -> mục tiêu │
│   dưới 30 phút.                                             │
│ - Thời gian điều phối: Baseline 10 phút -> dưới 3 phút/lượt│
│ - Sai lệch dự báo nhu cầu bệnh nhân: MAPE dưới 15%.        │
│ - Tỷ lệ sử dụng phòng khám: Tăng 10-15% so với baseline,   │
│   không làm tăng thời gian chờ hoặc quá tải bác sĩ.         │
│ - Tỷ lệ bệnh nhân phải đặt lại lịch do quá tải: Giảm 30%.  │
│ - Chi phí vận hành trên mỗi lượt khám: Giảm so với baseline│
│                                                             │
│ Quick Architecture:                                         │
│ [ ] No AI  [x] Rule  [x] Predictive ML                      │
│ [x] Optimization  [ ] LLM  [ ] Agent                        │
│                                                             │
│ Phân chia công nghệ:                                        │
│ - Rule: Kiểm tra điều kiện, lịch trống và quy định khám.   │
│ - ML: Dự báo nhu cầu bệnh nhân và thời gian khám.           │
│ - Optimization: Tối ưu lịch và phân bổ tài nguyên.         │
│                                                             │
│ PoC: Thử nghiệm tại một chuyên khoa trong 4-6 tuần, sử     │
│ dụng dữ liệu lịch hẹn, lịch bác sĩ, thời gian khám thực tế,│
│ tình trạng phòng khám và thiết bị. So sánh với phương pháp │
│ điều phối hiện tại và hệ thống Rule-based baseline.        │
└─────────────────────────────────────────────────────────────┘
```

---

# QUICK PROBLEM CARD #02 – VINFAST & XANH SM

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #02                                      │
│                                                             │
│ Bài toán (1 câu):                                           │
│ Dự báo nhu cầu sạc và tình trạng quá tải tại các trạm sạc, │
│ kết hợp tối ưu lựa chọn trạm và thời điểm sạc cho đội xe   │
│ nhằm giảm thời gian xe ngừng khai thác và tối đa hóa hiệu  │
│ suất hoạt động kinh doanh.                                  │
│                                                             │
│ Công ty thành viên:                                         │
│ [x] VinFast  [x] Xanh SM (GSM)  [ ] Vinhomes               │
│ [ ] Vinmec                                                  │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│ - Tài xế: Mất thời gian tìm trạm, chờ sạc hoặc phải đổi    │
│   trạm khi nơi đến bị quá tải.                              │
│ - Điều phối GSM: Khó cân bằng số xe đang hoạt động và số  │
│   xe cần sạc trong giờ cao điểm.                            │
│ - Đơn vị vận hành trạm: Khó dự báo nhu cầu sạc và phân bổ  │
│   công suất trạm.                                           │
│ - Khách hàng: Có thể thiếu xe sẵn sàng phục vụ khi nhiều   │
│   phương tiện cùng đi sạc.                                  │
│ - Quản lý đội xe: Khó tối ưu doanh thu, chi phí điện và    │
│   thời gian xe ngừng khai thác.                             │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│ 1. Tài xế kiểm tra dung lượng pin (SOC) và nhu cầu sạc.    │
│ 2. Tìm kiếm trạm sạc phù hợp qua ứng dụng.                  │
│ 3. Di chuyển đến trạm sạc đã chọn.                          │
│ 4. Nếu trạm hết chỗ hoặc phải chờ lâu, tài xế chờ hoặc     │
│    tìm trạm khác.                                           │
│ 5. Sạc xong, tài xế quay lại hoạt động kinh doanh.         │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│ Bước 2-4: Chọn trạm chưa tối ưu do thiếu thông tin về hàng │
│ chờ, tình trạng trụ và nhu cầu sạc trong tương lai.        │
│ Tài xế có thể mất 15-60 phút chờ sạc vào giờ cao điểm.     │
│ Ngoài ra, việc chọn trạm quá xa có thể làm tăng thời gian  │
│ di chuyển và chi phí vận hành.                              │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│ - Bước 1: Rule-based kiểm tra SOC và ngưỡng pin an toàn;   │
│   ML dự báo thời điểm xe cần sạc dựa trên lịch sử hoạt động│
│   và mức tiêu thụ năng lượng.                               │
│ - Bước 2: Predictive ML dự báo nhu cầu sạc và thời gian    │
│   chờ tại từng trạm trong 15-60 phút tiếp theo.             │
│ - Bước 2-3: Optimization đề xuất trạm sạc và thời điểm     │
│   sạc tối ưu theo khoảng cách, hàng chờ, chi phí và nhu cầu│
│   duy trì số xe hoạt động.                                  │
│ - Bước 4: Rule Engine kiểm tra trạng thái trạm, khả năng   │
│   tiếp nhận và điều kiện tương thích trước khi đề xuất.    │
│ - Bước 5: Theo dõi thời gian xe ngừng khai thác và đề xuất│
│   điều chỉnh kế hoạch sạc cho đội xe.                       │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Thời gian chờ tại trạm: Baseline 30 phút -> dưới 10 phút│
│ - Thời gian tìm và lựa chọn trạm: 10 phút -> dưới 3 phút. │
│ - Tỷ lệ phải đổi trạm do quá tải: 15% -> dưới 5%.         │
│ - Sai lệch dự báo nhu cầu sạc: MAPE dưới 20%.              │
│ - Thời gian xe ngừng khai thác do chờ sạc: Giảm 20%.      │
│ - Fleet Availability: Tăng tối thiểu 5 điểm phần trăm so   │
│   với baseline tại khu vực thử nghiệm.                      │
│ - Chi phí vận hành trên mỗi xe/ngày: Giảm so với baseline.│
│                                                             │
│ Quick Architecture:                                         │
│ [ ] No AI  [x] Rule  [x] Predictive ML                      │
│ [x] Optimization  [ ] LLM  [ ] Agent                        │
│                                                             │
│ Phân chia công nghệ:                                        │
│ - Rule: Kiểm tra SOC, tương thích trụ và điều kiện an toàn.│
│ - ML: Dự báo nhu cầu sạc và tình trạng quá tải trạm.       │
│ - Optimization: Tối ưu trạm, thời điểm sạc và phân bổ xe.  │
│                                                             │
│ PoC: Thử nghiệm tại 5-10 trạm sạc có lưu lượng cao trong   │
│ 4-6 tuần, sử dụng dữ liệu GPS, SOC, trạng thái trụ, lịch   │
│ sử sạc, thời gian chờ và lịch sử hoạt động của đội xe.     │
│ So sánh phương pháp lựa chọn trạm hiện tại, Rule-based và  │
│ phương pháp Hybrid ML + Optimization.                      │
└─────────────────────────────────────────────────────────────┘
```

---

# QUICK PROBLEM CARD #03 – VINHOMES

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #03                                      │
│                                                             │
│ Bài toán (1 câu):                                           │
│ Xây dựng hệ thống AI hỗ trợ tiếp nhận, bóc tách thông tin, │
│ phân loại và xác định mức độ ưu tiên của phản ánh cư dân,  │
│ kết hợp Rule Engine để tự động chuyển ticket đến đúng bộ  │
│ phận, theo dõi SLA và giảm thời gian xử lý yêu cầu.        │
│                                                             │
│ Công ty thành viên:                                         │
│ [ ] VinFast  [ ] Xanh SM  [x] Vinhomes                      │
│ [ ] Vinmec   [ ] Khác                                       │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│ - Cư dân: Phải mô tả vấn đề nhiều lần, không biết tiến độ  │
│   và thời gian dự kiến xử lý phản ánh.                      │
│ - CSKH/Ban quản lý: Phải đọc, phân loại và chuyển tiếp      │
│   nhiều ticket thủ công.                                    │
│ - Ban kỹ thuật: Nhận yêu cầu thiếu thông tin hoặc sai nhóm.│
│ - Quản lý: Khó theo dõi sự cố lặp lại, ticket tồn đọng và  │
│   các trường hợp vi phạm SLA.                               │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│ 1. Cư dân gửi phản ánh qua ứng dụng, hotline hoặc email.   │
│ 2. Nhân viên CSKH đọc nội dung và bóc tách thông tin.      │
│ 3. Phân loại sự cố, xác định mức độ ưu tiên và bộ phận     │
│    phụ trách.                                               │
│ 4. Tạo ticket và chuyển cho bộ phận liên quan xử lý.       │
│ 5. Theo dõi tiến độ, cập nhật trạng thái và phản hồi cư dân│
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│ Bước 2-4: Đọc nội dung, bóc tách thông tin, phân loại và   │
│ chuyển tiếp phản ánh.                                       │
│ Ước tính ban đầu: 5-10 phút/ticket.                         │
│ Các ticket có cấu trúc rõ ràng có thể xử lý nhanh bằng     │
│ Rule-based, trong khi phản ánh phức tạp cần hiểu ngữ cảnh. │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│ - Bước 1: Rule-based tiếp nhận và chuẩn hóa dữ liệu từ các │
│   kênh; LLM hỗ trợ hiểu nội dung phản ánh tự nhiên.        │
│ - Bước 2: LLM bóc tách vị trí, mã căn hộ, loại sự cố,      │
│   thời gian và thông tin liên quan từ nội dung tự do.       │
│ - Bước 3: Rule-based xử lý các danh mục rõ ràng; LLM hỗ    │
│   trợ phân loại phản ánh phức tạp, nhiều vấn đề hoặc mơ hồ.│
│ - Bước 4: Rule Engine kiểm tra bộ phận phụ trách, mức độ   │
│   ưu tiên và điều kiện chuyển ticket; nhân viên xác nhận   │
│   những trường hợp có rủi ro cao hoặc độ tin cậy thấp.     │
│ - Bước 5: Workflow Automation theo dõi SLA, cảnh báo ticket│
│   gần quá hạn, phát hiện phản ánh trùng và tạo phản hồi nháp│
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ - Thời gian phân loại: Baseline 8 phút -> dưới 1 phút.    │
│ - Độ chính xác phân loại: Baseline 80% -> trên 95%.       │
│ - Tỷ lệ chuyển sai bộ phận: Baseline 10% -> dưới 3%.     │
│ - Tỷ lệ phát hiện ticket trùng: Recall trên 90%.           │
│ - Thời gian phản hồi ban đầu: 30 phút -> dưới 5 phút.     │
│ - Tỷ lệ nhân viên phải chỉnh sửa kết quả AI: Giảm so với  │
│   baseline thủ công.                                        │
│ - MTTR: Giảm ít nhất 15% so với baseline tại khu vực PoC. │
│ - Cost per Ticket: Giảm so với quy trình xử lý hiện tại.  │
│                                                             │
│ Quick Architecture:                                         │
│ [ ] No AI  [x] Rule  [ ] Predictive ML                      │
│ [ ] Optimization  [x] LLM  [ ] Agent                        │
│ [x] RAG (tùy chọn)  [x] Workflow Automation                 │
│ [x] Semantic Search (tùy chọn)                              │
│                                                             │
│ Phân chia công nghệ:                                        │
│ - Rule: Xử lý ticket có cấu trúc, kiểm tra SLA và điều kiện│
│   chuyển bộ phận.                                           │
│ - LLM: Hiểu ngôn ngữ tự nhiên, bóc tách thông tin và phân  │
│   loại các phản ánh phức tạp.                               │
│ - RAG/Semantic Search: Tra cứu quy trình, quy định và lịch │
│   sử sự cố tương tự khi cần thiết.                          │
│ - Workflow Automation: Tạo ticket, chuyển bộ phận và theo │
│   dõi tiến độ.                                              │
│ - Human-in-the-loop: Xác nhận các trường hợp nhạy cảm hoặc │
│   có độ tin cậy thấp.                                       │
│                                                             │
│ PoC: Sử dụng 1.000-5.000 ticket đã ẩn danh từ một khu đô   │
│ thị trong 4-6 tuần. Xây dựng ba phương pháp để so sánh:    │
│ Rule-based, LLM và Hybrid Rule-based + LLM.                 │
│ Đánh giá Accuracy, Precision, Recall, F1-score, thời gian  │
│ xử lý, tỷ lệ chuyển sai bộ phận, tỷ lệ nhân viên chỉnh sửa│
│ và chi phí xử lý mỗi ticket. Triển khai Human-in-the-loop │
│ trước khi áp dụng vào quy trình vận hành thực tế.          │
└─────────────────────────────────────────────────────────────┘
```