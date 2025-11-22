# ARKEHON — Development Guidelines

Este documento define las reglas oficiales de desarrollo para Arkheon.  
Su objetivo es mantener consistencia, calidad y escalabilidad en todas las contribuciones, humanas o asistidas por IA.

---

# 🟥 1. Principios Generales de Desarrollo

1. Todo cambio debe respetar la arquitectura modular:
   - global/
   - presupuesto/
   - obra/

2. Ningún módulo debe leer ni modificar datos de otro módulo innecesariamente.

3. El presupuesto es **inmutable** desde obra.

4. Todo desarrollo debe ser incremental, sin romper compatibilidad.

5. Los nombres deben ser:
   - explícitos  
   - en minúsculas  
   - separados por guiones bajos  
   - consistentes con los lineamientos  

---

# 🟦 2. Reglas para SQL

## SQL
- Cada tabla debe crearse dentro de su schema correcto.
- Tablas deben incluir:
```
id uuid default gen_random_uuid() primary key
created_at timestamptz default now()
updated_at timestamptz default now()
```
## Reglas nuevas:
- Proveedores ya **no** viven en `global`.
- Todos los proveedores viven en:
```
obra_economia_proveedores_catalogo
```
- La asignación por obra vive en:
```
obra_economia_proveedores
```
- Nuevas tablas siempre deben seguir nomenclatura oficial.

---

## 2.2 Nomenclatura de columnas
- `obra_id`, `material_id`, `proveedor_id`, etc.
- Siempre usar `_id` para FK.
- No usar camelCase.

## 2.3 Relaciones
- Usar `REFERENCES esquema.tabla(id)`
- Usar `ON DELETE CASCADE` solo donde sea seguro (obra_child → obra_parent)

## 2.4 Consultas
- Nunca usar SELECT * en código final (excepto en exploración).
- Preferir consultas limpias y explícitas.
- Siempre añadir `ORDER BY` cuando se necesite consistencia.

---

# 🟩 3. Reglas para Retool

## 3.1 Contenedores
- Cada submódulo debe tener **un contenedor principal**.
- Los contenedores deben comenzar ocultos.
- Los botones de navegación deben:
- ocultar todos los contenedores
- mostrar solo el contenedor activo
- ejecutar la query correspondiente

## 3.2 Nombres de elementos
Usar:
inventario_container
proveedores_container
adquisiciones_container
boton_guardar
query_inventario
query_proveedores
input_nombre
select_material

Evitar:
Container4
MyButton1
UntitledQuery

## 3.3 Queries
- Las queries NO deben autotrigger al cargar la app.
- Solo se ejecutan cuando el usuario navega al submódulo.

## 3.4 JavaScript
- Evitar lógica compleja en scripts inline.
- Usar JS Blocks para lógica modular.
- Documentar scripts de más de 5 líneas.

---

# 🟧 4. Reglas para IA (muy importante)

Cualquier IA que contribuya a Arkheon debe cumplir:

1. No reescribir estructuras existentes sin necesidad.
2. No crear nuevas tablas sin especificarlo y justificarlo.
3. Usar siempre los schemas:
   - `global.`
   - `presupuesto.`
   - `obra.`

4. Los nombres deben ajustarse a `nomenclatura.md`.
5. Las reglas de negocio deben respetarse siempre.
6. Cualquier propuesta de cambio estructural debe:
   - explicarse  
   - justificarse  
   - no romper compatibilidad  

7. La IA nunca debe mezclar:
   - materiales globales  
   - con materiales de obra  
   - con materiales del presupuesto  

---

# 🟨 5. Flujo correcto para crear nuevas funciones

1. Consultar documentación:  
   - `system_overview.md`  
   - `data_dictionary.md`  
   - `workflows.md`  

2. Diseñar primero la estructura:
   - ¿Va en global, presupuesto u obra?

3. Crear tabla nueva (si es necesaria):
   - En SQL → carpeta `/sql`

4. Crear queries:
   - Insert  
   - Select  
   - Update  
   - Delete  

5. Crear UI (Retool):
   - contenedor  
   - botones  
   - modales  

6. Conectar lógica:
   - triggers  
   - scripts  
   - validaciones  

7. Probar todo con datos reales.

---

# 🟫 6. Estándares de commits (opcional, recomendado)

Formato sugerido:

[modulo] Acción — descripción breve

makefile
Copiar código

Ejemplos:

[obra] add — tabla compras_detalle
[global] fix — relación de unidades
[presupuesto] update — query de partidas

---

FIN DEL DOCUMENTO.
