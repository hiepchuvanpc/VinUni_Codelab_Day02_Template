# Lab 02 — Worksheet: AI Product Scoping (Vin Smart Future)

---

## 🏛️ 1. Bối cảnh thực tế: Vin Smart Future (Vingroup)

**Vingroup** — Tập đoàn tư nhân lớn nhất Việt Nam — vừa sáp nhập toàn bộ các phòng ban công nghệ thuộc các công ty thành viên thành một đơn vị công nghệ thống nhất mang tên **Vin Smart Future**. 

Nhiệm vụ của **Vin Smart Future** là xây dựng các giải pháp AI, số hóa, và tự động hóa cốt lõi để nâng cao hiệu suất vận hành và trải nghiệm khách hàng xuyên suốt các công ty thành viên:
* 🚗 **VinFast:** Hệ thống xe điện thông minh (EV), trợ lý AI ảo trong xe, dự đoán bảo trì pin, và quản lý chuỗi cung ứng sản xuất.
* 🚕 **Xanh SM (GSM):** Vận hành đội xe taxi/xe máy điện thông minh, điều vận thông minh (Smart Dispatching), tối ưu hóa lộ trình di chuyển.
* 🏢 **Vinhomes:** Quản lý đô thị thông minh (Smart Cities), trợ lý cư dân thông minh, tối ưu hóa mức tiêu thụ năng lượng.
* 🏥 **Vinmec:** Y tế thông minh, chẩn đoán hình ảnh bằng AI, tối ưu hóa quản lý hồ sơ bệnh án.
* 🎢 **Vinpearl / VinWonders:** Trải nghiệm du lịch số hóa, quản lý phòng và luồng khách thông minh tại các khu vui chơi.

Trong buổi Lab hôm nay, nhóm của bạn sẽ đóng vai trò là **AI Product Engineer** tại **Vin Smart Future**, tiến hành tìm kiếm, scoping, phân tích độ khả thi, thiết lập ranh giới vận hành, và xây dựng một **bản mẫu kỹ thuật (prompt prototype)** cho một bài toán cụ thể thuộc một trong những mảng kinh doanh trên.

---

## 📊 2. Cơ cấu tính điểm bài lab

### 👥 Điểm nhóm (60 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **G1. Workflow Mapping** | 20 | Problem Deep-Dive | Vẽ chi tiết quy trình hiện tại: các bước, handoff, thời gian, bottleneck |
| **G2. Problem Statement** | 20 | Problem Deep-Dive | Problem Statement 6-field bám sát thực tế, metric có số và ranh giới rõ ràng |
| **G3. AI Fit & Future Flow** | 10 | Problem Deep-Dive | So sánh Rule vs LLM vs Agent, future flow có bước AI, ranh giới và Fallback |
| **G4. Decision Quality** | 10 | Problem Deep-Dive | Quyết định Go/Not Yet/No-Go trung thực và có chứng cứ rõ ràng |

### 👤 Điểm cá nhân (40 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **I1. Scan & Cards** | 15 | Quick Cards | Liệt kê 5 problems sử dụng 3 lenses, hoàn thiện 3 quick cards chất lượng |
| **I2. Prototyping** | 10 | 02-lab/ | Chạy thử nghiệm programmatic prompt prototype thành công |
| **I3. AI Log & Reflection** | 15 | 03-ai-log.md | Phản ánh trung thực về việc dùng AI làm thought-partner (giúp gì, sai gì, sửa gì) |

---

# 🚀 Phase 0 — worked Example: Xanh SM Intelligent Dispatcher (15 min)

*Giảng viên walk-through ví dụ thực tế từ Vin Smart Future để bạn hiểu rõ cách scoping một bài toán AI.*
Đọc chi tiết worked example tại file [02-deliverable-example.md](02-deliverable-example.md).

---

# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

Hãy sử dụng **4 Lenses** dưới đây để quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **ít nhất 5 bài toán/bottleneck** thực tế.

