# Setup Completo desde Terminal - SHOR PWA

## TODO DESDE TERMINAL (CERO NAVEGADOR)

---

## ✅ PASO 1: INSTALAR HERRAMIENTAS

```powershell
# GitHub CLI (ya instalado)
winget install --id GitHub.cli

# Firebase CLI
npm install -g firebase-tools

# Verificar instalaciones
gh --version
firebase --version
```

---

## 🔐 PASO 2: LOGIN GITHUB

```powershell
# Login interactivo
gh auth login

# Seleccionar:
# - GitHub.com
# - HTTPS
# - Yes (authenticate Git)
# - Login with a web browser
# - Copiar código y pegar en navegador

# Verificar login
gh auth status
```

---

## 🔥 PASO 3: LOGIN FIREBASE

```powershell
# Login interactivo
firebase login

# Se abrirá navegador para autorizar
# Seleccionar cuenta de Google
# Permitir acceso

# Verificar login
firebase projects:list
```

---

## 🚀 PASO 4: CREAR PROYECTO FIREBASE

```powershell
# Crear proyecto
firebase projects:create shor-pwa --display-name "SHOR PWA"

# Seleccionar proyecto
firebase use shor-pwa

# Habilitar Realtime Database
firebase database:create shor-pwa --location us-central1

# Configurar reglas de seguridad
firebase database:set-rules database.rules.json
```

---

## 📝 PASO 5: OBTENER CONFIG DE FIREBASE

```powershell
# Obtener configuración
firebase apps:sdkconfig web

# Copiar output y guardar en archivo temporal
```

---

## 🔧 PASO 6: CONFIGURAR SHOR.html AUTOMÁTICAMENTE

```powershell
# Script PowerShell para actualizar config
.\update_firebase_config.ps1
```

---

## 📦 PASO 7: CREAR REPO GITHUB

```powershell
# Agregar cambios
git add .

# Commit
git commit -m "Add Firebase configuration"

# Crear repo y subir
gh repo create shor --public --source=. --remote=origin --push
```

---

## 🌐 PASO 8: ACTIVAR GITHUB PAGES

```powershell
# Obtener usuario
$user = gh api user --jq .login

# Activar Pages
gh api "repos/$user/shor/pages" -X POST -f source[branch]=main -f source[path]=/

# Obtener URL
echo "https://$user.github.io/shor/"
```

---

## ✅ PASO 9: VERIFICAR

```powershell
# Abrir en navegador
gh browse

# Ver logs de deployment
gh run list
```

---

## 🎉 LISTO

Todo configurado desde terminal:
- ✅ GitHub CLI instalado y autenticado
- ✅ Firebase CLI instalado y autenticado
- ✅ Proyecto Firebase creado
- ✅ Realtime Database habilitada
- ✅ Config de Firebase en SHOR.html
- ✅ Repo GitHub creado
- ✅ GitHub Pages activado
- ✅ PWA desplegada

**URL final:**
```
https://[TU-USUARIO].github.io/shor/
```
