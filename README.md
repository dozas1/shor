# SHOR PWA - Instalación y Uso

## Problema Detectado

**iOS**: No abre archivos HTML locales en navegador directamente
**Android**: Abre pero no permite instalar PWA desde archivo local

## Solución: Servidor Local Simple

Para que la PWA funcione correctamente en iOS y Android, necesitas servir los archivos desde un servidor HTTP local.

### Opción 1: Python (más simple)

```powershell
# En la carpeta shor_pwa, ejecutar:
python -m http.server 8080
```

Luego abrir en el celular: `http://[IP-DE-TU-PC]:8080/SHOR.html`

### Opción 2: Node.js (http-server)

```powershell
# Instalar (una sola vez)
npm install -g http-server

# Ejecutar en la carpeta shor_pwa
http-server -p 8080
```

Luego abrir en el celular: `http://[IP-DE-TU-PC]:8080/SHOR.html`

### Opción 3: PowerShell (sin instalar nada)

```powershell
# Ejecutar en la carpeta shor_pwa
.\serve_pwa.ps1
```

## Cómo Obtener la IP de tu PC

```powershell
ipconfig
# Buscar "Dirección IPv4" (ej: 192.168.1.100)
```

## Instalación en el Celular

1. **Conectar celular y PC a la misma red WiFi**
2. **Abrir navegador en el celular** (Chrome/Safari)
3. **Ir a** `http://[IP-DE-TU-PC]:8080/SHOR.html`
4. **iOS**: Botón compartir → "Agregar a pantalla de inicio"
5. **Android**: Menú (3 puntos) → "Instalar app" o "Agregar a pantalla de inicio"

## Enviar por WhatsApp

**No puedes enviar solo el HTML** porque las PWAs necesitan:
- Manifest.json
- Service Worker
- Iconos
- Servidor HTTP (no funciona con file://)

### Alternativa: Enviar Link

1. Levantar servidor local
2. Usar servicio como **ngrok** para exponer tu servidor:
   ```powershell
   ngrok http 8080
   ```
3. Enviar el link público por WhatsApp
4. Usuario abre link → Instala PWA

### Alternativa 2: Hosting Gratuito

Subir los 4 archivos a:
- **GitHub Pages** (gratis)
- **Netlify** (gratis)
- **Vercel** (gratis)

Luego enviar el link público.

## Archivos Necesarios

```
shor_pwa/
├── SHOR.html           (app principal)
├── manifest.json       (configuración PWA)
├── service-worker.js   (cache offline)
├── icon-192.png        (icono 192x192)
└── icon-512.png        (icono 512x512)
```

**Todos los archivos deben estar juntos en la misma carpeta.**

## Por Qué No Funciona el Archivo Solo

- **iOS**: Safari no permite abrir archivos HTML locales con permisos completos
- **Android**: Chrome permite abrir pero no instalar PWA desde `file://`
- **PWA requiere**: Protocolo HTTPS o HTTP (no `file://`)

## Solución Recomendada

**Para 9 usuarios**: Subir a GitHub Pages (gratis, 1 minuto)

```powershell
# Crear repo en GitHub
# Subir los 5 archivos
# Activar GitHub Pages en Settings
# Compartir link: https://[tu-usuario].github.io/shor/SHOR.html
```

**Ventaja**: Link permanente, funciona en iOS y Android, instalable como PWA.
