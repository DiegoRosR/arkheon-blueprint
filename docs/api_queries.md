# ARKEHON — API Queries (Ejemplos Base)

Este documento contiene ejemplos de consultas SQL organizadas por módulo.  
Todas están basadas en la arquitectura oficial de Arkheon.

---

# 🟦 1. MÓDULO GLOBAL

## 1.1 Obtener todos los proveedores
```sql
SELECT * FROM global.proveedores ORDER BY nombre;+

1.2 Insertar un proveedor

INSERT INTO global.proveedores (nombre, contacto, telefono, email, direccion)
VALUES ('Proveedor X', 'Juan Pérez', '78900000', 'proveedor@mail.com', 'Av. Siempre Viva 123');

1.3 Obtener materiales base
SELECT 
  mb.id,
  mb.codigo,
  mb.nombre,
  c.nombre AS categoria,
  u.abreviatura AS unidad
FROM global.materiales_base mb
LEFT JOIN global.categorias c ON c.id = mb.categoria_id
LEFT JOIN global.unidades u ON u.id = mb.unidad_base_id;

🟩 2. MÓDULO PRESUPUESTO
2.1 Obtener partidas con su unidad
SELECT 
  p.id,
  p.codigo,
  p.descripcion,
  u.abreviatura AS unidad,
  p.cantidad,
  p.precio_unitario,
  p.precio_total
FROM presupuesto.partidas p
LEFT JOIN presupuesto.unidades u ON u.id = p.unidad_id
ORDER BY p.codigo;

2.2 Obtener insumos de una partida
SELECT
  pi.id,
  pi.tipo,
  pi.cantidad,
  pi.rendimiento,
  pi.insumo_id
FROM presupuesto.partidas_insumos pi
WHERE pi.partida_id = {{ partida_id }};

2.3 Insertar partida
INSERT INTO presupuesto.partidas (codigo, descripcion, unidad_id, cantidad, precio_unitario, precio_total)
VALUES ('A-01', 'Excavación manual', 'unidad_uuid', 10, 50, 500);

🟧 3. MÓDULO OBRA
3.1 Obtener proveedores asignados a una obra
SELECT 
  op.id,
  p.nombre AS proveedor,
  p.telefono,
  p.email
FROM obra.obra_proveedores op
JOIN global.proveedores p ON p.id = op.proveedor_id
WHERE op.obra_id = {{ obra_id }};

3.2 Asignar un proveedor a una obra
INSERT INTO obra.obra_proveedores (obra_id, proveedor_id)
VALUES ({{ obra_id }}, {{ proveedor_id }});

3.3 Obtener inventario de materiales de una obra
SELECT
  im.id,
  mb.nombre AS material,
  im.cantidad_presupuestada,
  im.cantidad_real,
  u.abreviatura AS unidad
FROM obra.inventario_material im
JOIN global.materiales_base mb ON mb.id = im.material_id
JOIN global.unidades u ON u.id = im.unidad_base_id
WHERE im.obra_id = {{ obra_id }}
ORDER BY mb.nombre;

3.4 Registrar presentación de material
INSERT INTO obra.materiales_presentacion_obra 
  (obra_id, material_id, nombre_presentacion, unidad_mercado_id, contiene)
VALUES 
  ({{ obra_id }}, {{ material_id }}, {{ nombre_presentacion }}, {{ unidad_mercado_id }}, {{ contiene }});

3.5 Registrar compra (cabecera)
INSERT INTO obra.compras (obra_id, proveedor_id, fecha, observacion)
VALUES ({{ obra_id }}, {{ proveedor_id }}, {{ fecha }}, {{ observacion }})
RETURNING id;

3.6 Registrar compra (detalle)
INSERT INTO obra.compras_detalle
  (compra_id, presentacion_id, cantidad_mercado, precio_unitario, subtotal)
VALUES
  ({{ compra_id }}, {{ presentacion_id }}, {{ cantidad }}, {{ precio_unitario }}, {{ subtotal }});

3.7 Registrar consumo de material
INSERT INTO obra.ejecucion_material
  (obra_id, material_id, cantidad_consumida, fecha, responsable, observacion)
VALUES
  ({{ obra_id }}, {{ material_id }}, {{ cantidad }}, {{ fecha }}, {{ responsable }}, {{ observacion }});

🟥 4. QUERIES AVANZADOS
4.1 Costo real acumulado de un material
SELECT 
  SUM(subtotal) AS costo_total,
  SUM(cantidad_mercado * contiene) AS cantidad_base_total
FROM obra.compras_detalle cd
JOIN obra.materiales_presentacion_obra mpo ON mpo.id = cd.presentacion_id
JOIN obra.compras c ON c.id = cd.compra_id
WHERE c.obra_id = {{ obra_id }}
  AND mpo.material_id = {{ material_id }};

4.2 Estado real del inventario
SELECT 
  mb.nombre,
  im.cantidad_presupuestada,
  im.cantidad_real,
  (im.cantidad_real - im.cantidad_presupuestada) AS diferencia
FROM obra.inventario_material im
JOIN global.materiales_base mb ON mb.id = im.material_id
WHERE im.obra_id = {{ obra_id }};


FIN DEL DOCUMENTO.
