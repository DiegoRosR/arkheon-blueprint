# ARKEHON — Workflows (Flujos del Sistema)

Este documento define los flujos principales de Arkheon.  
Cada flujo explica el orden en que se deben ejecutar las operaciones para garantizar consistencia entre módulos.

---

# 1. Crear una Obra

**Objetivo:** Registrar un nuevo proyecto en Arkheon.

**Pasos:**
1. Registrar la obra en `obra.obras`  
   - nombre  
   - código  
   - fecha inicio  
   - dirección  

2. El sistema crea automáticamente el contenedor vacío para:  
   - inventarios  
   - proveedores asignados  
   - presentaciones  
   - compras  
   - ejecución real  

3. La obra queda disponible para selección en Retool.

---

## Asignación de proveedores (nuevo flujo)
1. Registrar proveedores globales en **obra_economia_proveedores_catalogo**.
2. Seleccionar proveedores para una obra.
3. Insertar en **obra_economia_proveedores** con `obra_id` y `proveedor_catalogo_id`.
4. Desde ahí, solo proveedores asignados pueden comprarse.

---

# 3. Importar Inventario Inicial

**Objetivo:** Crear el inventario inicial de obra basado en el presupuesto.

**Pasos:**
1. Extraer del presupuesto las cantidades teóricas (si el módulo existe).  
2. O cargar desde Excel si el presupuesto aún no está completo.  
3. Insertar en `obra.inventario_material`:  
   - material_id  
   - cantidad_presupuestada  
   - cantidad_real = cantidad_presupuestada  

4. El inventario se muestra inmediatamente en Retool.

---

# 4. Crear Presentaciones de Material

**Objetivo:** Registrar cómo se compra realmente un material.

**Pasos:**
1. Elegir un material del inventario.  
2. Definir presentación:  
   - unidad de mercado (ej. bolsa, barra, caja)  
   - contiene (ej. 50 kg, 10.66 kg, etc.)  
   - factor de conversión  
3. Registrar en `obra.materiales_presentacion`.  
4. Estas presentaciones solo afectan a la obra actual.

---

## Compras (actualizado)
- Las compras deben usar `proveedor_catalogo_id`.
- Toda compra actualiza el inventario.

---

# 6. Actualizar Inventario por Compra

**Objetivo:** Reflejar la compra en existencias reales.

**Regla: siempre ocurre automáticamente.**

**Pasos:**
1. Tomar la presentación seleccionada.  
2. Convertir la cantidad comprada a la unidad base (ej. kg).  
3. Actualizar `cantidad_real` en el inventario:

   cantidad_real = cantidad_real + cantidad_convertida


---

# 7. Registrar Consumos de Obra

**Objetivo:** Registrar cantidades utilizadas en obra.

**Pasos:**
1. Seleccionar material del inventario.  
2. Ingresar cantidad consumida (siempre en la unidad base).  
3. Actualizar inventario:  

cantidad_real = cantidad_real - consumo


4. Registrar en `obra.ejecucion_material`:
- cantidad consumida  
- fecha  
- responsable  
- observación opcional  

---

# 8. Análisis de Costos Reales

**Objetivo:** Comparar presupuesto vs realidad.

**Pasos:**
1. Tomar precio unitario real promedio:  

costo_unitario_real = costo_total_real / cantidad_total_real


2. Comparar con precio del presupuesto.  
3. Generar reportes de desviación (Costo + Cantidad).

---

FIN DEL DOCUMENTO.
