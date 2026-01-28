# setup_all.ps1
# Script completo para configurar SHOR PWA desde terminal

param(
    [string]$ProjectName = "shor-pwa",
    [string]$RepoName = "shor"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== SHOR PWA - Setup Completo ===" -ForegroundColor Cyan
Write-Host ""

# ============================================
# PASO 1: Verificar herramientas
# ============================================

Write-Host "[1/9] Verificando herramientas..." -ForegroundColor Yellow

$ghPath = "C:\Program Files\GitHub CLI\gh.exe"
if (Test-Path $ghPath) {
    $ghVersion = & $ghPath --version 2>&1 | Select-Object -First 1
    Write-Host "  OK GitHub CLI: $ghVersion" -ForegroundColor Green
    Set-Alias -Name gh -Value $ghPath -Scope Script
} else {
    Write-Host "  X GitHub CLI no instalado" -ForegroundColor Red
    Write-Host "    Instalando..." -ForegroundColor Yellow
    winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements
    Write-Host "  OK GitHub CLI instalado. Reinicia PowerShell y ejecuta de nuevo." -ForegroundColor Green
    exit
}

$fbCheck = Get-Command firebase -ErrorAction SilentlyContinue
if ($fbCheck) {
    $fbVersion = firebase --version 2>&1
    Write-Host "  OK Firebase CLI: $fbVersion" -ForegroundColor Green
} else {
    Write-Host "  X Firebase CLI no instalado" -ForegroundColor Red
    Write-Host "    Instalando..." -ForegroundColor Yellow
    npm install -g firebase-tools
    Write-Host "  OK Firebase CLI instalado" -ForegroundColor Green
}

# ============================================
# PASO 2: Login GitHub
# ============================================

Write-Host ""
Write-Host "[2/9] Verificando login GitHub..." -ForegroundColor Yellow

$ghStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  X No estas logueado en GitHub" -ForegroundColor Red
    Write-Host "    Ejecutando login..." -ForegroundColor Yellow
    gh auth login
} else {
    Write-Host "  OK Ya estas logueado en GitHub" -ForegroundColor Green
}

# ============================================
# PASO 3: Login Firebase
# ============================================

Write-Host ""
Write-Host "[3/9] Verificando login Firebase..." -ForegroundColor Yellow

$fbProjects = firebase projects:list 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  X No estas logueado en Firebase" -ForegroundColor Red
    Write-Host "    Ejecutando login..." -ForegroundColor Yellow
    firebase login
} else {
    Write-Host "  OK Ya estas logueado en Firebase" -ForegroundColor Green
}

# ============================================
# PASO 4: Crear proyecto Firebase
# ============================================

Write-Host ""
Write-Host "[4/9] Creando proyecto Firebase..." -ForegroundColor Yellow

$existingProject = firebase projects:list 2>&1 | Select-String $ProjectName
if ($existingProject) {
    Write-Host "  OK Proyecto '$ProjectName' ya existe" -ForegroundColor Green
} else {
    Write-Host "  Creando proyecto '$ProjectName'..." -ForegroundColor Yellow
    firebase projects:create $ProjectName --display-name "SHOR PWA"
    Write-Host "  OK Proyecto creado" -ForegroundColor Green
}

firebase use $ProjectName

# ============================================
# PASO 5: Habilitar Realtime Database
# ============================================

Write-Host ""
Write-Host "[5/9] Configurando Realtime Database..." -ForegroundColor Yellow

# Nota: firebase database:create requiere proyecto con billing habilitado
# Por ahora, el usuario debe habilitar manualmente desde console
Write-Host "  ! Debes habilitar Realtime Database manualmente:" -ForegroundColor Yellow
Write-Host "    1. Ir a: https://console.firebase.google.com/project/$ProjectName/database" -ForegroundColor White
Write-Host "    2. Click Crear base de datos" -ForegroundColor White
Write-Host "    3. Ubicacion: us-central1" -ForegroundColor White
Write-Host "    4. Modo: Modo de prueba" -ForegroundColor White
Write-Host ""
Read-Host "  Presiona Enter cuando hayas habilitado Realtime Database"

