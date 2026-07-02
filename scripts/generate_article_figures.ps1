Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Out = Join-Path $Root 'site\public\images'

$Articles = @(
  [pscustomobject]@{ Slug='aizuchi-performance-test'; Title='整理したいですね'; A='進行感'; B='責任発生量'; C='ホワイトボード圧'; New=$false },
  [pscustomobject]@{ Slug='elevator-close-button-test'; Title='閉ボタン'; A='押下回数'; B='安心度'; C='扉への圧'; New=$false },
  [pscustomobject]@{ Slug='receipt-annual-report'; Title='レシート'; A='士気維持費'; B='固定費'; C='特別損失'; New=$false },
  [pscustomobject]@{ Slug='sock-exit-interview'; Title='片方の靴下'; A='退職理由'; B='制度未整備'; C='再配属案'; New=$false },
  [pscustomobject]@{ Slug='calendar-blank-meeting'; Title='空白時間'; A='侵入圧'; B='何もしない成功'; C='保全会議'; New=$false },
  [pscustomobject]@{ Slug='umbrella-stand-politics'; Title='傘立て'; A='派閥'; B='濡れ発言力'; C='入口支配'; New=$true },
  [pscustomobject]@{ Slug='mystery-container-press-conference'; Title='謎タッパー'; A='中身不明'; B='冷蔵庫世論'; C='会見拒否'; New=$true },
  [pscustomobject]@{ Slug='wet-towel-executive'; Title='おしぼり'; A='役職感'; B='清潔予算'; C='机上統治'; New=$true },
  [pscustomobject]@{ Slug='blinking-signal-life-plan'; Title='点滅信号'; A='判断時間'; B='人生計画'; C='横断保留'; New=$true },
  [pscustomobject]@{ Slug='staple-benefits-plan'; Title='ホチキス針'; A='福利厚生'; B='束ね力'; C='消耗品の声'; New=$true },
  [pscustomobject]@{ Slug='bagging-table-logistics'; Title='袋詰め台'; A='物流'; B='荷重配分'; C='豆腐防衛'; New=$true },
  [pscustomobject]@{ Slug='eye-drop-face-score'; Title='目薬前の顔'; A='予告恐怖'; B='まぶた交渉'; C='落下待機'; New=$true },
  [pscustomobject]@{ Slug='earphone-org-chart'; Title='絡まるイヤホン'; A='組織図'; B='責任線'; C='ほどけない会議'; New=$true },
  [pscustomobject]@{ Slug='charging-cable-night-shift'; Title='充電ケーブル'; A='夜勤'; B='枕元稼働'; C='断線不安'; New=$true },
  [pscustomobject]@{ Slug='atm-receipt-letter'; Title='ATM明細'; A='手紙'; B='残高の語尾'; C='無言の近況'; New=$true }
)

function Color($hex) {
  return [System.Drawing.ColorTranslator]::FromHtml($hex)
}

function Brush($hex) {
  return New-Object System.Drawing.SolidBrush (Color $hex)
}

function Pen($hex, $width = 2) {
  return [System.Drawing.Pen]::new((Color $hex), [single]$width)
}

function FontOf($size, $style = [System.Drawing.FontStyle]::Regular) {
  return [System.Drawing.Font]::new('Yu Gothic', [single]$size, $style, [System.Drawing.GraphicsUnit]::Pixel)
}

function DrawText($g, $value, $x, $y, $size, $hex = '#1d1b18', $bold = $false) {
  $style = if ($bold) { [System.Drawing.FontStyle]::Bold } else { [System.Drawing.FontStyle]::Regular }
  $font = FontOf $size $style
  $brush = Brush $hex
  $g.DrawString($value, $font, $brush, [single]$x, [single]$y)
  $font.Dispose()
  $brush.Dispose()
}

function DrawCard($g, $x, $y, $w, $h, $fill = '#ffffff') {
  $brush = Brush $fill
  $pen = Pen '#d9d0c1' 3
  $g.FillRectangle($brush, $x, $y, $w, $h)
  $g.DrawRectangle($pen, $x, $y, $w, $h)
  $brush.Dispose()
  $pen.Dispose()
}

function SaveBitmap($bmp, $path) {
  $dir = Split-Path $path -Parent
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
}

