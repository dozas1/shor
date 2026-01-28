# 🧪 Prueba de SHOR con Firestore

## 📋 Plan de Prueba

### **Paso 1: Abrir la App**
- URL: https://dozas1.github.io/shor/
- Verificar que carga correctamente
- Verificar que el botón de instalación es ROJO

### **Paso 2: Registrar Usuario**
- Nombre: `Test Usuario`
- Rol: `Operativo`
- Clic en "Comenzar"
- **Esperado:** Debe aparecer pantalla principal con "Hola, Test Usuario"

### **Paso 3: Guardar Notas de Prueba**

**Nota 1 - Texto:**
- Clic en "✏️ Escribir nota"
- Texto: `Primera nota de prueba - verificando Firestore`
- Guardar
- **Esperado:** Aparece en "Registros de hoy"

**Nota 2 - Voz (si funciona):**
- Clic en "🎤 Dictar nota por voz"
- Dictar: `Segunda nota por voz para validar guardado`
- **Esperado:** Aparece transcripción en tiempo real

**Nota 3 - Skip:**
- Clic en "⏭️ Nada relevante hoy"
- **Esperado:** Aparece registro de tipo "skip"

### **Paso 4: Verificar en Consola del Navegador**

**Abrir DevTools:**
- F12 o Clic derecho → Inspeccionar
- Pestaña "Console"

**Buscar logs:**
```
[Firestore] Inicializado correctamente
[Firestore] Device ID: device_...
[Firestore] Persona guardada
[Firestore] Registro guardado en tiempo real: reg_...
```

**Errores a buscar:**
```
❌ Missing or insufficient permissions
❌ Error al guardar en Firestore
```

### **Paso 5: Verificar en Firestore Console**

**URL:** https://console.firebase.google.com/project/shor-pwa/firestore

**Pestaña "Datos":**

**Colección `users`:**
```
📁 users/
  └── device_[timestamp]_[random]/
      ├── persona: {
      │   id: "persona_...",
      │   nombre: "Test Usuario",
      │   rol: "Operativo",
      │   createdAt: "2026-01-27T..."
      │ }
      ├── registros: []
      └── lastSync: "2026-01-27T..."
```

**Colección `registros`:**
```
📁 registros/
  └── device_[timestamp]_[random]/
      └── items/
          ├── reg_[timestamp]_[random]/
          │   ├── id: "reg_..."
          │   ├── tipo: "texto"
          │   ├── contenido: "Primera nota de prueba..."
          │   ├── fecha: "2026-01-27"
          │   ├── timestamp: "2026-01-27T..."
          │   └── personaId: "persona_..."
          └── reg_[timestamp2]_[random2]/
              └── ...
```

---

## ✅ Checklist de Validación

### **Frontend (Navegador)**
- [ ] App carga sin errores
- [ ] Botón de instalación es ROJO
- [ ] Registro de usuario funciona
- [ ] Pantalla principal aparece después de registro
- [ ] Notas se guardan localmente (aparecen en lista)
- [ ] No hay errores en consola

### **Firestore (Backend)**
- [ ] Colección `users` existe
- [ ] Documento con `deviceId` existe
- [ ] Campo `persona` tiene datos correctos
- [ ] Colección `registros` existe
- [ ] Subcolección `items` tiene las notas guardadas
- [ ] Cada nota tiene todos los campos requeridos

### **Permisos**
- [ ] No aparece error "Missing or insufficient permissions"
- [ ] Reglas de Firestore están publicadas
- [ ] Modo de prueba está activo (30 días)

---

## 🔍 Comandos de Verificación

### **Verificar en Consola del Navegador:**
```javascript
// Ver deviceId
localStorage.getItem('deviceId')

// Ver persona guardada
const db = firebase.firestore();
db.collection('users').get().then(snapshot => {
  snapshot.forEach(doc => console.log(doc.id, doc.data()));
});

// Ver registros
db.collection('registros').get().then(snapshot => {
  snapshot.forEach(doc => {
    console.log(doc.id);
    doc.ref.collection('items').get().then(items => {
      items.forEach(item => console.log(item.data()));
    });
  });
});
```

---

## 📊 Resultados Esperados

### **Éxito Total:**
- ✅ Usuario registrado
- ✅ 3 notas guardadas localmente
- ✅ 3 notas guardadas en Firestore
- ✅ Sin errores de permisos
- ✅ Datos visibles en Firestore Console

### **Éxito Parcial:**
- ✅ Usuario registrado
- ✅ Notas guardadas localmente
- ❌ Error de permisos en Firestore
- **Solución:** Configurar reglas en Firestore Console

### **Fallo:**
- ❌ App no carga
- ❌ Errores de JavaScript
- ❌ No se guarda nada
- **Solución:** Revisar consola del navegador para detalles

---

## 🚀 Ejecutar Prueba

1. Abre: https://dozas1.github.io/shor/
2. Abre DevTools (F12)
3. Sigue los pasos 1-3
4. Revisa consola (Paso 4)
5. Revisa Firestore Console (Paso 5)
6. Marca checklist de validación

**Tiempo estimado:** 5 minutos