# ============================================
# PASO 6: Obtener config de Firebase
# ============================================

Write-Host ""
Write-Host "[6/9] Obteniendo configuración de Firebase..." -ForegroundColor Yellow

# Crear app web si no existe
$apps = firebase apps:list 2>&1
if ($apps -notmatch "shor-pwa-web") {
    Write-Host "  Creando app web..." -ForegroundColor Yellow
    firebase apps:create web shor-pwa-web
}

# Obtener config
Write-Host "  Obteniendo SDK config..." -ForegroundColor Yellow
$config = firebase apps:sdkconfig web 2>&1

# Extraer valores (esto es aproximado, puede requerir ajustes)
Write-Host "  ! Copia la configuracion de Firebase manualmente:" -ForegroundColor Yellow
Write-Host "    Ejecuta: firebase apps:sdkconfig web" -ForegroundColor White
Write-Host "    Y pega los valores en SHOR.html lineas 468-476" -ForegroundColor White
Write-Host ""
Read-Host "  Presiona Enter cuando hayas actualizado SHOR.html"

# ============================================
# PASO 7: Commit cambios
# ============================================

Write-Host ""
Write-Host "[7/9] Guardando cambios..." -ForegroundColor Yellow

git add .
$commitResult = git commit -m "Add Firebase configuration" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "  OK Cambios guardados" -ForegroundColor Green
} else {
    Write-Host "  OK Sin cambios nuevos" -ForegroundColor Green
}

# ============================================
# PASO 8: Crear repo GitHub
# ============================================

Write-Host ""
Write-Host "[8/9] Creando repositorio GitHub..." -ForegroundColor Yellow

$existingRepo = gh repo view $RepoName 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "  OK Repositorio '$RepoName' ya existe" -ForegroundColor Green
    git push 2>&1 | Out-Null
} else {
    Write-Host "  Creando repositorio '$RepoName'..." -ForegroundColor Yellow
    gh repo create $RepoName --public --source=. --remote=origin --push
    Write-Host "  OK Repositorio creado y codigo subido" -ForegroundColor Green
}

# ============================================
# PASO 9: Activar GitHub Pages
# ============================================

Write-Host ""
Write-Host "[9/9] Activando GitHub Pages..." -ForegroundColor Yellow

$user = gh api user --jq .login
$pagesStatus = gh api "repos/$user/$RepoName/pages" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "  OK GitHub Pages ya esta activo" -ForegroundColor Green
} else {
    Write-Host "  Activando GitHub Pages..." -ForegroundColor Yellow
    gh api "repos/$user/$RepoName/pages" -X POST -f source[branch]=main -f source[path]=/
    Write-Host "  OK GitHub Pages activado" -ForegroundColor Green
}

# ============================================
# RESUMEN
# ============================================
a
Write-Host ""
Write-Host "=== ✅ SETUP COMPLETADO ===" -ForegroundColor Green
Write-Host ""
Write-Host "Tu app está desplegada en:" -ForegroundColor Cyan
Write-Host "  https://$user.github.io/$RepoName/" -ForegroundColor Yellow
Write-Host ""
Write-Host "Proyecto Firebase:" -ForegroundColor Cyan
Write-Host "  https://console.firebase.google.com/project/$ProjectName" -ForegroundColor Yellow
Write-Host ""o
Write-Host "Repositorio GitHub:" -ForegroundColor Cyan
Write-Host "  https://github.com/$user/$RepoName" -ForegroundColor Yellow
Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Esperar 2 minutos para que GitHub Pages se active" -ForegroundColor White
Write-Host "  2. Abrir la URL en tu celular" -ForegroundColor White
Write-Host "  3. Instalar como PWA" -ForegroundColor White
Write-Host "  4. Probar sincronización de datos" -ForegroundColor White
Write-Host ""