### 4 Lenses tìm bài toán AI cho Vingroup:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày. (Ví dụ: So khớp hóa đơn sạc điện tại VinFast, route lại chuyến taxi tại Xanh SM).
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên. (Ví dụ: Soạn thảo phản hồi đánh giá 1-star của cư dân Vinhomes).
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn. (Ví dụ: Chatbot CSKH Vinpearl hỗ trợ đặt vé vui chơi).
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn. (Ví dụ: Tài xế Xanh SM phàn nàn về việc hệ thống gợi ý điểm đón khách không chính xác).

> [!TIP]
> **🤖 AI Prompts — Partner brainstorm:**
> Hãy sử dụng prompt sau để brainstorm các bài toán thực tế nếu bạn chưa có ý tưởng:
> *"Tôi là AI Engineer tại Vin Smart Future (Vingroup). Tôi đang tìm kiếm các pain point vận hành cụ thể có thể tối ưu bằng AI cho mảng [Chọn một: VinFast / Xanh SM / Vinhomes / Vinmec]. Hãy gợi ý cho tôi 5 quy trình nghiệp vụ thủ công, tốn nhiều thời gian và gây rò rỉ hiệu suất kèm con số thống kê ước tính về tổn thất."*

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | Vinmec|Tốn thời gian (Time-consuming) |Nhập liệu và số hóa hồ sơ bệnh án thủ công. Mặc dù Vinmec đã ứng dụng AI (DrAid) để tóm tắt hồ sơ, nhưng khâu tiếp nhận, đối chiếu và nhập thông tin số liệu lên phần mềm quản lý (EHOS/OH) vẫn là công việc thủ công của nhân viên hồ sơ bệnh án và thư ký y khoa. Quy trình này lặp lại với mỗi bệnh nhân và tiềm ẩn sai sót do nhập tay, ảnh hưởng đến tính liên tục của dữ liệu điều trị. |
| 2 |Xanh SM | Pain từ người khác (Stakeholder Pain)|Tài xế phàn nàn về điểm đón không chính xác và thay đổi liên tục. Hệ thống gợi ý điểm đón đôi khi không khớp với vị trí thực tế của khách, hoặc khách thay đổi điểm đón sau khi tài xế đã nhận chuyến, khiến tài xế phải mất thời gian liên hệ, điều chỉnh lộ trình hoặc thậm chí di chuyển đến điểm cũ. Green SM đã phải bổ sung tính năng cập nhật điểm đón và trợ lý AI để hỗ trợ tài xế, cho thấy đây là điểm đau vận hành thực sự |
| 3 |VinFast |Lặp lại (Repetitive) |Kiểm tra chất lượng (QC) và đánh dấu bu-lông thủ công trên dây chuyền lắp ráp. Dù mức độ tự động hóa rất cao, một số khâu vẫn cần công nhân thực hiện thủ công, điển hình là việc siết và đánh dấu sơn lên các bu-lông đã được vặn chặt để xác nhận chất lượng. Đây là tác vụ lặp đi lặp lại với số lượng lớn trên mỗi xe, tiêu tốn thời gian và nhân lực, đồng thời phụ thuộc vào độ chính xác của con người |
| 4 |Vinhomes | AI có thể tốt hơn (AI-upgrade)|Xử lý và phân loại phản ánh của cư dân qua ứng dụng và tổng đài. Vinhomes Resident App có lượng tương tác rất lớn (228.000 tài khoản, 97% hộ dùng hàng tháng), tạo ra dòng phản ánh, yêu cầu dịch vụ và sự cố liên tục. Việc phân loại, ưu tiên và điều phối các yêu cầu này đến đúng bộ phận (kỹ thuật, vệ sinh, an ninh) hiện vẫn dựa nhiều vào quy trình thủ công. AI có thể tự động phân loại, trích xuất thông tin và gợi ý hướng xử lý ngay từ đầu, giảm thời gian chờ đợi cho cư dân và giảm tải cho ban quản lý |
| 5 |Vinpearl | Tốn thời gian (Time-consuming)| Xử lý khiếu nại và hoàn tiền đa kênh theo quy trình tuần tự. Quy trình giải quyết khiếu nại của Vinpearl yêu cầu chuyển thông tin qua nhiều bộ phận (CSKH, Sales, Bộ phận liên quan) và có thể mất đến 7 ngày để phản hồi. Việc này gây chậm trễ trong trải nghiệm khách hàng và tạo áp lực lên nhân viên CSKH trong việc theo dõi, đối chiếu trạng thái xử lý giữa các hệ thống|

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #___                                     │
│                                                             │
│ Bài toán (1 câu): Tóm tắt và trích xuất dữ liệu từ hồ sơ    │
│ bệnh án điện tử (EMR) thủ công cho mỗi ca bệnh, đặc biệt    │
│ trong hội chẩn đa chuyên khoa, đang ngốn thời gian bác sĩ   │
│ và thư ký y khoa.                                           │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [X] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Bác sĩ điều trị, bác sĩ hội chẩn, thư  │
│ ký y khoa tại Vinmec Times City (và các cơ sở khác)         │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Bác sĩ mở từng tab/file EMR để đọc dữ liệu lâm sàng    │
│      và kết quả xét nghiệm ──>                              │
│   2. Tự tổng hợp, gõ lại thông tin vào báo cáo hội chẩn     │
│      hoặc phiếu tóm tắt ──>                                 │
│   3. Đối chiếu chéo giữa các nguồn (xét nghiệm, hình ảnh,   │
│      ghi chú điều dưỡng) ──>                                │
│   4. Copy/paste vào mẫu báo cáo cuối cùng ──>               │
│   5. Kiểm tra lại thủ công trước khi trình hội đồng         │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 1 và 2 (Ước tính: ~5 phút/lần tóm tắt hồ sơ cơ bản;     │
│ ~60 phút cho một ca hội chẩn khó trước đây)                 │
│ AI có thể nhảy vào hỗ trợ ở bước nào?Bước 2-3: tự động      │
│ trích xuất, tóm tắt và cấu trúc dữ liệu từ EMR; gợi ý báo   │
│ cáo nháp để bác sĩ chỉ cần review và duyệt                  │
│                                                             │
│ Đo thành công bằng gì (Metric có số)? 
│        Giảm thời gian tóm tắt hồ sơ từ 5 phút → dưới 1 phút │
│ • Giảm thời gian tổng hợp báo cáo hội chẩn từ 60 phút →    │
│   dưới 10 phút                                              │
│ • Giảm thời gian tìm kiếm thông tin bệnh nhân từ 3 phút →  │
│   dưới 10 giây    
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent 
│ (LLM/extraction pipeline đọc EMR có cấu trúc + tóm tắt;     │
│  human-in-the-loop bắt buộc trước khi dùng cho lâm sàng.)   │
└─────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **🤖 AI Prompts — Stress-Test thẻ bài toán:**
> Hãy dán nội dung thẻ bài toán của bạn vào LLM để nhận phản biện:
> *"Đây là một thẻ bài toán vận hành tôi đề xuất cho Vin Smart Future: [Dán nội dung]. Hãy đóng vai trò là một CFO và Trưởng phòng Vận hành cực kỳ khắt khe, chỉ ra cho tôi 3 điểm yếu về logic, metric, và giải thích vì sao rule-based code thông thường có thể giải quyết bài toán này tốt hơn là dùng AI."*

