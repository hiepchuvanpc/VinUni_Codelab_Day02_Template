# 📊 BÁO CÁO PHÂN TÍCH SÂU (DEEP-DIVE REPORT)
## Lab 02: AI Product Scoping

---

# 🗳️ 1. QUYẾT ĐỊNH LỰA CHỌN BÀI TOÁN TỪ QUICK CARDS

## 1.1. So sánh các bài toán đã khảo sát

Trong 3 thẻ bài toán được xây dựng tại Phase 2, nhóm tiến hành đánh giá dựa trên các tiêu chí: mức độ cấp thiết, khả năng ứng dụng AI, tính sẵn sàng của dữ liệu, rủi ro vận hành và khả năng triển khai thử nghiệm (MVP).

| Bài toán | Tiềm năng | Hạn chế / Rủi ro | Đánh giá |
|---|---|---|---|
| **Card #01 – Vinmec: Quản lý lịch khám** | Tối ưu lịch khám, phân bổ bác sĩ, phòng khám và thiết bị. | Liên quan trực tiếp đến quy trình y tế; yêu cầu dữ liệu chính xác, bảo mật và thẩm định nghiêm ngặt. | Chưa ưu tiên |
| **Card #02 – VinFast & Xanh SM: Điều phối sạc và xử lý sự cố pin** | Có tính thời gian thực; ảnh hưởng trực tiếp đến khả năng khai thác đội xe và doanh thu vận hành. | Phụ thuộc vào chất lượng dữ liệu GPS, SOC, tình trạng trạm sạc và khả năng tích hợp API. | **Được lựa chọn** |
| **Card #03 – Vinhomes: Phân loại phản ánh cư dân** | Có thể ứng dụng NLP/LLM để phân loại, tóm tắt và định tuyến phản ánh. | Một phần quy trình có thể giải quyết bằng Rule-based; cần dữ liệu lịch sử để xử lý tốt các trường hợp phức tạp. | Chưa ưu tiên |

## 1.2. Quyết định lựa chọn

**Lựa chọn Card #02: VinFast & Xanh SM – Tối ưu điều phối sạc và hỗ trợ xử lý sự cố pin thực địa.**

### Lý do lựa chọn

1. **Tính cấp thiết thời gian thực (Real-time Pain):**
   - Xe điện có mức pin thấp hoặc phải chờ sạc lâu sẽ làm gián đoạn hoạt động khai thác.
   - Tài xế mất thời gian tìm trạm sạc phù hợp, trong khi điều phối viên phải xử lý nhiều yêu cầu cùng lúc.
   - Thời gian xe ngừng hoạt động có thể làm giảm số lượng chuyến xe và hiệu suất khai thác đội xe.

2. **Tiềm năng khai thác dữ liệu (Data Opportunity):**
   - Các dữ liệu có thể khai thác bao gồm SOC (State of Charge), GPS, lịch sử di chuyển và thông tin dòng xe.
   - Dữ liệu trạm sạc có thể bao gồm vị trí, loại đầu sạc, công suất, trạng thái hoạt động và khả năng tiếp nhận.
   - Tuy nhiên, quyền truy cập, độ đầy đủ và khả năng tích hợp các nguồn dữ liệu này cần được xác minh trong giai đoạn Discovery.

3. **Ranh giới an toàn rõ ràng (Safety Boundary):**
   - Có thể phân chia trách nhiệm giữa Rule Engine, LLM và điều phối viên.
   - Rule Engine chịu trách nhiệm kiểm tra điều kiện vận hành và áp dụng các quy tắc an toàn.
   - LLM chỉ hỗ trợ tổng hợp thông tin và soạn thảo hướng dẫn.
   - Con người giữ quyền phê duyệt quyết định điều phối cuối cùng.

---

# 🏗️ 2. PHASE 3 — DEEP-DIVE

## 2.1. Current-State Workflow Mapping (Quy trình vận hành hiện tại)

