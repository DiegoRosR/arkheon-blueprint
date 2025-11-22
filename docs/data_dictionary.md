# ARKEHON — Diccionario de Datos (Data Dictionary)

Este documento describe todas las tablas y columnas del sistema Arkheon.  
Su objetivo es proveer una referencia técnica clara para desarrolladores, IA y documentación futura.

---

# 🟦 1. MÓDULO GLOBAL
Tablas maestras compartidas por todos los módulos.

---

## 1.1 global.unidades
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | Identificador único |
| nombre         | TEXT       | Nombre de la unidad (kilogramo, metro cúbico) |
| abreviatura    | TEXT       | Abreviatura (kg, m3) |
| created_at     | TIMESTAMPTZ | Fecha de creación |
| updated_at     | TIMESTAMPTZ | Fecha de actualización |

---

## 1.2 global.categorias
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | Identificador único |
| nombre         | TEXT       | Nombre de la categoría (Acero, Cemento) |
| descripcion    | TEXT       | Descripción opcional |
| created_at     | TIMESTAMPTZ | Fecha de creación |
| updated_at     | TIMESTAMPTZ | Fecha de actualización |

---

## 1.3 global.proveedores
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | Identificador único |
| nombre         | TEXT       | Nombre del proveedor |
| contacto       | TEXT       | Contacto principal |
| telefono       | TEXT       | Teléfono |
| email          | TEXT       | Correo electrónico |
| direccion      | TEXT       | Dirección fiscal |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 1.4 global.materiales_base
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID del material |
| codigo         | TEXT       | Código interno |
| nombre         | TEXT       | Nombre del material base |
| categoria_id   | UUID       | FK → global.categorias |
| unidad_base_id | UUID       | FK → global.unidades |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 1.5 global.materiales_presentacion
Presentaciones genéricas (si fuesen necesarias de manera global).

| Columna           | Tipo       | Descripción |
|-------------------|------------|-------------|
| id                | UUID       | ID único |
| material_id       | UUID       | FK → materiales_base |
| nombre_presentacion | TEXT     | Ej: Bolsa 50kg |
| unidad_mercado_id | UUID       | FK → unidades |
| contiene          | NUMERIC    | Cantidad equivalente |
| created_at        | TIMESTAMPTZ | Creación |
| updated_at        | TIMESTAMPTZ | Actualización |

---

# 🟩 2. MÓDULO PRESUPUESTO
Datos teóricos — NO se modifican desde obra.

---

## 2.1 presupuesto.unidades
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID único |
| nombre         | TEXT       | Unidad |
| abreviatura    | TEXT       | Abreviatura |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 2.2 presupuesto.materiales
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| codigo         | TEXT       | Código del material |
| nombre         | TEXT       | Nombre |
| unidad_id      | UUID       | FK → presupuesto.unidades |
| precio_unitario| NUMERIC    | Valor teórico |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 2.3 presupuesto.mano_obra
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| codigo         | TEXT       | Código |
| nombre         | TEXT       | Descripción |
| unidad_id      | UUID       | FK → unidades |
| rendimiento    | NUMERIC    | Rendimiento |
| precio_unitario| NUMERIC    | Costo teórico |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 2.4 presupuesto.equipos
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| codigo         | TEXT       | Código |
| nombre         | TEXT       | Nombre |
| unidad_id      | UUID       | Unidad |
| precio_unitario| NUMERIC    | Costo teórico |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 2.5 presupuesto.partidas
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| codigo         | TEXT       | Código de partida |
| descripcion    | TEXT       | Nombre |
| unidad_id      | UUID       | Unidad |
| cantidad       | NUMERIC    | Cantidad teórica |
| precio_unitario| NUMERIC    | Precio unitario |
| precio_total   | NUMERIC    | Cantidad × PU |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 2.6 presupuesto.partidas_insumos
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| partida_id     | UUID       | FK → partidas |
| tipo           | TEXT       | material / mo / equipo |
| insumo_id      | UUID       | ID del material/mo/equipo |
| cantidad       | NUMERIC    | Cantidad teórica |
| rendimiento    | NUMERIC    | Uso o rinde |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

# 🟧 3. MÓDULO OBRA
Datos operativos — reflejan la realidad diaria.

---

## 3.1 obra.obras
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| nombre         | TEXT       | Nombre del proyecto |
| codigo         | TEXT       | Código interno |
| ubicacion      | TEXT       | Dirección |
| fecha_inicio   | DATE       | Fecha |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 3.2 obra.obra_proveedores
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| obra_id        | UUID       | FK → obras |
| proveedor_id   | UUID       | FK → global.proveedores |
| created_at     | TIMESTAMPTZ | Creación |

---

## 3.3 obra.inventario_material
| Columna                | Tipo       | Descripción |
|------------------------|------------|-------------|
| id                     | UUID       | ID |
| obra_id                | UUID       | FK → obras |
| material_id            | UUID       | FK → global.materiales_base |
| cantidad_presupuestada| NUMERIC    | Teórico |
| cantidad_real          | NUMERIC    | Existencia real |
| unidad_base_id         | UUID       | FK → global.unidades |
| created_at             | TIMESTAMPTZ | Creación |
| updated_at             | TIMESTAMPTZ | Actualización |

---

## 3.4 obra.materiales_presentacion_obra
| Columna           | Tipo       | Descripción |
|-------------------|------------|-------------|
| id                | UUID       | ID |
| obra_id           | UUID       | FK → obras |
| material_id       | UUID       | FK → materiales_base |
| nombre_presentacion | TEXT     | Ej: Barra 1/2" |
| unidad_mercado_id | UUID       | FK → unidades |
| contiene          | NUMERIC    | Equivalencia |
| created_at        | TIMESTAMPTZ | Creación |
| updated_at        | TIMESTAMPTZ | Actualización |

---

## 3.5 obra.compras
| Columna        | Tipo       | Descripción |
|----------------|------------|-------------|
| id             | UUID       | ID |
| obra_id        | UUID       | FK → obras |
| proveedor_id   | UUID       | FK → global.proveedores |
| fecha          | DATE       | Fecha de compra |
| observacion    | TEXT       | Comentario |
| created_at     | TIMESTAMPTZ | Creación |
| updated_at     | TIMESTAMPTZ | Actualización |

---

## 3.6 obra.compras_detalle
| Columna           | Tipo       | Descripción |
|-------------------|------------|-------------|
| id                | UUID       | ID |
| compra_id         | UUID       | FK → compras |
| presentacion_id   | UUID       | FK → materiales_presentacion_obra |
| cantidad_mercado  | NUMERIC    | Ej: 10 bolsas |
| precio_unitario   | NUMERIC    | Costo |
| subtotal          | NUMERIC    | Total item |
| created_at        | TIMESTAMPTZ | Creación |

---

## 3.7 obra.ejecucion_material
| Columna           | Tipo       | Descripción |
|-------------------|------------|-------------|
| id                | UUID       | ID |
| obra_id           | UUID       | FK → obras |
| material_id       | UUID       | FK → materiales_base |
| cantidad_consumida| NUMERIC    | Cantidad |
| fecha             | DATE       | Fecha |
| responsable       | TEXT       | Maestro / técnico |
| observacion       | TEXT       | Comentario |
| created_at        | TIMESTAMPTZ | Creación |

---

FIN DEL DOCUMENTO.
