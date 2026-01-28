# Guía de Pruebas SHOR - Versión Firebase Real-Time

**Fecha:** 2026-01-27  
**URL:** https://dozas1.github.io/shor/

---

## 🔄 Cambios Implementados

### 1. **Guardado en Tiempo Real a Firebase**
- Cada nota se guarda INMEDIATAMENTE en Firebase al crearla
- No espera a "exportar" para subir datos
- Ruta: `registros/{deviceId}/{registroId}`

### 2. **Exportación Solo a Firebase**
- Ya NO descarga archivo JSON
- Solo guarda reporte en Firebase
- Ruta: `exports/{deviceId}/{reportId}`

### 3. **Manifest PWA Mejorado**
- `start_url` cambiado a `index.html`
- Agregadas categorías para mejor descubrimiento
- `prefer_related_applications: false`

---

## ✅ Checklist de Pruebas

### PRUEBA 1: Instalación PWA en Android

**Pasos:**
1. Abrir https://dozas1.github.io/shor/ en Chrome Android
2. Verificar que aparece botón verde "📱 Instalar App" en header
3. Tocar el botón
4. Debería aparecer diálogo de instalación del sistema
5. Aceptar instalación
6. Verificar que app aparece en pantalla de inicio
7. Abrir app desde pantalla de inicio
8. Verificar que botón "📱 Instalar App" ya NO aparece (está oculto)

**Resultado esperado:**
- ✅ App se instala correctamente
- ✅ Icono aparece en pantalla de inicio
- ✅ Abre en modo standalone (sin barra de navegador)
- ✅ Botón de instalación desaparece después de instalar

**Si falla:**
- Verificar que Chrome está actualizado
- Intentar desde menú: ⋮ → "Instalar app"
- Verificar en consola (F12) logs: `[PWA] Install prompt disponible`

---

### PRUEBA 2: Dictar Nota por Voz

**Pasos:**
1. Tocar "🎤 Dictar nota por voz"
2. Permitir acceso al micrófono
3. Verificar que aparece preview gris arriba con "🎤 Dictando..."
4. Hablar claramente: "Esta es una prueba de transcripción de voz"
5. Verificar que texto aparece EN TIEMPO REAL en el preview
6. Seguir hablando: "Segunda frase de prueba"
7. Verificar que se acumula el texto
8. Tocar "⏹️ Detener dictado"
9. Verificar que preview desaparece
10. Verificar que nota aparece en "Registros de hoy" con icono 🎤

**Resultado esperado:**
- ✅ Preview muestra texto en tiempo real
- ✅ Texto se acumula correctamente
- ✅ Auto-restart funciona si hay pausas
- ✅ Nota se guarda al detener
- ✅ Aparece en lista con icono 🎤

**Verificar en consola:**
```
[Voice] Transcripción iniciada
[Voice] Transcribiendo... Esta es una prueba
[Voice] Texto final acumulado: Esta es una prueba de transcripción de voz
[Voice] Nota guardada: Esta es una prueba...
[Firebase] Registro guardado en tiempo real: reg_1738034567890_abc123
```

---

### PRUEBA 3: Guardado en Firebase Tiempo Real

**Pasos:**
1. Abrir Firebase Console: https://console.firebase.google.com/project/shor-pwa/database
2. Navegar a "Realtime Database"
3. En otra pestaña, abrir SHOR: https://dozas1.github.io/shor/
4. Dictar una nota: "Prueba de sincronización en tiempo real"
5. Detener dictado
6. **INMEDIATAMENTE** refrescar Firebase Console
7. Verificar que aparece nuevo nodo en: `registros/{deviceId}/{registroId}`
8. Expandir nodo y verificar estructura:
   ```json
   {
     "id": "reg_1738034567890_abc123",
     "personaId": "...",
     "tipo": "voz",
     "contenido": "Prueba de sincronización en tiempo real",
     "fecha": "2026-01-27",
     "timestamp": "2026-01-27T22:30:00.000Z"
   }
   ```

**Resultado esperado:**
- ✅ Registro aparece en Firebase INMEDIATAMENTE (< 2 segundos)
- ✅ Estructura JSON correcta
- ✅ Contenido completo de la transcripción
- ✅ Device ID único por dispositivo

**Si falla:**
- Verificar en consola: `[Firebase] Registro guardado en tiempo real: ...`
- Si hay error: `[Firebase] Error al guardar registro: ...`
- Verificar reglas de seguridad en Firebase (deben permitir write)

---

### PRUEBA 4: Escribir Nota Manual

**Pasos:**
1. Tocar "✏️ Escribir nota"
2. Escribir: "Nota manual de prueba"
3. Tocar "Guardar"
4. Verificar que aparece en "Registros de hoy" con icono ✏️
5. Abrir Firebase Console
6. Verificar que aparece en `registros/{deviceId}/{registroId}`

**Resultado esperado:**
- ✅ Nota se guarda localmente
- ✅ Nota se sube a Firebase inmediatamente
- ✅ Aparece en lista con icono ✏️

---

### PRUEBA 5: Skip (Nada Relevante)

**Pasos:**
1. Tocar "⏭️ Nada relevante hoy"
2. Verificar que aparece en "Registros de hoy" con icono ⏭️
3. Verificar en Firebase Console