### Bối cảnh vận hành

Khi xe taxi điện Xanh SM phát hiện mức pin thấp hoặc tài xế chủ động báo sự cố liên quan đến pin, điều phối viên cần xác định vị trí xe, kiểm tra các trạm sạc khả dụng và hướng dẫn tài xế di chuyển đến địa điểm phù hợp.

Quy trình dưới đây là **mô hình vận hành giả định phục vụ phân tích**, cần được xác minh thông qua phỏng vấn điều phối viên và khảo sát hệ thống thực tế.

### Quy trình xử lý thông thường

```text
┌────────────────────┐
│ BƯỚC 1             │
│ Tiếp nhận cảnh báo │
│ pin yếu từ tài xế  │
│                    │
│ Actor: Điều phối   │
│ ⏱ 2 phút           │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ BƯỚC 2             │
│ Xác định vị trí xe │
│ và mức pin hiện tại│
│                    │
│ Actor: Điều phối   │
│ ⏱ 3 phút           │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ BƯỚC 3             │
│ Tra cứu trạm sạc   │
│ phù hợp, kiểm tra  │
│ trạng thái và hàng │
│ chờ tại trạm       │
│                    │
│ Actor: Điều phối   │
│ ⏱ 8 phút           │
│ 🔴 BOTTLENECK      │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ BƯỚC 4             │
│ Soạn và gửi hướng  │
│ dẫn di chuyển cho  │
│ tài xế             │
│                    │
│ Actor: Điều phối   │
│ ⏱ 5 phút           │
│ 🔴 BOTTLENECK      │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Tài xế xác nhận    │
│ và di chuyển đến   │
│ trạm sạc           │
└────────────────────┘
```

### Luồng ngoại lệ: Cứu hộ khẩn cấp

```text
┌────────────────────┐
│ Phát hiện xe có    │
│ nguy cơ không thể  │
│ tiếp tục di chuyển│
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Đánh giá mức độ    │
│ an toàn và vị trí  │
│ phương tiện        │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Điều phối viên     │
│ kích hoạt quy trình│
│ cứu hộ phù hợp     │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Đội cứu hộ tiếp cận│
│ và hỗ trợ phương   │
│ tiện tại hiện trường│
└────────────────────┘
```

**Lưu ý:** Không mặc định mọi trường hợp SOC dưới 5% đều có thể hoặc phải sử dụng cùng một phương án cứu hộ. Quyết định cần xét thêm loại xe, tình trạng pin, khoảng cách, điều kiện giao thông và quy trình cứu hộ được phê duyệt.

### Phân tích Bottlenecks

| Vị trí | Bottleneck | Nguyên nhân | Hệ quả |
|---|---|---|---|
| Bước 3 | Tra cứu trạm sạc (8 phút) | Phải kiểm tra thủ công nhiều nguồn dữ liệu, trạng thái trạm, loại đầu sạc và hàng chờ. | Chậm đưa ra phương án phù hợp. |
| Bước 4 | Soạn hướng dẫn (5 phút) | Phải tổng hợp vị trí, tuyến đường, thông tin trạm và diễn đạt lại cho tài xế. | Tăng thời gian xử lý và nguy cơ sai sót. |
| Chuyển giao | Handoff thủ công | Thông tin được chuyển qua điện thoại, dashboard và ứng dụng tài xế. | Dễ thiếu thông tin, trùng lặp thao tác. |

**Tổng thời gian xử lý giả định:**

- Luồng thông thường: 2 + 3 + 8 + 5 = **18 phút/lượt**.
- Luồng có phát sinh cứu hộ: thời gian xử lý tăng thêm tùy thuộc vào quy trình và khả năng tiếp cận hiện trường.

Các con số trên là baseline giả định, cần đo bằng dữ liệu vận hành thực tế trước khi sử dụng làm KPI chính thức.

---

