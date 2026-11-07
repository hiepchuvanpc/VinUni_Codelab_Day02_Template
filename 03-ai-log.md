# 🤖 AI REFLECTION REPORT — LAB 02: AI PRODUCT SCOPING

## 1. AI đã giúp gì trong quá trình làm bài?

### 1.1. Hỗ trợ brainstorm và xác định bài toán tiềm năng

- Sử dụng AI để mở rộng góc nhìn và tìm kiếm các vấn đề vận hành thực tế tại VinFast, Xanh SM, Vinhomes và Vinmec.
- Áp dụng khung **4 Lenses** (Repetitive, Time-consuming, AI-upgradeable, Stakeholder Pain) để nhận diện và phân loại các điểm nghẽn có tiềm năng ứng dụng AI.
- Hỗ trợ tổng hợp và sàng lọc các ý tưởng thành danh sách 8 bài toán thực tế, tạo cơ sở cho việc xây dựng Quick Problem Cards và lựa chọn bài toán trọng tâm.

### 1.2. Chuẩn hóa phân tích nghiệp vụ

- Hỗ trợ xây dựng báo cáo theo khung **6-Field Problem Statement**, làm rõ các thành phần:
  - Actor / Operator: Đối tượng trực tiếp tham gia quy trình.
  - Current Workflow: Quy trình vận hành hiện tại.
  - Bottleneck: Những điểm nghẽn và nguyên nhân gây lãng phí.
  - Business Impact: Ảnh hưởng đến hiệu suất và hoạt động kinh doanh.
  - Success Metrics: Các chỉ số đánh giá hiệu quả.
  - Operational Boundary: Phạm vi và giới hạn hoạt động của AI.

### 1.3. Hỗ trợ xây dựng và kiểm chứng phương án AI

- Hỗ trợ hình thành bản mẫu thử nghiệm (Prompt Prototype) để kiểm tra khả năng ứng dụng AI vào quy trình điều phối.
- Đề xuất các nguyên tắc kiểm soát đầu ra, bao gồm cơ chế chỉ tạo bản nháp `[DRAFT_ONLY]`, phân loại tình huống và xử lý các trường hợp pin xuống dưới ngưỡng an toàn.
- Giúp làm rõ sự khác biệt giữa việc sử dụng AI để hỗ trợ giao tiếp và việc sử dụng các mô hình chuyên biệt để giải quyết bài toán dự báo, điều phối.

---

## 2. AI đã sai sót và gặp ảo giác (Hallucination) ở đâu?

### 2.1. Nhầm lẫn phạm vi bài toán trọng tâm

- Bài toán thực tế cần tập trung vào **dự báo nhu cầu và tối ưu điều phối sạc tại các trạm sạc cho đội xe điện**, đặc biệt là khả năng phân bổ nhu cầu theo thời gian và địa điểm.
- Sai lệch này cho thấy AI có thể ưu tiên thông tin nổi bật trong ngữ cảnh mà không thực sự xác định đúng phạm vi và mục tiêu nghiệp vụ của bài toán.

### 2.2. Thiên kiến ưu tiên LLM (LLM-First Bias)

- AI có xu hướng đề xuất LLM hoặc Multi-Agent cho nhiều công đoạn, ngay cả khi những công đoạn đó không cần khả năng xử lý ngôn ngữ tự nhiên.
- Qua quá trình phản biện, tôi nhận ra bài toán điều phối trạm sạc cần sự kết hợp của nhiều phương pháp chuyên biệt:
  - **Rule Engine:** Kiểm tra điều kiện vận hành và các ràng buộc an toàn.
  - **Predictive ML:** Dự báo nhu cầu sạc theo thời gian, địa điểm và đặc điểm hoạt động của đội xe.
  - **Optimization Engine:** Tối ưu phân bổ phương tiện, lịch sạc và nguồn lực dựa trên các ràng buộc thực tế.
  - **LLM:** Chỉ đóng vai trò bổ trợ trong tổng hợp thông tin, giải thích kết quả và giao tiếp với người vận hành khi cần.
- Như vậy, không phải cứ đưa LLM vào càng nhiều thì giải pháp càng thông minh hoặc hiệu quả.

### 2.3. Hạn chế trong việc xem xét môi trường triển khai thực tế

- Trong quá trình thử nghiệm, AI ban đầu chưa xem xét đầy đủ sự khác biệt về môi trường thực thi, đặc biệt là vấn đề tương thích và xử lý dữ liệu giữa các môi trường vận hành.
- Điều này cho thấy một giải pháp không thể chỉ được đánh giá dựa trên tính hợp lý của ý tưởng hoặc kết quả trong môi trường thử nghiệm, mà còn phải xét đến tính ổn định, khả năng tương thích và điều kiện triển khai thực tế.

---

## 3. Cách tôi phản biện, sửa Prompt và thiết lập ranh giới

### 3.1. Điều chỉnh lại phạm vi và mục tiêu nghiệp vụ

