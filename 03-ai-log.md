# 📝 Nhật Ký Tương Tác AI & Tự Luận Phản Ánh (AI Log & Reflection)
**Học viên thực hiện:** Nguyễn Thanh Liêm  
**Branch cá nhân:** `Nguyễn-Thanh-Liêm`  
**Bài Lab:** Lab 02 — AI Product Scoping (Vin Smart Future)  
**Mô hình trợ lý AI sử dụng:** Antigravity (Google DeepMind Agentic Assistant) & Ollama Cloud (`gpt-oss:20b`)

---

## 🏛️ 1. Giới thiệu tổng quan

Trong buổi thực hành Lab 02 về **AI Product Scoping tại Vin Smart Future**, tôi đã sử dụng AI đóng vai trò như một **Kỹ sư AI đồng hành (AI Thought-Partner / Junior Co-pilot)**. Mục tiêu không phải là để AI làm hộ từ đầu đến cuối một cách thụ động, mà là áp dụng mô hình **Human-in-the-loop (HITL)**: Tôi đóng vai trò **Lead Architect / Product Owner** đưa ra định hướng, thẩm định ranh giới và kiểm soát chất lượng, còn AI đóng vai trò **Kỹ sư thực thi tốc độ cao** hỗ trợ tìm kiếm, tổng hợp dữ liệu, phác thảo báo cáo và viết boilerplate code.

---

## ⚖️ 2. Bảng phân định công việc: Tôi làm gì vs AI làm gì? (Task Allocation)

Để đảm bảo dự án đi đúng hướng, tôi đã phân chia ranh giới công việc cực kỳ minh bạch giữa con người và AI xuyên suốt 6 Phase của bài lab:

| Giai đoạn bài Lab | Công việc giao cho AI Agent thực hiện (Execution) | Công việc tôi trực tiếp kiểm tra, phản biện & quyết định (HITL) |
|---|---|---|
| **Phase 1: SCAN cơ hội** | • Quét và giải thích khái niệm 4 Lenses trong bài lab.<br>• Brainstorm danh sách các bài toán vận hành thực tế tại Vingroup (Xanh SM, Vinhomes, VinFast, Vinmec, Vinpearl). | • **Thẩm định & chọn lọc:** Trực tiếp chọn 3 bài toán trọng tâm (Xanh SM, Vinhomes, Vinpearl) và yêu cầu AI bổ sung thêm 2 bài toán (VinFast, Vinmec) để bao phủ trọn vẹn đủ cả 4 Lenses.<br>• Quyết định lưu bảng chính thức vào `01-problem-scan.md`. |
| **Quản lý Git & Branching** | • Chạy lệnh kiểm tra remote branches, hỗ trợ cấu hình Git user/email và đồng bộ code lên GitHub. | • **Can thiệp chặn lỗi nghiêm trọng:** Khi AI chuẩn bị tạo nhánh `liemnt` và push, tôi lập tức từ chối quyền thực thi (`Permission Denied`) và nhắc nhở AI rằng trên repo GitHub đã có sẵn nhánh tiếng Việt `Nguyễn-Thanh-Liêm`.<br>• Cung cấp định danh cá nhân chính xác (`liemt0165@gmail.com`). |
| **Bảo vệ tài liệu gốc** | • Hỗ trợ chỉnh sửa và lưu trữ tài liệu. | • **Thiết lập ranh giới phạm vi (Scope Boundary):** Phát hiện AI điền nội dung vào file đề bài `01-worksheet.md`. Tôi ra chỉ thị nghiêm ngặt: *"Không được sửa trong worksheet, deliverable-example, inspiration-kit"*, buộc AI phải hoàn nguyên file gốc và chỉ làm việc trên các file nộp bài chính thức. |
| **Phase 2 & 3: Deep-Dive** | • Dự thảo 3 thẻ Quick Problem Cards.<br>• Xây dựng báo cáo Problem Statement 6-field, kịch bản tương lai Future-State Flow.<br>• Viết script sinh ảnh sơ đồ quy trình `04-workflow-diagram.png` và file `.pdf`. | • **Quyết định bài toán:** Chọn Card #1 (Xanh SM) vì tính chất vận hành thời gian thực và ranh giới an toàn pin sống còn.<br>• Yêu cầu AI bổ sung bản sơ đồ dạng text ASCII trực quan để chụp lại màn hình. |
| **Phase 4: Code Prototype** | • Viết code hoàn thiện `starter-code/prompt_prototype.py`.<br>• Soạn `SYSTEM_PROMPT` với 2 ranh giới an toàn và cơ chế fallback Gemini SDK. | • **Chỉ đạo kiến trúc mới:** Không dùng Gemini API mặc định mà yêu cầu chuyển sang dùng **Ollama Cloud** với mô hình mã nguồn mở **`gpt-oss:20b`**.<br>• Cung cấp API key riêng và nhắc nhở AI tạo file `.env` kèm cấu hình `.gitignore` để bảo mật tuyệt đối. |