function FigureOne($article, $path) {
  $bmp = New-Object System.Drawing.Bitmap 1400, 900
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear((Color '#fbf8f0'))
  $g.FillRectangle((Brush '#1d1b18'), 0, 0, 1400, 112)
  DrawText $g 'よけいラボ 調査票' 70 35 36 '#ffffff' $true
  DrawText $g 'FIELD NOTE 01' 1130 42 24 '#e4b946' $true
  DrawCard $g 70 155 1260 635 '#ffffff'
  DrawText $g "対象: $($article.Title)" 120 210 54 '#1d1b18' $true
  DrawText $g '観察したことを、必要以上に表にしました。' 122 286 30 '#6b6861'

  $labels = @($article.A, $article.B, $article.C)
  $colors = @('#c94935', '#16736f', '#e4b946')
  $values = @(72, 58, 87)
  for ($i = 0; $i -lt 3; $i++) {
    $x = 125 + $i * 405
    $y = 365
    DrawCard $g $x $y 340 285 '#fffdf8'
    $g.FillEllipse((Brush $colors[$i]), $x + 26, $y + 26, 48, 48)
    DrawText $g $labels[$i] ($x + 95) ($y + 32) 32 '#1d1b18' $true
    $g.FillRectangle((Brush '#eee7dc'), $x + 42, $y + 126, 256, 30)
    $g.FillRectangle((Brush $colors[$i]), $x + 42, $y + 126, ([int](2.56 * $values[$i])), 30)
    DrawText $g "測定値 $($values[$i]) / 100" ($x + 42) ($y + 198) 28 '#6b6861'
  }
  $pen = Pen '#d9d0c1' 3
  $g.DrawLine($pen, 105, 820, 1295, 820)
  DrawText $g '注: 数値は編集部の顔つきと沈黙時間から算出' 120 835 24 '#6b6861'
  SaveBitmap $bmp $path
  $pen.Dispose()
  $g.Dispose()
  $bmp.Dispose()
}

function FigureTwo($article, $path) {
  $bmp = New-Object System.Drawing.Bitmap 1400, 900
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear((Color '#f3efe6'))
  DrawCard $g 80 85 1240 720 '#fffaf0'
  DrawText $g '会議中に発生した図' 125 142 36 '#c94935' $true
  DrawText $g "議題: $($article.Title)をどう扱うか" 125 205 48 '#1d1b18' $true

  $cx = 705
  $cy = 480
  $g.FillEllipse((Brush '#16736f'), $cx - 118, $cy - 118, 236, 236)
  $g.DrawEllipse((Pen '#1d1b18' 4), $cx - 118, $cy - 118, 236, 236)
  DrawText $g $article.Title ($cx - 88) ($cy - 24) 34 '#ffffff' $true

  $nodes = @(
    @{ X=265; Y=365; Label=$article.A; Color='#c94935' },
    @{ X=1085; Y=370; Label=$article.B; Color='#e4b946' },
    @{ X=315; Y=640; Label=$article.C; Color='#386d9f' },
    @{ X=1050; Y=640; Label='結論だけ大声'; Color='#8f5db7' }
  )
  foreach ($node in $nodes) {
    $g.DrawLine((Pen '#d9d0c1' 5), $cx, $cy, $node.X, $node.Y)
    $g.FillEllipse((Brush $node.Color), $node.X - 22, $node.Y - 22, 44, 44)
    DrawCard $g ($node.X - 135) ($node.Y + 34) 270 94 '#ffffff'
    DrawText $g $node.Label ($node.X - 95) ($node.Y + 58) 24 '#1d1b18' $true
  }
  DrawText $g '矢印は論理ではなく、会話の勢いを示しています。' 120 760 30 '#6b6861'
  SaveBitmap $bmp $path
  $g.Dispose()
  $bmp.Dispose()
}

function EyeCatch($article, $path) {
  $bmp = New-Object System.Drawing.Bitmap 1600, 1000
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear((Color '#f6f1e7'))
  DrawCard $g 80 78 1440 844 '#ffffff'
  $g.FillRectangle((Brush '#1d1b18'), 80, 78, 1440, 132)
  DrawText $g 'よけいラボ' 130 125 38 '#e4b946' $true
  DrawText $g 'REPORT' 1340 132 26 '#ffffff' $true
  DrawText $g $article.Title 130 300 64 '#1d1b18' $true
  $labels = @($article.A, $article.B, $article.C)
  $fills = @('#f7d8d0', '#d6eeee', '#faedc3')
  for ($i = 0; $i -lt 3; $i++) {
    $x = 160 + $i * 440
    DrawCard $g $x 620 330 140 $fills[$i]
    DrawText $g $labels[$i] ($x + 60) 668 36 '#1d1b18' $true
  }
  $arcPen = Pen '#c94935' 12
  $g.DrawArc($arcPen, 1120, 320, 300, 300, 20, 310)
  $g.DrawLine($arcPen, 1410, 512, 1480, 560)
  DrawText $g 'どうでもいいことを、全力でためす。' 130 860 32 '#6b6861'
  SaveBitmap $bmp $path
  $arcPen.Dispose()
  $g.Dispose()
  $bmp.Dispose()
}

foreach ($article in $Articles) {
  $dir = Join-Path $Out $article.Slug
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  FigureOne $article (Join-Path $dir 'figure-1.png')
  FigureTwo $article (Join-Path $dir 'figure-2.png')
  $eye = Join-Path $dir 'eyecatch.png'
  if ($article.New) {
    EyeCatch $article $eye
  }
}
