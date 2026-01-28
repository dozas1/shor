# Setup Firebase + GitHub Pages - SHOR PWA

## PASO 1: Configurar Firebase

### 1.1 Crear proyecto Firebase (Web Console)

**Necesitas hacer esto UNA VEZ desde el navegador:**

1. Ir a https://console.firebase.google.com
2. Click "Agregar proyecto"
3. Nombre: `shor-pwa` (o el que prefieras)
4. Desactivar Google Analytics (opcional)
5. Crear proyecto

### 1.2 Registrar app web

1. En el proyecto → Click ícono Web `</>`
2. Nombre de la app: `SHOR PWA`
3. **NO** marcar "Firebase Hosting"
4. Registrar app
5. **COPIAR** el código de configuración (lo necesitarás)

```javascript
// Ejemplo de lo que copiarás:
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "shor-pwa.firebaseapp.com",
  projectId: "shor-pwa",
  storageBucket: "shor-pwa.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

### 1.3 Habilitar Realtime Database

1. En el menú → "Realtime Database"
2. Click "Crear base de datos"
3. Ubicación: `us-central1` (o la más cercana)
4. Modo: **Modo de prueba** (permite lectura/escritura sin autenticación)
5. Habilitar

**Reglas de seguridad (para desarrollo):**
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

**⚠️ IMPORTANTE:** Estas reglas son para desarrollo. Para producción, cambiar a:
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

---

## PASO 2: Integrar Firebase en SHOR.html

Ejecutar desde terminal:

```powershell
# Ya está instalado Firebase CLI (13.30.0)
# Ahora integraremos Firebase en el HTML
```

---

## PASO 3: Configurar Git + GitHub

### 3.1 Inicializar repositorio local

```powershell
cd c:\Users\dozza\ruido\apps\shor_pwa

# Inicializar Git
git init

# Agregar archivos
git add index.html SHOR.html manifest.json service-worker.js

# Primer commit
git commit -m "Initial SHOR PWA with Firebase"
```

### 3.2 Crear repositorio en GitHub

**Opción A: Desde terminal (requiere GitHub CLI)**

```powershell
# Instalar GitHub CLI (si no lo tienes)
winget install --id GitHub.cli

# Login
gh auth login

# Crear repo
gh repo create shor --public --source=. --remote=origin --push
```

**Opción B: Desde web + terminal**

1. Ir a https://github.com/new
2. Nombre: `shor`
3. Público
4. NO inicializar con README
5. Crear

Luego en terminal:

```powershell
# Agregar remote
git remote add origin https://github.com/[TU-USUARIO]/shor.git

# Subir
git branch -M main
git push -u origin main
```

### 3.3 Activar GitHub Pages

**Desde terminal (requiere GitHub CLI):**

```powershell
gh api repos/[TU-USUARIO]/shor/pages -X POST -f source[branch]=main -f source[path]=/
```

**Desde web:**

1. Repo → Settings → Pages
2. Source: Branch `main`, folder `/`
3. Save

---

## PASO 4: Actualizar y Re-desplegar

Cada vez que hagas cambios:

```powershell
# Agregar cambios
git add .

# Commit
git commit -m "Descripción del cambio"

# Subir
git push

# GitHub Pages se actualiza automáticamente en 1-2 minutos
```

---

## PASO 5: Probar

1. Esperar 2 minutos después del push
2. Abrir: `https://[TU-USUARIO].github.io/shor/`
3. Instalar PWA en celular
4. Verificar que datos se sincronizan

---

## Comandos Rápidos

```powershell
# Ver estado
git status

# Ver cambios
git diff

# Ver historial
git log --oneline

# Ver URL del repo
git remote -v

# Ver link de GitHub Pages
gh browse
```

---

## Estructura Final

```
shor_pwa/
├── .git/                  (repositorio local)
├── index.html             (redirección)
├── SHOR.html              (app con Firebase)
├── manifest.json          (PWA config)
├── service-worker.js      (cache offline)
└── README.md              (documentación)
```

---

## Próximos Pasos

Una vez desplegado:

1. Compartir link: `https://[TU-USUARIO].github.io/shor/`
2. Usuarios instalan PWA
3. Datos se sincronizan automáticamente
4. Cada dispositivo tiene ID único
5. Sin login requerido

---

## Troubleshooting

**Firebase no conecta:**
- Verificar que apiKey es correcta
- Verificar que Realtime Database está habilitada
- Verificar reglas de seguridad

**GitHub Pages no actualiza:**
- Esperar 2-3 minutos
- Verificar que push fue exitoso: `git log`
- Verificar en Settings → Pages que está activo

**PWA no instala:**
- Verificar que es HTTPS (GitHub Pages lo es)
- Verificar que manifest.json es accesible
- Verificar que service-worker.js es accesible
