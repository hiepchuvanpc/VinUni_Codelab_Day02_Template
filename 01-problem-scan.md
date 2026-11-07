# 01 – Problem Scan (Phase 1: SCAN + Phase 2: QUICK-ASSESS)

## PHASE 1 – SCAN: Bảng quét cơ hội

| # | Công ty thành viên | Bài toán thực tế | Actor (ai đang đau) | Nỗi đau / tần suất | Dữ liệu sẵn có | AI có thể giúp gì |
|---|---|---|---|---|---|---|
| 1 | Vinmec | Tóm tắt & trích xuất dữ liệu từ hồ sơ bệnh án điện tử (EMR) thủ công, đặc biệt cho hội chẩn đa chuyên khoa | Bác sĩ điều trị, bác sĩ hội chẩn, thư ký y khoa | Mỗi ca bệnh, hằng ngày; hội chẩn khó tốn tới ~60 phút chuẩn bị | EMR, kết quả xét nghiệm, ghi chú điều dưỡng | LLM trích xuất + tóm tắt, tạo báo cáo nháp để bác sĩ duyệt |
| 2 | Xanh SM | Phân loại và xử lý khiếu nại/phản hồi của khách và tài xế (thất lạc đồ, tính sai cước, thái độ phục vụ) | Nhân viên CSKH, điều phối viên, tài xế | Hàng nghìn ticket/ngày; phân loại và điều tra thủ công chậm | Ticket, log chuyến đi, GPS, chat in-app | LLM phân loại + tóm tắt ticket, gợi ý hướng xử lý, truy xuất log liên quan |
| 3 | VinFast | Tra cứu tài liệu kỹ thuật/quy trình bảo hành cho kỹ thuật viên tại xưởng dịch vụ khi chẩn đoán lỗi | Kỹ thuật viên xưởng dịch vụ, cố vấn dịch vụ | Mỗi lượt sửa chữa; tài liệu dài, nhiều phiên bản, khó tìm | Sổ tay sửa chữa, bulletin kỹ thuật, lịch sử bảo hành, mã lỗi (DTC) | RAG trả lời theo mã lỗi/triệu chứng, trích dẫn nguồn, gợi ý các bước kiểm tra |
| 4 | Vinhomes | Tiếp nhận và điều phối yêu cầu/sự cố của cư dân (kỹ thuật, an ninh, tiện ích) qua nhiều kênh | Cư dân, ban quản lý tòa nhà, tổ kỹ thuật | Hàng trăm yêu cầu/ngày/dự án; phân loại sai, chuyển chậm, cư dân phải hỏi lại | Hotline, app cư dân, Zalo, lịch sử xử lý | LLM phân loại + gán đúng bộ phận + mức ưu tiên, trả lời trạng thái tự động |
| 5 | VinFast | Soạn và kiểm tra hợp đồng/biên bản đại lý và hồ sơ giao xe (đối chiếu thông tin khách, VIN, giá, khuyến mãi) | Nhân viên kinh doanh đại lý, bộ phận pháp lý/hành chính | Mỗi xe bán ra; sai sót dẫn đến làm lại hồ sơ | Hợp đồng mẫu, hệ thống CRM/DMS, chương trình khuyến mãi | LLM đối chiếu và highlight sai lệch, điền sẵn hồ sơ, human review |
| 6 | Vinhomes | Thẩm định nhanh hồ sơ pháp lý/bàn giao căn hộ (kiểm tra đủ giấy tờ, đối chiếu thông tin) | Nhân viên pháp lý, bộ phận bàn giao | Cao điểm bàn giao; hồ sơ giấy, kiểm tra thủ công | Hồ sơ scan, hợp đồng mua bán | OCR + LLM trích xuất trường, checklist tự động, cảnh báo thiếu/sai |
| 7 | Vinmec | Nhắc lịch và phân loại nhu cầu của người bệnh đặt khám (chọn chuyên khoa phù hợp theo triệu chứng) | Người bệnh, nhân viên tổng đài đặt lịch | Hằng ngày; đặt nhầm chuyên khoa, gọi lại nhiều lần | Lịch khám, danh mục chuyên khoa, lịch sử đặt khám | Chatbot phân luồng triệu chứng → chuyên khoa (không chẩn đoán), chuyển người khi nghi ngờ |