## 2.2. Problem Statement (6-field Standard)

| Trường thông tin | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Điều phối viên (Dispatcher) thuộc trung tâm điều vận Xanh SM (GSM). Tài xế là người tiếp nhận và thực hiện hướng dẫn. |
| **2. Current Workflow** | Khi tài xế báo pin yếu hoặc hệ thống phát hiện SOC thấp, điều phối viên tiếp nhận yêu cầu, xác định vị trí và tình trạng xe, tra cứu trạm sạc, kiểm tra khả năng tiếp nhận, sau đó gửi hướng dẫn. Nếu phương tiện không thể di chuyển an toàn, điều phối viên kích hoạt quy trình cứu hộ. |
| **3. Bottleneck** | Hai công đoạn tốn nhiều thời gian nhất là tra cứu và đánh giá trạm sạc (8 phút) và tổng hợp, soạn hướng dẫn cho tài xế (5 phút). Việc phải đối chiếu thủ công nhiều nguồn dữ liệu khiến quá trình xử lý chậm và có nguy cơ sai sót. |
| **4. Business Impact** | Thời gian xe ngừng khai thác tăng, giảm số chuyến có thể thực hiện, ảnh hưởng đến doanh thu và trải nghiệm tài xế/khách hàng. Đồng thời, điều phối viên phải dành nhiều thời gian cho các thao tác tra cứu và tổng hợp lặp lại. Quy mô ảnh hưởng cần được định lượng bằng dữ liệu lịch sử. |
| **5. Success Metric** | **Thời gian xử lý:** Giảm thời gian từ lúc tiếp nhận yêu cầu đến khi có phương án được phê duyệt. Mục tiêu thử nghiệm: từ baseline giả định 18 phút xuống dưới 3 phút. **Độ chính xác:** Tỷ lệ đề xuất trạm đáp ứng đồng thời điều kiện tương thích, khả năng tiếp nhận và tính khả thi của tuyến đường. Mục tiêu đề xuất: ≥ 96%. **An toàn:** Không có trường hợp hệ thống tự động đưa ra chỉ dẫn vi phạm các quy tắc an toàn đã được phê duyệt. |
| **6. Operational Boundary** | AI được phép đọc dữ liệu đã được cấp quyền, đánh giá và xếp hạng trạm sạc, tạo bản nháp hướng dẫn. AI không được tự ý gửi chỉ dẫn, tự quyết định cứu hộ hoặc bỏ qua các quy tắc an toàn. Điều phối viên có quyền phê duyệt, chỉnh sửa hoặc từ chối đề xuất. |

### Phân biệt giả định và dữ liệu thực tế

Để tránh biến các con số minh họa thành kết luận không có căn cứ, nhóm cần xác minh:

- Số lượt yêu cầu hỗ trợ sạc mỗi ngày.
- Thời gian xử lý trung bình và phân phối thời gian xử lý theo từng công đoạn.
- Tỷ lệ xe phải chờ sạc, đi sai trạm hoặc cần cứu hộ.
- Thời gian xe ngừng khai thác do vấn đề liên quan đến pin.
- Mức độ đầy đủ và độ trễ của dữ liệu trạng thái trạm sạc.

---

## 2.3. Future-State Flow & AI Fit

### 2.3.1. Đánh giá mức độ phù hợp của AI

**Giải pháp đề xuất: Hybrid AI System – Rule Engine + LLM + Human-in-the-loop.**

Không sử dụng Autonomous Agent hoàn toàn vì bài toán liên quan đến điều phối phương tiện ngoài thực địa, có rủi ro an toàn và cần khả năng kiểm soát quyết định.

