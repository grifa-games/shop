Add-Type -AssemblyName System.Drawing

$inputFile = "C:\Users\wassi\.gemini\antigravity\brain\98ae45ae-42c0-4bdd-b26a-3599c1c05668\media__1772986246819.png"
$outputFile = "d:\oussa apps\grifa\favicon.png"

try {
    $img = [System.Drawing.Image]::FromFile($inputFile)
    $minSize = [Math]::Min($img.Width, $img.Height)

    $bmp = New-Object System.Drawing.Bitmap($minSize, $minSize)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    # Enable high quality rendering
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    
    $g.Clear([System.Drawing.Color]::Transparent)

    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddEllipse(0, 0, $minSize, $minSize)
    $g.SetClip($path)

    # Offset to crop center if image is not square
    $xOffset = ($img.Width - $minSize) / 2
    $yOffset = ($img.Height - $minSize) / 2

    $rect = New-Object System.Drawing.Rectangle(0, 0, $minSize, $minSize)
    $g.DrawImage($img, $rect, $xOffset, $yOffset, $minSize, $minSize, [System.Drawing.GraphicsUnit]::Pixel)
    
    $g.Dispose()

    $bmp.Save($outputFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    $img.Dispose()
    Write-Output "SUCCESS"
} catch {
    Write-Error $_.Exception.Message
}
