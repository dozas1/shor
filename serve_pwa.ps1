# serve_pwa.ps1
# Servidor HTTP simple para servir SHOR PWA localmente

param(
    [int]$Port = 8080
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== SHOR PWA Local Server ===" -ForegroundColor Cyan
Write-Host ""

# Get local IP
$localIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -notlike "169.254.*" } | Select-Object -First 1).IPAddress

if (-not $localIP) {
    $localIP = "localhost"
}

Write-Host "Servidor iniciado en:" -ForegroundColor Green
Write-Host "  Local:   http://localhost:$Port/SHOR.html" -ForegroundColor Yellow
Write-Host "  Red:     http://${localIP}:$Port/SHOR.html" -ForegroundColor Yellow
Write-Host ""
Write-Host "Para acceder desde tu celular:" -ForegroundColor Cyan
Write-Host "  1. Conecta el celular a la misma red WiFi" -ForegroundColor White
Write-Host "  2. Abre el navegador en el celular" -ForegroundColor White
Write-Host "  3. Ve a: http://${localIP}:$Port/SHOR.html" -ForegroundColor White
Write-Host ""
Write-Host "Presiona Ctrl+C para detener el servidor" -ForegroundColor DarkGray
Write-Host ""

# Create HTTP listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:$Port/")

try {
    $listener.Start()
    
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $path = $request.Url.LocalPath.TrimStart('/')
        if ($path -eq "" -or $path -eq "/") {
            $path = "SHOR.html"
        }
        
        $filePath = Join-Path $PSScriptRoot $path
        
        Write-Host "[$((Get-Date).ToString('HH:mm:ss'))] " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($request.HttpMethod) " -NoNewline -ForegroundColor Cyan
        Write-Host "$($request.Url.LocalPath)" -ForegroundColor White
        
        if (Test-Path $filePath) {
            $content = [System.IO.File]::ReadAllBytes($filePath)
            
            # Set content type
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $contentType = switch ($ext) {
                ".html" { "text/html; charset=utf-8" }
                ".js" { "application/javascript; charset=utf-8" }
                ".json" { "application/json; charset=utf-8" }
                ".png" { "image/png" }
                ".jpg" { "image/jpeg" }
                ".jpeg" { "image/jpeg" }
                ".svg" { "image/svg+xml" }
                ".css" { "text/css; charset=utf-8" }
                default { "application/octet-stream" }
            }
            
            $response.ContentType = $contentType
            $response.ContentLength64 = $content.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
            $errorMsg = "404 - File not found: $path"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($errorMsg)
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
        
        $response.Close()
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
} finally {
    $listener.Stop()
    Write-Host ""
    Write-Host "Servidor detenido." -ForegroundColor Yellow
}