| Thành phần | Vai trò | Lý do sử dụng |
|---|---|---|
| **Rule Engine** | Kiểm tra SOC, điều kiện an toàn, khả năng tương thích và các ngưỡng kích hoạt quy trình cứu hộ. | Logic rõ ràng, kết quả có thể kiểm thử và dự đoán được. |
| **Optimization / Ranking Engine** | Lọc và xếp hạng trạm sạc theo khoảng cách, khả năng tiếp nhận, công suất, tương thích và thời gian chờ. | Phù hợp với bài toán tối ưu hóa có nhiều ràng buộc. |
| **LLM Feature** | Tổng hợp thông tin và tạo bản nháp hướng dẫn cho tài xế bằng ngôn ngữ tự nhiên. | Giảm thao tác soạn thảo lặp lại và cải thiện khả năng truyền đạt. |
| **Human-in-the-loop** | Điều phối viên kiểm tra, chỉnh sửa và phê duyệt phương án. | Đảm bảo trách nhiệm vận hành và kiểm soát các trường hợp ngoại lệ. |

### 2.3.2. Future-State Workflow

```text
┌──────────────────────────┐
│ BƯỚC 1                   │
│ Nhận cảnh báo pin yếu    │
│ từ xe / tài xế qua hệ    │
│ thống tích hợp           │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ BƯỚC 2                   │
│ RULE ENGINE              │
│                          │
│ - Kiểm tra SOC và GPS    │
│ - Kiểm tra chất lượng    │
│   và độ mới dữ liệu      │
│ - Đánh giá điều kiện     │
│   an toàn                │
│ - Phân nhánh cứu hộ      │
│   nếu cần                │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ BƯỚC 3                   │
│ RANKING / OPTIMIZATION   │
│                          │
│ - Lọc trạm tương thích   │
│ - Kiểm tra trạng thái    │
│ - Ước lượng thời gian    │
│   di chuyển và chờ       │
│ - Xếp hạng phương án     │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ BƯỚC 4                   │
│ AI DRAFT SERVICE (LLM)   │
│                          │
│ - Nhận dữ liệu đã kiểm   │
│   chứng từ hệ thống      │
│ - Soạn hướng dẫn         │
│ - Gắn tag [DRAFT_ONLY]   │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ BƯỚC 5                   │
│ HUMAN-IN-THE-LOOP        │
│                          │
│ - Điều phối viên review  │
│ - Chỉnh sửa nếu cần      │
│ - Phê duyệt hoặc từ chối │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ BƯỚC 6                   │
│ Gửi hướng dẫn qua App    │
│ tài xế sau khi được      │
│ phê duyệt                │
└──────────────────────────┘
```

### 2.3.3. Luồng xử lý ngoại lệ và Fallback

```text
                 ┌──────────────────┐
                 │ Nhận yêu cầu hỗ  │
                 │ trợ pin yếu      │
                 └────────┬─────────┘
                          │
                          ▼
                 ┌──────────────────┐
                 │ Rule Engine kiểm │
                 │ tra điều kiện    │
                 └────────┬─────────┘
                          │
              ┌───────────┴───────────┐
              │                       │
              ▼                       ▼
     ┌────────────────┐      ┌──────────────────┐
     │ Đủ điều kiện   │      │ Không an toàn /  │
     │ đến trạm sạc   │      │ cần cứu hộ       │
     └───────┬────────┘      └────────┬─────────┘
             │                        │
             ▼                        ▼
     ┌────────────────┐      ┌──────────────────┐
     │ Tìm và xếp hạng│      │ Chuyển điều phối │
     │ trạm sạc       │      │ viên xử lý cứu hộ│
     └───────┬────────┘      └──────────────────┘
             │
             ▼
     ┌────────────────┐
     │ LLM tạo bản    │
     │ nháp hướng dẫn │
     └───────┬────────┘
             │
             ▼
     ┌────────────────┐
     │ Kiểm tra đầu ra│
     │ và dữ liệu     │
     └───────┬────────┘
             │
        ┌────┴─────┐
        │          │
        ▼          ▼
     Hợp lệ     Không hợp lệ
        │          │
        ▼          ▼
     Điều phối  Fallback về
     viên duyệt xử lý thủ công
```

