$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$bitmap = New-Object System.Drawing.Bitmap(1800, 1580)
$canvas = [System.Drawing.Graphics]::FromImage($bitmap)
$canvas.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$canvas.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$canvas.Clear([System.Drawing.ColorTranslator]::FromHtml('#F5F7FB'))
$titleFont = New-Object System.Drawing.Font('Segoe UI', 29, [System.Drawing.FontStyle]::Bold)
$headFont = New-Object System.Drawing.Font('Segoe UI', 22, [System.Drawing.FontStyle]::Bold)
$bodyFont = New-Object System.Drawing.Font('Segoe UI', 18)
$smallFont = New-Object System.Drawing.Font('Segoe UI', 16)
$ink = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#19324C'))
$muted = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#4E6073'))
$red = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#AA2534'))
$blue = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#17669A'))
$line = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#60809A'), 4)
$line.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$border = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#B9C8D8'), 2)
$redBorder = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#C94955'), 3)
$canvas.DrawString('VINHOMES | QUY TRÌNH HIỆN TẠI', $titleFont, $ink, 65, 40)
$canvas.DrawString('Phân loại và điều hướng phản ánh cư dân — mô phỏng một tòa nhà', $bodyFont, $muted, 68, 105)
$canvas.DrawString('Toàn bộ thời gian là GIẢ ĐỊNH của bài lab, chưa đo tại doanh nghiệp.', $smallFont, $red, 68, 152)
$steps = @(
    @('1. TIẾP NHẬN VÀ ĐỌC', 'Lễ tân | Hộp thư phản ánh', 'Văn bản cư dân  →  Phiếu mới', '1 phút', 'H1: Cư dân → lễ tân'),
    @('2. XÁC MINH VỊ TRÍ', 'Lễ tân | Thông tin phiên / hỏi lại', 'Phiếu mới  →  Tòa và vị trí được xác nhận', '2 phút', 'Xác minh quyền theo tòa'),
    @('3. PHÂN LOẠI, TRA BỘ PHẬN', 'Lễ tân | Danh mục lỗi và danh bạ', 'Mô tả tự do  →  Nhãn và bộ phận nhận', '3 phút', 'BOTTLENECK'),
    @('4. SOẠN VÀ CHUYỂN PHIẾU', 'Lễ tân | Biểu mẫu nội bộ', 'Nhãn sự cố  →  Phiếu chuyển đến bộ phận', '2 phút', 'H2: Lễ tân → bộ phận'),
    @('5. XÁC NHẬN TIẾP NHẬN', 'Kỹ thuật / An ninh / Vệ sinh / Trực ban', 'Phiếu chuyển  →  Xác nhận đã nhận', '2 phút', 'H3: Bộ phận → lễ tân')
)
for ($index = 0; $index -lt 5; $index++) {
    $y = 230 + $index * 230
    $isBottleneck = $index -eq 2 -or $index -eq 3
    $bgColor = if ($isBottleneck) { '#FFF0F1' } else { '#FFFFFF' }
    $bg = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($bgColor))
    $canvas.FillRectangle($bg, 70, $y, 1240, 185)
    $chosenBorder = if ($isBottleneck) { $redBorder } else { $border }
    $canvas.DrawRectangle($chosenBorder, 70, $y, 1240, 185)
    $canvas.DrawString($steps[$index][0], $headFont, $ink, 95, ($y + 14))
    $canvas.DrawString($steps[$index][1], $bodyFont, $muted, 95, ($y + 69))
    $canvas.DrawString($steps[$index][2], $bodyFont, $ink, 95, ($y + 119))
    $canvas.DrawString($steps[$index][3], $headFont, $blue, 1090, ($y + 20))
    $noteRect = New-Object System.Drawing.RectangleF(1350, ($y + 25), 390, 145)
    $canvas.DrawString($steps[$index][4], $bodyFont, $blue, $noteRect)
    if ($index -eq 3) {
        $canvas.DrawString('BOTTLENECK', $smallFont, $red, 1350, ($y + 133))
    }
    if ($index -lt 4) { $canvas.DrawLine($line, 690, ($y + 187), 690, ($y + 222)) }
    $bg.Dispose()
}
$canvas.DrawString('Tổng: 10 phút / lượt  |  Điểm nghẽn bước 3–4: 5 phút (50%)', $headFont, $ink, 70, 1405)
$canvas.DrawString('H1–H3: bàn giao thông tin. Chuyển sai bộ phận: quay lại bước 3 (chưa định lượng).', $smallFont, $muted, 70, 1460)
$canvas.DrawString('Không bao gồm thời gian sửa chữa. Ô đỏ = bottleneck; sơ đồ thể hiện quy trình hiện tại, chưa có AI.', $smallFont, $muted, 70, 1505)
$target = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\04-workflow-diagram.png'))
$bitmap.Save($target, [System.Drawing.Imaging.ImageFormat]::Png)
$canvas.Dispose()
$bitmap.Dispose()
foreach ($item in @($titleFont, $headFont, $bodyFont, $smallFont, $ink, $muted, $red, $blue, $line, $border, $redBorder)) { $item.Dispose() }
Write-Output "Created: $target"
