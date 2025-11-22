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

## Módulo Obra — Nuevo diseño

### 📁 obra_general
**obra_general_obras**
- id
- nombre
- codigo
- ubicacion
- fecha_inicio
- created_at
- updated_at

---

### 📁 obra_economia

**obra_economia_proveedores_catalogo**
- id
- nombre
- contacto
- telefono
- email
- direccion
- created_at
- updated_at

**obra_economia_proveedores**
- id
- obra_id
- proveedor_catalogo_id
- created_at
- updated_at

**obra_economia_inventario_material**
- id
- obra_id
- material_id
- cantidad_presupuestada
- cantidad_real
- created_at
- updated_at

**obra_economia_inventario_suministro**
- id
- obra_id
- suministro (text)
- cantidad_presupuestada
- cantidad_real
- unidad_id
- created_at
- updated_at

**obra_economia_inventario_maquinaria**
- id
- obra_id
- maquinaria (text)
- cantidad_total
- estado
- created_at
- updated_at

**obra_economia_inventario_herramientas**
- id
- obra_id
- herramienta
- cantidad_total
- estado
- created_at
- updated_at

**obra_economia_presentacion_material**
- id
- obra_id
- material_id
- nombre_presentacion
- unidad_mercado_id
- contiene
- created_at
- updated_at

---

FIN DEL DOCUMENTO.