**Resultado esperado:**
- ✅ Registro tipo "skip" se guarda
- ✅ Contenido: "Nada relevante hoy"
- ✅ Se sube a Firebase

---

### PRUEBA 6: Resumen Completo

**Pasos:**
1. Crear varias notas (voz, texto, skip)
2. Scroll hacia abajo
3. Tocar "Ver todas las tareas"
4. Verificar que se despliega lista completa
5. Verificar que están agrupadas por fecha
6. Verificar que muestra contador total al final

**Resultado esperado:**
- ✅ Muestra TODAS las notas
- ✅ Agrupadas por fecha (más recientes primero)
- ✅ Iconos correctos (🎤 ✏️ ⏭️)
- ✅ Contador total correcto

---

### PRUEBA 7: Exportar Reporte (Solo Firebase)

**Pasos:**
1. Tocar botón "📤" en header
2. Escribir opinión: "App funciona bien en Android"
3. Tocar "Exportar"
4. Verificar mensaje: "✓ Reporte guardado en Firebase"
5. Verificar que muestra ID del reporte
6. Verificar que muestra cantidad de registros
7. **NO debe descargar archivo JSON**
8. Abrir Firebase Console
9. Navegar a: `exports/{deviceId}/{reportId}`
10. Verificar estructura completa del reporte

**Resultado esperado:**
- ✅ Mensaje de confirmación con ID
- ✅ NO descarga archivo
- ✅ Reporte aparece en Firebase
- ✅ Estructura JSON completa con:
  - `shor_export.version`
  - `shor_export.export_id`
  - `shor_export.persona`
  - `shor_export.registros[]`
  - `shor_export.opinion_del_dia`
  - `shor_export.meta_flujo`

**Si falla:**
- Verificar en consola: `[Firebase] Reporte guardado en Firebase: rep_...`
- Si error: `[Firebase] Error al guardar reporte: ...`

---

## 🔍 Verificación en Firebase Console

### Estructura Esperada

```
shor-pwa (Realtime Database)
├── registros/
│   └── device_1738034567890_abc123/
│       ├── reg_1738034567890_xyz/
│       │   ├── id: "reg_1738034567890_xyz"
│       │   ├── personaId: "..."
│       │   ├── tipo: "voz"
│       │   ├── contenido: "Texto transcrito..."
│       │   ├── fecha: "2026-01-27"
│       │   └── timestamp: "2026-01-27T22:30:00.000Z"
│       └── reg_1738034567891_abc/
│           └── ...
└── exports/
    └── device_1738034567890_abc123/
        └── rep_1738034567892/
            └── shor_export/
                ├── version: "1.0.0"
                ├── export_id: "rep_1738034567892"
                ├── persona: {...}
                ├── registros: [...]
                └── meta_flujo: {...}
```

---

## 📊 Logs Esperados en Consola

### Al Iniciar App
```
[IndexedDB] Base de datos abierta
[Firebase] Inicializado correctamente
[Firebase] Device ID: device_1738034567890_abc123
```

### Al Dictar Voz
```
[Voice] Transcripción iniciada
[Voice] Transcribiendo... Texto en tiempo real
[Voice] Texto final acumulado: Texto completo
[Voice] Nota guardada: Texto completo
[Firebase] Registro guardado en tiempo real: reg_1738034567890_xyz
```

### Al Exportar
```
[Firebase] Reporte guardado en Firebase: rep_1738034567892
```

---

## ❌ Errores Comunes y Soluciones

### Error: "Firebase no está configurado"
**Causa:** Firebase no se inicializó correctamente  
**Solución:** Verificar que `firebaseConfig` tiene valores reales (no placeholders)

### Error: "Permission denied"
**Causa:** Reglas de seguridad de Firebase muy restrictivas  
**Solución:** Cambiar reglas a modo desarrollo:
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

### Error: "Recognition not supported"
**Causa:** Navegador no soporta Web Speech API  
**Solución:** Usar Chrome o Edge (no Firefox/Safari)

### Error: "Micrófono denegado"
**Causa:** Permisos de micrófono no otorgados  
**Solución:** Configuración → Sitios → Permisos → Micrófono → Permitir

---

## 🎯 Criterios de Éxito

Para considerar que SHOR funciona correctamente:

- [x] PWA se instala en Android
- [x] Transcripción de voz funciona en tiempo real
- [x] Texto se muestra mientras se dicta
- [x] Cada nota se guarda en Firebase inmediatamente
- [x] Resumen completo muestra todas las notas
- [x] Exportación guarda en Firebase (sin descarga)
- [x] Firebase Console muestra datos correctos
- [x] Logs en consola confirman operaciones

---

## 📝 Notas Importantes

1. **Device ID:** Cada dispositivo tiene un ID único generado automáticamente
2. **Persistencia:** Datos se guardan localmente (IndexedDB) Y en Firebase
3. **Offline:** App funciona offline, sincroniza cuando hay conexión
4. **Tiempo Real:** Cada acción se refleja en Firebase < 2 segundos
5. **Sin Descarga:** Exportar ya NO descarga JSON, solo guarda en Firebase

---

**Última actualización:** 2026-01-27 22:30  
**Versión:** 2.0.0 (Firebase Real-Time)