---

# 🏗️ Phase 3 — DEEP-DIVE (Nhóm, 85 min)

## 3.1. Current-State Workflow Mapping (25 min)
**Vẽ quy trình hiện tại lên bảng/giấy A3.** Sử dụng các ký hiệu:
* 🔴 **Bottleneck:** Bước gây tắc nghẽn, tốn thời gian, hoặc sai sót nhiều nhất.
* 🔄 **Handoff:** Điểm chuyển giao thông tin giữa người và hệ thống, hoặc giữa các bộ phận.
* Ghi rõ thời gian vận hành trung bình: **Tổng cộng = ____ phút/lượt**.

## 3.2. Problem Statement (6-field) & Metrics (15 min)
Điền đầy đủ 6 trường thông tin của bài toán:

| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Ai đang thực hiện tác vụ hằng ngày? |
| **2. Current Workflow** | Mô tả tóm tắt quy trình thủ công hiện tại và công cụ sử dụng. |
| **3. Bottleneck** | Bước nào chậm, lỗi, hoặc cần xử lý ngôn ngữ tự động nhiều nhất? |
| **4. Business Impact** | Tổn thất thực tế đo bằng thời gian, chi phí, hoặc SLA của Vingroup. |
| **5. Success Metric** | AI giải quyết được thì đạt ngưỡng số mấy? (Ví dụ: *"85% vé được phân loại dưới 10s"*). |
| **6. Operational Boundary** | AI được phép làm gì, TUYỆT ĐỐI không được làm gì, điểm nào cần duyệt? |

