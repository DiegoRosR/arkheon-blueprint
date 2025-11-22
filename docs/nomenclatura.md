# ARKEHON — Nomenclatura Oficial (Resumen Profesional)

Este documento define las reglas **mínimas, claras y obligatorias** para los nombres en Arkheon.  
Aplican a: schemas, tablas, columnas, relaciones y variables internas.

---

## 1. Schemas (Dominios)
Los schemas representan módulos del negocio.

**Reglas**
- Todo en minúsculas
- Sin espacios, acentos ni mayúsculas

## Schemas oficiales
```
global
presupuesto
obra_general
obra_economia
tabla_ejecucion
obra_balance
obra_utilidades
```

## Tablas
Formato obligatorio:
```
<dominio>_<subdominio>_<funcion>
```

Ejemplos reales:
```
obra_general_obras
obra_economia_inventario_material
obra_economia_inventario_suministro
obra_economia_inventario_maquinaria
obra_economia_inventario_herramientas
obra_economia_proveedores_catalogo
obra_economia_proveedores
obra_economia_presentacion_material
```

## Columnas
- Siempre minúsculas
- Nunca camelCase
- FK siempre con `_id`

---

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

