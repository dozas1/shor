# 🔧 Configurar Permisos de Firestore

## ❌ Error Actual

```
Error al guardar en Firestore: Missing or insufficient permissions.
```

**Causa:** Firestore requiere reglas de seguridad configuradas para permitir lectura/escritura.

---

## ✅ Solución: Configurar Reglas de Seguridad

### **Paso 1: Ir a la Consola de Firebase**

1. Abre: https://console.firebase.google.com/project/shor-pwa/firestore
2. En el menú lateral, selecciona **"Firestore Database"**
3. Si no existe la base de datos, créala:
   - Clic en "Crear base de datos"
   - Selecciona "Iniciar en modo de prueba" (permite lectura/escritura por 30 días)
   - Selecciona ubicación: `us-central` o la más cercana
   - Clic en "Habilitar"

### **Paso 2: Configurar Reglas de Seguridad**

1. En Firestore Database, ve a la pestaña **"Reglas"**
2. Reemplaza las reglas actuales con:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Permitir lectura y escritura a todos (modo desarrollo)
    match /{document=**} {
      allow read, write: true;
    }
  }
}
```

3. Clic en **"Publicar"**

### **Paso 3: Verificar que Funciona**

1. Abre https://dozas1.github.io/shor/
2. Registra un usuario (nombre + rol)
3. Guarda una nota
4. **NO debe aparecer error de permisos** ✅
5. Verifica en Firestore Console que los datos se guardaron:
   - Ve a pestaña "Datos"
   - Deberías ver colecciones: `users`, `registros`, `exports`

---

## 🔒 Reglas de Producción (Opcional - Más Seguras)

**Para producción, usa reglas más restrictivas:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Usuarios: cualquiera puede leer/escribir su propio documento
    match /users/{deviceId} {
      allow read, write: true;
    }
    
    // Registros: cualquiera puede leer/escribir
    match /registros/{deviceId}/{document=**} {
      allow read, write: true;
    }
    
    // Exports: cualquiera puede leer/escribir
    match /exports/{deviceId}/{document=**} {
      allow read, write: true;
    }
  }
}
```

---

## 📊 Estructura de Datos en Firestore

Después de configurar las reglas, verás esta estructura:

```
📁 Firestore Database
├── 📁 users/
│   └── device_1234567890_abc/
│       ├── persona: {id, nombre, rol}
│       ├── registros: [...]
│       └── lastSync: "2026-01-27T22:56:00Z"
│
├── 📁 registros/
│   └── device_1234567890_abc/
│       └── items/
│           ├── reg_1234567890_xyz/
│           │   ├── id: "reg_1234567890_xyz"
│           │   ├── tipo: "nota"
│           │   ├── contenido: "Texto de la nota"
│           │   ├── fecha: "2026-01-27"
│           │   └── timestamp: "2026-01-27T22:56:00Z"
│           └── ...
│
└── 📁 exports/
    └── device_1234567890_abc/
        └── reports/
            └── rep_1234567890/
                └── shor_export: {...}
```

---

## ⚠️ Importante

**Modo de prueba expira en 30 días:**
- Firebase te enviará un email de advertencia
- Antes de que expire, actualiza las reglas a las de producción
- O extiende el modo de prueba por otros 30 días

**Para este proyecto (SHOR PWA):**
- Modo de prueba es suficiente para desarrollo
- No hay autenticación de usuarios (cualquiera puede escribir)
- Considera agregar Firebase Authentication en el futuro para mayor seguridad

---

## 🚀 Resumen

1. Ve a https://console.firebase.google.com/project/shor-pwa/firestore
2. Pestaña "Reglas"
3. Pega las reglas de arriba
4. Clic en "Publicar"
5. Prueba la app nuevamente
6. ✅ Error de permisos debe desaparecer

**Tiempo estimado: 2 minutos**