### 2.3.4. Quy tắc an toàn và Operational Guardrails

**Nguyên tắc quan trọng: Rule Engine có quyền ưu tiên cao hơn đầu ra của LLM.**

| Điều kiện | Hành động hệ thống |
|---|---|
| SOC thấp nhưng vẫn đủ điều kiện di chuyển an toàn | Tìm kiếm và xếp hạng trạm phù hợp. |
| SOC thấp và khoảng cách đến trạm vượt quá ngưỡng an toàn | Không đề xuất trạm đó; chuyển điều phối viên đánh giá phương án cứu hộ. |
| SOC dưới ngưỡng khẩn cấp được phê duyệt | Kích hoạt quy trình cảnh báo và đánh giá cứu hộ theo SOP. |
| Dữ liệu GPS hoặc SOC không hợp lệ / quá cũ | Không đưa ra chỉ dẫn di chuyển dựa trên dữ liệu không đáng tin cậy. |
| API trạm sạc lỗi hoặc không có dữ liệu trạng thái | Không khẳng định trạm còn chỗ; chuyển sang xác minh thủ công. |
| LLM timeout hoặc đầu ra không đúng cấu trúc | Không sử dụng bản nháp; chuyển điều phối viên xử lý thủ công. |
| LLM tạo nội dung trái với dữ liệu đã xác minh | Loại bỏ đầu ra và yêu cầu tạo lại hoặc fallback. |
| Điều phối viên chưa phê duyệt | Không gửi chỉ dẫn cho tài xế. |

**Đối với điều kiện SOC dưới 5%:** Có thể sử dụng làm ngưỡng cảnh báo ban đầu trong mô hình thử nghiệm, nhưng không được coi đây là ngưỡng an toàn phổ quát cho mọi dòng xe và điều kiện vận hành. Ngưỡng cuối cùng phải được chuyên gia kỹ thuật và bộ phận vận hành phê duyệt.

### 2.3.5. Phân công trách nhiệm giữa các thành phần

| Thành phần | Được phép | Không được phép |
|---|---|---|
| Rule Engine | Kiểm tra điều kiện, áp dụng quy tắc, kích hoạt cảnh báo và phân nhánh quy trình. | Tự thay đổi quy tắc an toàn khi chưa được phê duyệt. |
| Ranking Engine | Tìm kiếm, lọc và xếp hạng các trạm sạc khả dụng. | Đề xuất trạm không đáp ứng ràng buộc bắt buộc. |
| LLM | Tóm tắt, giải thích và soạn thảo hướng dẫn dựa trên dữ liệu đã xác minh. | Tự tạo trạng thái trạm, tự quyết định cứu hộ hoặc tự gửi chỉ dẫn. |
| Điều phối viên | Xác nhận, chỉnh sửa, phê duyệt và xử lý ngoại lệ. | Bỏ qua quy trình an toàn đã được quy định. |

---

## 2.4. Data Requirements & Feasibility Assessment

Để hệ thống hoạt động đáng tin cậy, cần xác định các nguồn dữ liệu đầu vào.

| Nhóm dữ liệu | Trường dữ liệu cần thiết | Mục đích |
|---|---|---|
| Vehicle Telemetry | Vehicle ID, SOC, dòng xe, thời điểm cập nhật. | Xác định trạng thái pin và loại phương tiện. |
| GPS / Location | Latitude, Longitude, timestamp. | Xác định vị trí xe và ước lượng tuyến đường. |
| Charging Station | Station ID, vị trí, loại đầu sạc, công suất. | Lọc các trạm tương thích. |
| Station Availability | Trạng thái trụ, hàng chờ, số lượng cổng khả dụng, thời điểm cập nhật. | Đánh giá khả năng tiếp nhận. |
| Road / Routing | Khoảng cách, thời gian di chuyển, tình trạng giao thông. | Đánh giá tính khả thi của phương án. |
| Vehicle Compatibility | Dòng xe, chuẩn sạc, giới hạn công suất và điều kiện tương thích. | Tránh đề xuất trạm không phù hợp. |
| Historical Operations | Lịch sử sự cố, thời gian xử lý, kết quả điều phối. | Đánh giá hiệu quả và cải thiện mô hình. |

