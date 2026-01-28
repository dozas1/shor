# Comandos Terminal - SHOR PWA con Firebase + GitHub

## ✅ COMPLETADO

```powershell
# Git inicializado
git init

# Archivos agregados
git add .

# Primer commit
git commit -m "Initial SHOR PWA v2.0 with Firebase sync"
```

---

## 🔥 PASO 1: CONFIGURAR FIREBASE (Web Console)

**Necesitas hacer esto desde el navegador UNA VEZ:**

### 1.1 Crear proyecto

1. Ir a: https://console.firebase.google.com
2. Click "Agregar proyecto"
3. Nombre: `shor-pwa`
4. Desactivar Google Analytics
5. Crear proyecto

### 1.2 Registrar app web

1. En el proyecto → Click ícono Web `</>`
2. Nombre: `SHOR PWA`
3. **NO** marcar "Firebase Hosting"
4. Registrar app
5. **COPIAR** el código de configuración

### 1.3 Habilitar Realtime Database

1. Menú → "Realtime Database"
2. Click "Crear base de datos"
3. Ubicación: `us-central1`
4. Modo: **Modo de prueba**
5. Habilitar

### 1.4 Configurar reglas de seguridad

En la pestaña "Reglas":

```json
{
  "rules": {
    "users": {
      "$deviceId": {
        ".read": true,
        ".write": true
      }
    }
  }
}
```

Click "Publicar"

---

## 📝 PASO 2: COPIAR CONFIG DE FIREBASE

Abrir `SHOR.html` y reemplazar líneas 468-476:

```javascript
// ANTES (líneas 468-476):
const firebaseConfig = {
    apiKey: "TU_API_KEY",
    authDomain: "TU_PROJECT_ID.firebaseapp.com",
    databaseURL: "https://TU_PROJECT_ID-default-rtdb.firebaseio.com",
    projectId: "TU_PROJECT_ID",
    storageBucket: "TU_PROJECT_ID.appspot.com",
    messagingSenderId: "TU_SENDER_ID",
    appId: "TU_APP_ID"
};

// DESPUÉS (pegar lo que copiaste de Firebase):
const firebaseConfig = {
    apiKey: "AIza...",  // Tu API Key real
    authDomain: "shor-pwa.firebaseapp.com",
    databaseURL: "https://shor-pwa-default-rtdb.firebaseio.com",
    projectId: "shor-pwa",
    storageBucket: "shor-pwa.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abc123"
};
```

**Guardar el archivo.**

---

## 💾 PASO 3: COMMIT DE CAMBIOS

```powershell
# Agregar cambios
git add SHOR.html

# Commit con config de Firebase
git commit -m "Add Firebase configuration"
```

---

## 🐙 PASO 4: CREAR REPO EN GITHUB

### Opción A: GitHub CLI (recomendado)

```powershell
# Instalar GitHub CLI (si no lo tienes)
winget install --id GitHub.cli

# Login
gh auth login

# Crear repo y subir
gh repo create shor --public --source=. --remote=origin --push
```

### Opción B: Manual (web + terminal)

**Desde el navegador:**
1. Ir a: https://github.com/new
2. Nombre: `shor`
3. Público ✓
4. **NO** inicializar con README
5. Crear repositorio

**Desde terminal:**
```powershell
# Agregar remote (reemplaza [TU-USUARIO])
git remote add origin https://github.com/[TU-USUARIO]/shor.git

# Cambiar a branch main
git branch -M main

# Subir
git push -u origin main
```

---

## 🌐 PASO 5: ACTIVAR GITHUB PAGES

### Opción A: GitHub CLI

```powershell
# Activar Pages (reemplaza [TU-USUARIO])
gh api repos/[TU-USUARIO]/shor/pages -X POST -f source[branch]=main -f source[path]=/
```

### Opción B: Manual (web)

1. Ir a tu repo en GitHub
2. Settings → Pages
3. Source:
   - Branch: `main`
   - Folder: `/ (root)`
4. Save
5. Esperar 2 minutos

---

## ✅ PASO 6: OBTENER LINK PÚBLICO

Tu app estará en:
```
https://[TU-USUARIO].github.io/shor/
```

**Verificar:**
```powershell
# Ver link (si usas GitHub CLI)
gh browse
```

O simplemente abrir en navegador:
```
https://[TU-USUARIO].github.io/shor/
```

---

## 📱 PASO 7: PROBAR EN CELULAR

1. Abrir link en celular
2. Verificar que carga correctamente
3. Abrir consola del navegador (opcional)
4. Buscar mensajes `[Firebase]`
5. Instalar como PWA
6. Probar registro de datos
7. Verificar sincronización

---

## 🔄 ACTUALIZAR DESPUÉS

Cada vez que hagas cambios:

```powershell
# Ver cambios
git status

# Agregar cambios
git add .

# Commit
git commit -m "Descripción del cambio"

# Subir
git push

# GitHub Pages se actualiza automáticamente en 1-2 minutos
```

---

## 🐛 TROUBLESHOOTING

### Firebase no conecta

```powershell
# Verificar en consola del navegador:
# - Debe aparecer: [Firebase] Inicializado correctamente
# - Debe aparecer: [Firebase] Device ID: device_...

# Si no aparece, verificar:
# 1. Config de Firebase es correcta
# 2. Realtime Database está habilitada
# 3. Reglas de seguridad están configuradas
```

### GitHub Pages no actualiza

```powershell
# Verificar que push fue exitoso
git log --oneline

# Verificar en GitHub web
# Repo → Settings → Pages → debe estar activo

# Esperar 2-3 minutos y refrescar
```

### PWA no instala

```
# Verificar:
# 1. URL es HTTPS (GitHub Pages lo es automáticamente)
# 2. manifest.json es accesible
# 3. service-worker.js es accesible
# 4. Abrir en Chrome/Safari (no navegador in-app de WhatsApp)
```

---

## 📊 VERIFICAR SINCRONIZACIÓN

**En Firebase Console:**
1. Realtime Database → Data
2. Deberías ver estructura:
```
users/
  device_123456_abc/
    persona: {...}
    registros: [...]
    lastSync: 1234567890
```

**En consola del navegador:**
```javascript
// Ver device ID
localStorage.getItem('deviceId')

// Ver persona
localStorage.getItem('persona')
```

---

## 🎉 LISTO

Tu app está:
- ✅ Desplegada en GitHub Pages
- ✅ Con Firebase sincronizando datos
- ✅ Instalable como PWA
- ✅ Funcionando offline
- ✅ Sin login requerido

**Compartir con usuarios:**
```
📱 SHOR - Sensor Humano de Operación Real

Abre este link en tu celular:
https://[TU-USUARIO].github.io/shor/

Luego:
- iOS: Botón compartir → "Agregar a pantalla de inicio"
- Android: Menú → "Instalar app"

¡Listo! Tus datos se sincronizan automáticamente.
```
