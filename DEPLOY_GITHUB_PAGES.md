# Desplegar SHOR PWA en GitHub Pages

## Archivos Listos para Subir

```
shor_pwa/
├── index.html          (redirección a SHOR.html)
├── SHOR.html           (app principal)
├── manifest.json       (configuración PWA)
├── service-worker.js   (cache offline)
├── icon-192.png        (icono 192x192)
└── icon-512.png        (icono 512x512)
```

## Pasos para Desplegar

### 1. Crear Repositorio en GitHub

1. Ir a https://github.com/new
2. Nombre del repo: `shor` (o el que prefieras)
3. Público (para GitHub Pages gratis)
4. **NO** inicializar con README
5. Crear repositorio

### 2. Subir Archivos

**Opción A: Desde la web de GitHub**

1. En el repo nuevo, click "uploading an existing file"
2. Arrastrar los 6 archivos:
   - index.html
   - SHOR.html
   - manifest.json
   - service-worker.js
   - icon-192.png
   - icon-512.png
3. Commit: "Initial SHOR PWA"

**Opción B: Desde Git (si tienes instalado)**

```bash
cd c:\Users\dozza\ruido\apps\shor_pwa

git init
git add index.html SHOR.html manifest.json service-worker.js icon-192.png icon-512.png
git commit -m "Initial SHOR PWA"
git branch -M main
git remote add origin https://github.com/[TU-USUARIO]/shor.git
git push -u origin main
```

### 3. Activar GitHub Pages

1. En el repo, ir a **Settings** (⚙️)
2. En el menú izquierdo, click **Pages**
3. En "Source", seleccionar:
   - Branch: `main`
   - Folder: `/ (root)`
4. Click **Save**
5. Esperar 1-2 minutos

### 4. Obtener Link Público

Tu app estará en:
```
https://[TU-USUARIO].github.io/shor/
```

O si el repo se llama diferente:
```
https://[TU-USUARIO].github.io/[NOMBRE-REPO]/
```

## Compartir con los 9 Usuarios

**Enviar por WhatsApp:**
```
📱 SHOR - Sensor Humano de Operación Real

Abre este link en tu celular:
https://[TU-USUARIO].github.io/shor/

Luego:
- iOS: Botón compartir → "Agregar a pantalla de inicio"
- Android: Menú → "Instalar app"

¡Listo! Ya tienes SHOR instalado como app.
```

## Ventajas de GitHub Pages

✅ **Gratis** - Sin costo
✅ **Permanente** - Link no expira
✅ **HTTPS** - Seguro (requerido para PWA)
✅ **Instalable** - Funciona en iOS y Android
✅ **Sin servidor** - No necesitas mantener nada

## Actualizar la App

Si haces cambios:

1. Editar archivos localmente
2. Subir archivos actualizados a GitHub
3. GitHub Pages se actualiza automáticamente
4. Usuarios ven cambios al recargar

## Verificar que Funciona

1. Abrir el link en el navegador
2. Ver que carga SHOR correctamente
3. Probar instalación como PWA
4. Verificar que funciona offline

## Troubleshooting

**Si no carga:**
- Esperar 2-3 minutos (GitHub Pages tarda en activarse)
- Verificar que los archivos están en la raíz del repo
- Verificar que GitHub Pages está activado en Settings

**Si no instala como PWA:**
- Verificar que el link es HTTPS (no HTTP)
- Verificar que manifest.json y service-worker.js están accesibles
- Abrir en Chrome/Safari (no navegadores in-app de WhatsApp)

## Link de Ejemplo

Si tu usuario de GitHub es `dozza` y el repo es `shor`:
```
https://dozza.github.io/shor/
```

**¡Eso es todo! App desplegada gratis y para siempre.**