### Các điều kiện cần xác minh trước khi triển khai

- Có được quyền truy cập dữ liệu telemetry và GPS theo thời gian thực hay không?
- API trạm sạc có cung cấp trạng thái từng trụ sạc và hàng chờ hay không?
- Dữ liệu trạng thái trạm được cập nhật với độ trễ bao nhiêu?
- Có API định tuyến để ước lượng thời gian di chuyển hay không?
- Dữ liệu lịch sử có đủ để đo baseline và đánh giá hiệu quả hay không?
- Cơ chế phân quyền, bảo mật và lưu trữ dữ liệu vị trí phương tiện được triển khai như thế nào?

**Đánh giá sơ bộ:** Bài toán có tiềm năng triển khai nếu các nguồn dữ liệu cốt lõi được cấp quyền và có độ tin cậy phù hợp. Nếu dữ liệu trạng thái trạm sạc không đủ chính xác, hệ thống cần cơ chế xác minh bổ sung thay vì mặc định trạm đang trống.

---

## 2.5. Success Metrics & Evaluation Framework

Các KPI cần phản ánh đồng thời hiệu quả vận hành, chất lượng đề xuất và độ an toàn.

| Nhóm KPI | Chỉ số | Baseline | Target đề xuất |
|---|---|---|---|
| Efficiency | Thời gian từ tiếp nhận đến có phương án được phê duyệt | 18 phút (giả định) | Dưới 3 phút |
| Efficiency | Thời gian tra cứu và tổng hợp thông tin | 13 phút (giả định) | Giảm tối thiểu 70% |
| Accuracy | Tỷ lệ đề xuất trạm đáp ứng đầy đủ điều kiện | Cần đo thực tế | ≥ 96% |
| Reliability | Tỷ lệ dữ liệu trạng thái trạm còn mới tại thời điểm đề xuất | Cần đo thực tế | Đặt ngưỡng theo SLA dữ liệu |
| Safety | Số chỉ dẫn vi phạm quy tắc an toàn | Cần đo thực tế | 0 |
| Adoption | Tỷ lệ đề xuất được điều phối viên chấp nhận | Chưa có | Theo dõi trong pilot |
| Business Impact | Thời gian xe ngừng khai thác do vấn đề sạc | Cần đo thực tế | Giảm so với nhóm đối chứng |

### Định nghĩa KPI quan trọng

**1. Thời gian xử lý (Handling Time)**

Thời gian từ lúc hệ thống tiếp nhận yêu cầu hỗ trợ đến lúc điều phối viên có phương án được phê duyệt.

**2. Độ chính xác đề xuất trạm (Station Recommendation Accuracy)**

Một đề xuất được xem là chính xác khi:

- Trạm hỗ trợ phương tiện và chuẩn sạc tương thích.
- Trạng thái trạm được xác minh là có khả năng tiếp nhận.
- Thông tin vị trí và tuyến đường hợp lệ.
- Không vi phạm các ràng buộc an toàn.
- Điều kiện tiếp nhận được đánh giá tại thời điểm tài xế đến, không chỉ tại thời điểm hệ thống đưa ra đề xuất.

**3. Safety Violation Rate**

Tỷ lệ đề xuất vi phạm các ràng buộc an toàn đã được phê duyệt.

Mục tiêu: 0 vi phạm được hệ thống đưa đến bước gửi chỉ dẫn.

---

## 2.6. MVP Scope & Implementation Roadmap

