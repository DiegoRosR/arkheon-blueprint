# ARKEHON — Nomenclatura Oficial (Resumen Profesional)

Este documento define las reglas **mínimas, claras y obligatorias** para los nombres en Arkheon.  
Aplican a: schemas, tablas, columnas, relaciones y variables internas.

---

## 1. Schemas (Dominios)
Los schemas representan módulos del negocio.

**Reglas**
- Todo en minúsculas
- Sin espacios, acentos ni mayúsculas

**Schemas utilizados**
global
presupuesto
obra
obra_inventario
obra_proveedores
obra_adquisiciones
obra_presentaciones
obra_costos

---

## 2. Tablas
Formato obligatorio:

<dominio><subdominio><funcion>


**Ejemplos correctos**

obra_inventario_material
obra_proveedores_relacion
global_materiales_base
presupuesto_partidas_insumos


**Reglas**
- Minúsculas
- Descriptivas
- Sin abreviaturas confusas
- Separadas por guion bajo

---

## 3. Columnas
Formato obligatorio:

nombre_simple


**Campos estándar**

id uuid primary key
created_at timestamptz default now()
updated_at timestamptz default now()


**Claves foráneas**

obra_id
proveedor_id
material_id
partida_id
presentacion_id


**Reglas**
- Minúsculas
- No camelCase
- No prefijos automáticos como fk_

---

## 4. Relaciones
Reglas:

1. La tabla “hija” contiene el `_id`.
2. El nombre del campo coincide con la tabla padre.
3. Relaciones explícitas, sin abreviaturas.

**Ejemplo correcto**

obra_id references obra.obras(id)


---

## 5. Variables internas (Retool)
Formato:

nombre_descriptivo

**Ejemplos**

obra_seleccionada
query_inventario_material
button_agregar_proveedor
input_buscar_material


**Incorrecto**

btn1
obraSelect
x


---

## 6. Archivos del repositorio
**/docs/** → documentación  
**/sql/** → scripts SQL  
**/diagrams/** → diagramas  
**/examples/** → ejemplos diversos

Nombres en minúsculas, sin espacios:

nomenclatura.md
reglas_negocio.md
workflows.md


---

FIN DEL DOCUMENTO.