## 3.3. Future-State Flow & AI Fit (25 min)
* **Xác định mức AI Fit (AI-Fit Matrix):** Giải pháp thuộc nhóm nào? [ ] Rule / State-Machine [ ] LLM Feature [ ] Agentic Loop.
* **Vẽ Future-State Flow:** Đánh dấu rõ:
  * 🔵 **AI Step:** Tác vụ LLM xử lý.
  * 🟢 **Human Step (HITL):** Bước con người phê duyệt/review (Human-in-the-loop).
  * ↩️ **Fallback:** Kế hoạch dự phòng khi LLM trả về kết quả lỗi hoặc không tự tin.

---

# 💻 Phase 4 — TECHNICAL PROMPT PROTOTYPE (Nhóm, 30 min)

Để đảm bảo kỹ sư của Vin Smart Future luôn giữ vững năng lực lập trình, nhóm của bạn sẽ tiến hành **lập trình bản mẫu prompt** trực tiếp trên **Gemini 2.5 Flash** bằng Python để stress-test hệ thống.

### Hướng dẫn thực hiện:
1. Mở file [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) bằng VS Code/Cursor.
2. Hoàn thiện các nội dung sau:
   * **System Prompt:** Viết chỉ thị cực kỳ nghiêm ngặt quy định vai trò, nhiệm vụ, định dạng output và **Operational Boundary (Ranh giới cấm)** của mô hình.
   * **Structured Output:** Định nghĩa định dạng JSON output rõ ràng.
   * **Adversarial Test Cases:** Viết ít nhất 3 prompts "tấn công" (Adversarial inputs) cố tình dụ AI vượt ranh giới hoặc đưa ra câu trả lời không được phép để kiểm tra xem ranh giới của bạn có thực sự vững chắc.
3. Chạy file python:
   ```bash
   python3 prompt_prototype.py
   ```
4. Kiểm tra xem các ranh giới an toàn có bị LLM phá vỡ hay không và ghi lại kết quả vào worksheet.

---

# 🏁 Phase 5 — EVALUATE (Nhóm, 20 min)

### AI Readiness Checklist:
1. [ ] Chúng tôi có sẵn dữ liệu mẫu/logs sạch để test?
2. [ ] Rủi ro khi AI sai có nằm trong tầm kiểm soát (qua HITL hoặc Fallback)?
3. [ ] Stakeholders sẵn sàng thay đổi quy trình làm việc cũ?

### Quyết định cuối cùng của Ban Giám Đốc Vin Smart Future:
[ ] **GO (Bắt đầu xây dựng Prototype):** Bắt đầu phát triển với scope hẹp.
[ ] **NOT YET (Cần tích lũy thêm dữ liệu/xác lập baseline):** Trì hoãn để chuẩn bị thêm.
[ ] **NO-GO (Không khả thi / Rule-based tốt hơn):** Hủy bỏ dự án AI này.

**Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):**
> *Viết lý giải chi tiết tại đây*

---

# 📝 Phase 6 — REFLECTION (Cá nhân)
*Ghi nhận phản ánh của cá nhân bạn về việc phối hợp với AI trong buổi học hôm nay vào file `03-ai-log.md`.*
