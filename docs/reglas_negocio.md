# ARKEHON — Reglas de Negocio (Resumen)

Este documento define las reglas fundamentales que gobiernan el funcionamiento de Arkheon.  
Aplican a los módulos de presupuesto, obra, inventario, compras y proveedores.

---

# 1. Principios Generales

1. Arkheon distingue siempre entre:
   - **Presupuesto (teórico)**
   - **Obra (real)**

2. Los datos del presupuesto NO se modifican desde el módulo obra.

3. Los módulos operan por obra.  
   Cada obra es independiente y debe tener sus propios:
   - proveedores asignados
   - inventarios
   - presentaciones de materiales
   - compras
   - ejecuciones reales

4. Las tablas globales sirven como catálogos universales.

---

# 2. Reglas del Módulo de Presupuesto

1. El presupuesto define LO TEÓRICO:
   - cantidades estimadas
   - insumos por partida
   - rendimientos
   - materiales base
   - mano de obra base
   - equipos base

2. El presupuesto NUNCA se altera desde el control de obra.

3. La cantidad presupuestada sirve como referencia, no como valor operativo.

4. Las modificaciones del presupuesto (adicionales, deductivos, etc.) deben registrarse como versiones o ajustes controlados, no como ediciones directas.

---

# 3. Reglas del Módulo de Obra

1. Cada obra debe seleccionar sus propios proveedores desde el catálogo global.

2. Una obra solo puede comprar a proveedores asignados previamente.

3. El inventario de obra inicia con la cantidad presupuestada, pero esta puede ajustarse por:
   - compras
   - devoluciones
   - ajustes manuales autorizados

4. La cantidad real de inventario refleja:

cantidad_real = cantidad_inicial + compras - consumos


5. El avance real (costos o cantidades) nunca modifica el presupuesto original.

---

# 4. Reglas de Presentaciones de Material

1. Los materiales del presupuesto pueden tener diferentes presentaciones en obra.

2. Una presentación define:
- unidad de mercado (ej: bolsa, barra)
- contenido (ej: 50 kg)
- factor de conversión

3. Las presentaciones son específicas de cada obra.

4. Los consumos y compras deben registrarse SIEMPRE en la unidad de mercado y convertirse al material base.

---

# 5. Reglas de Proveedores

1. Todos los proveedores viven en `global.proveedores`.

2. Una obra debe elegir qué proveedores utilizará (tabla `obra_proveedores`).

3. Solo los proveedores asignados pueden aparecer en:
- compras
- cotizaciones
- órdenes de compra

---

# 6. Reglas de Compras y Costos Reales

1. Cada compra debe registrar:
- proveedor
- fecha
- ítems
- cantidades
- precios unitarios
- tipo de presentación utilizada

2. Una compra actualiza de inmediato el inventario real.

3. El precio unitario real debe calcularse con base en:

costo_total_real / cantidad_total_adquirida


4. El costo real NO reemplaza el precio del presupuesto.  
Ambos conviven para análisis.

---

# 7. Integridad del Sistema

1. No se permiten registros de inventario sin una obra asociada.

2. No se permiten compras sin proveedor asignado.

3. No se permiten presentaciones sin material base.

4. Todas las tablas deben registrar:
- id
- created_at
- updated_at

5. Las relaciones deben mantenerse consistentes según la arquitectura oficial.

---

FIN DEL DOCUMENTO.

