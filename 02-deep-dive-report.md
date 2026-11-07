# PHASE 3 — DEEP-DIVE

## 3.1. CURRENT-STATE WORKFLOW MAPPING

### Quy trình hiện tại

```text
Cư dân gửi phản ánh
        |
        v
Nhân viên CSKH đọc nội dung
        |
        v
Xác định loại vấn đề và mức độ ưu tiên
        |
        v
Xác định bộ phận chịu trách nhiệm
        |
        v
Chuyển ticket đến đội xử lý
        |
        v
Theo dõi phản hồi
```

### Bottleneck

Bottleneck chính nằm ở bước:

- Đọc và hiểu nội dung phản ánh bằng ngôn ngữ tự nhiên.
- Phân biệt các category gần nhau.
- Xác định đúng bộ phận xử lý.
- Xử lý các ticket mơ hồ hoặc chứa nhiều vấn đề.

Các số liệu về thời gian xử lý cần được xác minh bằng dữ liệu vận hành thực tế trước khi sử dụng làm baseline chính thức.

---

## 3.2. PROBLEM STATEMENT — 6 FIELDS

| Field | Nội dung |
|---|---|
| **1. Actor / Operator** | Nhân viên CSKH và Ban quản lý vận hành tại các khu đô thị Vinhomes. |
| **2. Current Workflow** | Cư dân gửi phản ánh; nhân viên đọc nội dung, xác định loại vấn đề và chuyển ticket đến đội phụ trách. |
| **3. Bottleneck** | Phân loại nội dung tự do và xác định đúng bộ phận xử lý. Ticket mơ hồ hoặc có nhiều vấn đề dễ gây route sai. |
| **4. Business Impact** | Phân loại thủ công làm tăng thời gian phản hồi ban đầu và số lần handoff giữa các bộ phận. |
| **5. Success Metric** | Đo accuracy theo category, thời gian phản hồi, tỷ lệ ticket route đúng và tỷ lệ nhân viên chấp nhận đề xuất AI. |
| **6. Operational Boundary** | AI chỉ đề xuất category, priority và đội xử lý; không tự đóng ticket, cam kết thời gian xử lý hoặc đưa ra quyết định cuối cùng trong tình huống khẩn cấp. |

---

## 3.3. FUTURE-STATE FLOW & AI FIT

### AI Fit Matrix

**Giải pháp đề xuất: Rule + LLM Feature**

- **Rule:** Kiểm tra category hợp lệ, format dữ liệu và các điều kiện workflow.
- **LLM:** Hiểu nội dung phản ánh tự do, tóm tắt và đề xuất phân loại.
- **Human:** Review các trường hợp confidence thấp hoặc có dấu hiệu khẩn cấp.

### Vì sao không dùng Agentic Loop?

Workflow có cấu trúc tương đối cố định. Một agent tự trị có thể làm tăng độ phức tạp và rủi ro mà không tạo ra giá trị tương xứng.

### Future-State Flow

```text
Cư dân gửi phản ánh
        |
        v
AI đọc và phân tích nội dung
        |
        +--> Tóm tắt
        +--> Category
        +--> Priority
        +--> Confidence
        |
        v
Có đủ điều kiện để đề xuất?
       / \
     Có   Không / khẩn cấp
      |       |
      v       v
Nhân viên    HUMAN REVIEW
kiểm tra       |
      \       /
       v     v
   Rule-based routing
          |
          v
      Đội xử lý
```

### Fallback

Nếu AI không trả về output hợp lệ, confidence thấp hoặc phát hiện tín hiệu khẩn cấp, ticket sẽ không được tự động route mà chuyển sang quy trình review của con người.