---

## 🔍 3. Các điểm AI làm sai / hiểu nhầm và cách tôi can thiệp sửa chữa (Failure Modes & Human Corrections)

Quá trình làm việc với AI đã chứng minh rõ ràng: **Nếu không có sự giám sát của con người, AI rất dễ mắc các lỗi về ngữ cảnh và phạm vi.** Dưới đây là 3 tình huống thực tế tôi đã phải "bắt lỗi" và nắn chỉnh AI:

### ❌ Tình huống 1: Nhầm lẫn về nhánh Git (Branching Hallucination)
* **Lỗi của AI:** Dựa vào username local của máy tính (`liemt`), AI tự động tạo nhánh local tên là `liemnt` và chuẩn bị chạy lệnh `git push -u origin liemnt` lên GitHub.
* **Cách tôi phát hiện & xử lý:** Tôi thấy lệnh push này sẽ tạo ra một nhánh rác trên repository chung của nhóm. Tôi lập tức bấm **Từ chối (Deny)** và phản hồi: *"Khoan, trên repo có branch Nguyễn Thanh Liêm rồi mà"*. AI sau đó đã quét lại remote qua `git ls-remote`, phát hiện ra nhánh `refs/heads/Nguyễn-Thanh-Liêm`, đổi tên nhánh local và push chính xác vào nhánh chỉ định của nhóm.

### ❌ Tình huống 2: Vi phạm phạm vi chỉnh sửa file (Scope Creep)
* **Lỗi của AI:** AI tiện tay điền các bảng biểu của Phase 1 và Phase 2 thẳng vào file đề bài `01-worksheet.md`.
* **Cách tôi phát hiện & xử lý:** File `01-worksheet.md` là tài liệu template gốc của giảng viên, việc sửa vào file này sẽ gây xung đột khi nhóm merge code vào `main`. Tôi đã ra lệnh cứng rắn: *"Không cần sửa trong worksheet.md, deliverable example, inspiration kit"*. Tôi yêu cầu AI dùng `git checkout` để khôi phục hoàn toàn file gốc và chuyển toàn bộ bài làm sang đúng file nộp bài quy định là `01-problem-scan.md`.

### ❌ Tình huống 3: Rủi ro rò rỉ API Key và chuyển đổi nhà cung cấp mô hình
* **Yêu cầu kỹ thuật:** Thay vì dùng Gemini API theo template sẵn có, tôi muốn thử nghiệm mô hình mã nguồn mở **`gpt-oss:20b`** thông qua nền tảng **Ollama Cloud**.
* **Cách tôi giám sát:** Tôi chủ động cung cấp API Key nhưng yêu cầu rõ ràng: *"Tạo .env (nhớ thêm vào gitignore)"*. Tôi đã kiểm tra lại `git status` để chắc chắn rằng file `.env` hoàn toàn không bị Git theo dõi, bảo vệ an toàn thông tin trước khi commit mã nguồn lên GitHub. Đồng thời, tôi giám sát việc AI thiết lập `temperature = 0.0` để đảm bảo mô hình tuân thủ tuyệt đối ranh giới an toàn của VinFast / Xanh SM.

---
