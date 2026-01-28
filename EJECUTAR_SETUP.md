# Ejecutar Setup Completo - SHOR PWA

## ✅ SCRIPT CORREGIDO Y LISTO

El script `setup_all.ps1` está corregido y listo para ejecutar.

---

## 🚀 EJECUTAR AHORA

**Abre PowerShell en esta carpeta y ejecuta:**

```powershell
cd c:\Users\dozza\ruido\apps\shor_pwa
.\setup_all.ps1
```

---

## 📋 QUÉ HARÁ EL SCRIPT

### Automático:
1. ✅ Verificar GitHub CLI (ya instalado)
2. ⏳ Instalar Firebase CLI (si falta)
3. 💾 Commit cambios actuales

### Interactivo (requiere tu acción):

**Paso 1: Login GitHub**
- Te pedirá código
- Copiar y pegar en navegador
- Autorizar

**Paso 2: Login Firebase**
- Se abrirá navegador
- Seleccionar cuenta Google
- Permitir acceso

**Paso 3: Crear proyecto Firebase**
- Automático si no existe

**Paso 4: Habilitar Realtime Database**
- Te dará link directo
- Ir a: https://console.firebase.google.com/project/shor-pwa/database
- Click "Crear base de datos"
- Ubicación: us-central1
- Modo: Modo de prueba
- Presionar Enter para continuar

**Paso 5: Copiar config Firebase**
- El script te dirá: `firebase apps:sdkconfig web`
- Ejecutar ese comando
- Copiar valores a SHOR.html líneas 468-476
- Presionar Enter para continuar

**Paso 6-9: Automático**
- Crear repo GitHub
- Subir código
- Activar GitHub Pages

---

## 🎯 RESULTADO FINAL

```
=== SETUP COMPLETADO ===

Tu app esta desplegada en:
  https://[TU-USUARIO].github.io/shor/

Proyecto Firebase:
  https://console.firebase.google.com/project/shor-pwa

Repositorio GitHub:
  https://github.com/[TU-USUARIO]/shor
```

---

## 🔄 SI PREFIERES PASO A PASO MANUAL

### 1. Instalar Firebase CLI

```powershell
npm install -g firebase-tools
```

### 2. Login GitHub

```powershell
gh auth login
```

### 3. Login Firebase

```powershell
firebase login
```

### 4. Crear proyecto Firebase

```powershell
firebase projects:create shor-pwa --display-name "SHOR PWA"
firebase use shor-pwa
```

### 5. Habilitar Realtime Database

Ir a: https://console.firebase.google.com/project/shor-pwa/database
- Crear base de datos
- us-central1
- Modo prueba

### 6. Crear app web Firebase

```powershell
firebase apps:create web shor-pwa-web
```

### 7. Obtener config

```powershell
firebase apps:sdkconfig web
```

Copiar valores a `SHOR.html` líneas 468-476

### 8. Commit cambios

```powershell
git add .
git commit -m "Add Firebase configuration"
```

### 9. Crear repo GitHub

```powershell
gh repo create shor --public --source=. --remote=origin --push
```

### 10. Activar GitHub Pages

```powershell
$user = gh api user --jq .login
gh api "repos/$user/shor/pages" -X POST -f source[branch]=main -f source[path]=/
```

---

## ✅ VERIFICAR

```powershell
# Ver tu usuario
gh api user --jq .login

# Abrir repo en navegador
gh browse

# Tu app estará en:
# https://[TU-USUARIO].github.io/shor/
```

---

**¿Listo para ejecutar? Abre PowerShell y ejecuta:**

```powershell
.\setup_all.ps1
```