- Yêu cầu AI quay lại đúng nội dung của Quick Problem Card #02, loại bỏ hướng phân tích lệch sang bài toán cứu hộ xe hết pin giữa đường.
- Làm rõ mục tiêu cốt lõi: dự báo nhu cầu sạc và tối ưu điều phối phương tiện, hạn chế tình trạng quá tải tại một số trạm trong khi các trạm khác chưa được khai thác hiệu quả.
- Yêu cầu phân biệt rõ giữa các công đoạn dự báo, kiểm tra ràng buộc, tối ưu phân bổ và hỗ trợ giao tiếp thay vì gộp tất cả vào một mô hình LLM.

### 3.2. Thiết lập ranh giới an toàn cho AI

- Quy định rõ AI chỉ được đưa ra đề xuất và tạo nội dung ở dạng bản nháp `[DRAFT_ONLY]`; không tự động thực hiện các quyết định vận hành quan trọng khi chưa được phê duyệt.
- Thiết lập các điều kiện an toàn đối với phương tiện có mức pin dưới ngưỡng cho phép:
  - Không đề xuất phương án di chuyển đến trạm sạc vượt quá giới hạn an toàn.
  - Chuyển sang quy trình xử lý khẩn cấp khi phương tiện không còn đủ điều kiện di chuyển.
  - Yêu cầu người vận hành xác nhận các trường hợp ngoại lệ.
- Nhấn mạnh rằng các ràng buộc an toàn phải được kiểm soát bằng những quy tắc xác định và có thể kiểm chứng, không phụ thuộc hoàn toàn vào nội dung do AI sinh ra.

### 3.3. Kiểm chứng kết quả và tính khả thi

- Không mặc định mọi đề xuất của AI đều chính xác; yêu cầu đối chiếu với mục tiêu nghiệp vụ và các điều kiện vận hành thực tế.
- Kiểm tra tính nhất quán giữa bài toán, dữ liệu đầu vào, phương pháp AI được lựa chọn và KPI đánh giá.
- Điều chỉnh kết quả khi phát hiện nội dung suy diễn, thiếu căn cứ hoặc không phù hợp với phạm vi đã xác định.
- Xem xét cả tính ổn định và khả năng hoạt động trong môi trường triển khai thực tế, thay vì chỉ đánh giá kết quả ở mức ý tưởng.

---

## 4. Bài học kinh nghiệm

### 4.1. Con người phải giữ quyền định hướng và quyết định (Human-in-the-loop)

AI là công cụ hỗ trợ phân tích và mở rộng khả năng xử lý thông tin, không phải nguồn quyết định tuyệt đối. Người thực hiện cần hiểu rõ nghiệp vụ, xác định đúng mục tiêu và chủ động phản biện khi AI đưa ra kết quả không phù hợp. Chất lượng đầu ra phụ thuộc đáng kể vào khả năng định hướng và kiểm chứng của con người.

### 4.2. Lựa chọn công nghệ dựa trên bản chất bài toán

Không phải bài toán nào cũng cần LLM. Việc lựa chọn công nghệ phải xuất phát từ yêu cầu nghiệp vụ:

- Bài toán có quy tắc rõ ràng: Rule Engine.
- Bài toán cần dự báo từ dữ liệu lịch sử: Predictive ML.
- Bài toán phân bổ nguồn lực với nhiều ràng buộc: Optimization.
- Bài toán xử lý ngôn ngữ và giao tiếp: LLM.

Một giải pháp AI hiệu quả không nằm ở số lượng mô hình được sử dụng, mà ở việc lựa chọn đúng công nghệ cho đúng công đoạn.

### 4.3. Ranh giới an toàn và khả năng kiểm soát là yêu cầu bắt buộc

Đối với các hệ thống vận hành thực tế như điều phối đội xe điện, sai sót có thể gây ảnh hưởng trực tiếp đến tài sản, con người và hoạt động kinh doanh. Vì vậy, cần thiết lập các giới hạn rõ ràng về quyền hạn của AI, các điều kiện không được phép vi phạm, cơ chế con người phê duyệt và phương án xử lý khi hệ thống gặp sự cố.

### 4.4. AI cần được đánh giá bằng giá trị thực tế, không chỉ bằng khả năng tạo ra câu trả lời

Một giải pháp AI chỉ thực sự có giá trị khi giải quyết được điểm nghẽn đã xác định và tạo ra cải thiện có thể đo lường. Các KPI như thời gian xử lý, độ chính xác dự báo, tỷ lệ sử dụng trạm và hiệu suất khai thác đội xe cần được theo dõi để đánh giá hiệu quả sau triển khai.

---

## KẾT LUẬN

Sử dụng AI hiệu quả không đơn thuần là biết cách đặt Prompt hay tận dụng các mô hình mạnh, mà quan trọng hơn là **biết xác định đúng vấn đề, lựa chọn đúng công nghệ, phản biện kết quả và thiết lập giới hạn cho AI**.

AI có thể giúp rút ngắn quá trình nghiên cứu, hệ thống hóa tư duy và đề xuất nhiều phương án giải quyết. Tuy nhiên, trách nhiệm xác định bài toán, kiểm chứng tính khả thi và đưa ra quyết định cuối cùng vẫn thuộc về con người.

Không nên bắt đầu bằng câu hỏi "Có thể dùng AI nào cho bài toán này?", mà nên bắt đầu bằng "Vấn đề thực sự cần giải quyết là gì, và công nghệ nào phù hợp nhất để giải quyết nó?".