---

## PHASE 2 – QUICK-ASSESS: Chấm điểm nhanh

Thang điểm 1–5 (5 = tốt nhất). **Tổng = Đau + Dữ liệu + Khả thi AI + Đo được − Rủi ro** (rủi ro: 1 = thấp, 5 = cao).

| # | Bài toán (rút gọn) | Mức đau (1-5) | Dữ liệu sẵn (1-5) | Khả thi AI (1-5) | Đo được (1-5) | Rủi ro (1-5) | Tổng | Chọn? |
|---|---|---|---|---|---|---|---|---|
| 1 | Vinmec – Tóm tắt EMR/hội chẩn | 5 | 4 | 4 | 5 | 4 | **14** | ✅ Card #1 |
| 2 | Xanh SM – Phân loại & xử lý khiếu nại | 5 | 5 | 5 | 5 | 2 | **18** | ✅ Card #2 |
| 3 | VinFast – Trợ lý tra cứu kỹ thuật xưởng DV | 4 | 4 | 4 | 4 | 2 | **14** | ✅ Card #3 |
| 4 | Vinhomes – Điều phối yêu cầu cư dân | 4 | 4 | 4 | 4 | 2 | **14** | ❌ (gần giống #2 về bản chất) |
| 5 | VinFast – Kiểm tra hồ sơ/hợp đồng đại lý | 3 | 3 | 4 | 4 | 3 | **11** | ❌ |
| 6 | Vinhomes – Thẩm định hồ sơ bàn giao | 3 | 3 | 3 | 4 | 3 | **10** | ❌ |
| 7 | Vinmec – Phân luồng chuyên khoa | 3 | 3 | 4 | 3 | 4 | **9** | ❌ (rủi ro y tế cao, giá trị thấp hơn) |

**Lý do chọn 3 bài toán:** đa dạng ngành (y tế, mobility, ô tô), đều có nỗi đau rõ và lặp lại hằng ngày, có dữ liệu sẵn và metric đo được bằng số. Bài #4 (Vinhomes) để dự phòng vì cấu trúc tương tự #2.

---

## 3 QUICK PROBLEM CARDS

### QUICK PROBLEM CARD #1

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tóm tắt và trích xuất dữ liệu từ hồ sơ    │
│ bệnh án điện tử (EMR) thủ công cho mỗi ca bệnh, đặc biệt    │
│ trong hội chẩn đa chuyên khoa, đang ngốn thời gian bác sĩ   │
│ và thư ký y khoa.                                           │
│                                                             │
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
│ Bước nào tốn thời gian/lỗi nhất? Bước 1 và 2                │
│ (Ước tính: ~5 phút/lần tóm tắt hồ sơ cơ bản; ~60 phút cho   │
│ một ca hội chẩn khó)                                        │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-3: tự động     │
│ trích xuất, tóm tắt và cấu trúc dữ liệu từ EMR; gợi ý báo   │
│ cáo nháp để bác sĩ chỉ cần review và duyệt                  │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│  • Giảm thời gian tóm tắt hồ sơ từ 5 phút → dưới 1 phút     │
│  • Giảm thời gian tổng hợp báo cáo hội chẩn từ 60 phút →    │
│    dưới 10 phút                                             │
│  • Giảm thời gian tìm kiếm thông tin bệnh nhân từ 3 phút →  │
│    dưới 10 giây                                             │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (LLM/extraction pipeline đọc EMR có cấu trúc + tóm tắt;     │
│  human-in-the-loop bắt buộc trước khi dùng cho lâm sàng.)   │
└─────────────────────────────────────────────────────────────┘
```

### QUICK PROBLEM CARD #2

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Nhân viên CSKH Xanh SM phải đọc, phân     │
│ loại và điều tra thủ công hàng nghìn khiếu nại mỗi ngày     │
│ (thất lạc đồ, tính sai cước, thái độ tài xế), khiến thời    │
│ gian phản hồi chậm và dễ chuyển sai bộ phận.                │
│                                                             │
│ Công ty thành viên: [ ] VinFast  [X] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Nhân viên CSKH, điều phối viên vận     │
│ hành; gián tiếp là khách hàng và tài xế chờ phản hồi        │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Ticket đến từ app/hotline/mạng xã hội, nhân viên       │
│      đọc nội dung ──>                                       │
│   2. Phân loại loại khiếu nại + mức ưu tiên bằng tay ──>    │
│   3. Tra cứu log chuyến đi, GPS, cước phí trên các hệ       │
│      thống khác nhau ──>                                    │
│   4. Soạn phản hồi cho khách/tài xế, xin duyệt nếu cần ──>  │
│   5. Chuyển bộ phận liên quan (vận hành, đối tác) và theo   │
│      dõi đến khi đóng ticket                                │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 và 3                │
│ (Ước tính: ~4 phút phân loại + ~6 phút tra cứu log/ticket;  │
│ tỉ lệ chuyển sai bộ phận ~15%)                              │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-4: tự động     │
│ phân loại + gán mức ưu tiên, tóm tắt ticket kèm log chuyến  │
│ liên quan, soạn sẵn phản hồi nháp cho nhân viên duyệt       │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│  • Giảm thời gian xử lý mỗi ticket từ 10 phút → dưới 4 phút │
│  • Giảm tỉ lệ chuyển sai bộ phận từ 15% → dưới 5%           │
│  • Giảm thời gian phản hồi đầu tiên từ 30 phút → dưới 5     │
│    phút                                                     │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (LLM phân loại + tóm tắt + RAG trên chính sách; có thể mở   │
│  rộng thành Agent tra cứu log ở giai đoạn sau; nhân viên    │
│  vẫn duyệt phản hồi cuối.)                                  │
└─────────────────────────────────────────────────────────────┘
```

### QUICK PROBLEM CARD #3

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Kỹ thuật viên tại xưởng dịch vụ VinFast   │
│ mất nhiều thời gian lật tìm trong sổ tay sửa chữa, bulletin │
│ kỹ thuật và lịch sử bảo hành để chẩn đoán lỗi xe điện.      │
│                                                             │
│ Công ty thành viên: [X] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Kỹ thuật viên xưởng dịch vụ, cố vấn    │
│ dịch vụ; gián tiếp là chủ xe chờ xe lâu                     │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Đọc mã lỗi (DTC) và nghe mô tả triệu chứng từ khách ──>│
│   2. Tìm trong sổ tay sửa chữa/bulletin kỹ thuật (nhiều     │
│      file, nhiều phiên bản) ──>                             │
│   3. Xem lịch sử bảo hành/sửa chữa của xe ──>               │
│   4. Hỏi đồng nghiệp/chuyên gia hỗ trợ khi chưa chắc ──>    │
│   5. Thực hiện kiểm tra theo quy trình và ghi nhận kết quả  │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 và 4                │
│ (Ước tính: ~15-20 phút tra cứu mỗi ca chẩn đoán khó; hay    │
│ dùng nhầm phiên bản tài liệu)                               │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-4: trợ lý hỏi  │
│ đáp theo mã lỗi/triệu chứng, trả về các bước kiểm tra kèm   │
│ trích dẫn đúng tài liệu và phiên bản, kết hợp lịch sử xe    │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│  • Giảm thời gian tra cứu mỗi ca từ 15-20 phút → dưới 3     │
│    phút                                                     │
│  • Tăng tỉ lệ sửa đúng ngay lần đầu (first-time fix) thêm   │
│    10 điểm phần trăm                                        │
│  • Giảm số lượt hỏi chuyên gia hỗ trợ ≥ 30%                 │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
│ (RAG trên tài liệu kỹ thuật có version control, bắt buộc    │
│  trích dẫn nguồn; kỹ thuật viên quyết định cuối cùng.)      │
└─────────────────────────────────────────────────────────────┘
```