Để tránh triển khai quá rộng ngay từ đầu, nên chia dự án thành các giai đoạn.

### MVP – Phiên bản thử nghiệm đầu tiên

**In Scope:**

- Nhận dữ liệu SOC, GPS và dòng xe.
- Tra cứu danh sách trạm sạc.
- Kiểm tra khả năng tương thích.
- Lọc và xếp hạng các trạm theo khoảng cách và khả năng tiếp nhận.
- Sử dụng LLM tạo bản nháp hướng dẫn.
- Hiển thị kết quả cho điều phối viên phê duyệt.
- Ghi nhận quyết định và kết quả xử lý.

**Out of Scope:**

- Tự động điều khiển phương tiện.
- Tự động gửi chỉ dẫn khi chưa được phê duyệt.
- Tự động phát lệnh cứu hộ.
- Dự báo nhu cầu sạc trên toàn bộ mạng lưới.
- Tối ưu đồng thời lịch sạc và phân bổ toàn bộ đội xe.
- Thay thế hệ thống điều vận hiện có.

### Lộ trình triển khai

| Giai đoạn | Công việc | Kết quả |
|---|---|---|
| Phase 1 – Discovery | Phỏng vấn điều phối viên, khảo sát quy trình, xác minh dữ liệu và API. | Baseline và yêu cầu nghiệp vụ được xác nhận. |
| Phase 2 – Prototype | Xây dựng Rule Engine, Ranking Engine và giao diện đề xuất. | Prototype có thể kiểm thử bằng dữ liệu mẫu. |
| Phase 3 – MVP | Tích hợp LLM để tạo bản nháp và cơ chế HITL. | Hệ thống hỗ trợ điều phối viên. |
| Phase 4 – Pilot | Thử nghiệm trên phạm vi đội xe và khu vực giới hạn. | Đánh giá KPI và rủi ro thực tế. |
| Phase 5 – Scale | Mở rộng khi kết quả pilot đáp ứng yêu cầu. | Triển khai trên quy mô lớn hơn. |

---

# 🎯 3. KẾT LUẬN & ĐỀ XUẤT

## 3.1. Kết luận

Bài toán tối ưu điều phối sạc và hỗ trợ xử lý sự cố pin cho đội xe điện VinFast & Xanh SM có tiềm năng ứng dụng AI vì liên quan đến nhiều thao tác tra cứu, tổng hợp và ra quyết định lặp lại trong môi trường vận hành thời gian thực.

Giải pháp phù hợp không phải là để một LLM tự quyết định toàn bộ quy trình, mà là kết hợp:

- **Rule Engine:** Đảm bảo logic nghiệp vụ và các ràng buộc an toàn.
- **Optimization / Ranking Engine:** Tìm kiếm và xếp hạng phương án sạc phù hợp.
- **LLM:** Tự động hóa việc tổng hợp thông tin và soạn thảo hướng dẫn.
- **Human-in-the-loop:** Đảm bảo quyết định cuối cùng được kiểm soát bởi con người.

## 3.2. Đề xuất triển khai

Ưu tiên xây dựng MVP với phạm vi hẹp: hỗ trợ điều phối viên tìm trạm sạc phù hợp và tạo bản nháp hướng dẫn.

Chỉ tiến tới mở rộng tự động hóa khi hệ thống đã chứng minh được:

1. Dữ liệu đầu vào đủ chính xác và cập nhật.
2. Các đề xuất đáp ứng đầy đủ ràng buộc nghiệp vụ.
3. Thời gian xử lý giảm rõ rệt so với baseline.
4. Không phát sinh vi phạm các quy tắc an toàn.
5. Điều phối viên thực sự sử dụng và tin tưởng kết quả đề xuất.

**Định hướng cuối cùng: AI không thay thế điều phối viên mà giúp điều phối viên đưa ra quyết định nhanh hơn, có căn cứ hơn và nhất quán hơn.**