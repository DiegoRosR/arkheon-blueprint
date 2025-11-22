# ARKEHON — UI Layout Oficial (Retool)

Este documento define la estructura visual estándar de Arkheon.  
Su objetivo es mantener una interfaz consistente, ordenada y escalable en todos los módulos.

---

# 🟥 1. Estructura General de la UI

Todos los módulos deben cumplir con:

- Un **encabezado superior** con:
  - Nombre del módulo  
  - Selector de obra (si aplica)  
  - Botones principales (Guardar, Crear, Exportar)  

- Un **panel lateral izquierdo (opcional)** para navegación interna.

- Un **área principal** donde viven los contenedores.

- # Estructura Oficial del Módulo OBRA en la UI

La UI debe seguir la estructura jerárquica:

General → Economía → Ejecución → Balance → Utilidades

Los contenedores deben nombrarse según:

obra_economia_inventario_container
obra_economia_proveedores_container
obra_economia_adquisiciones_container

Y cada contenedor ejecuta las queries:

M02_01_01_query_*
M02_01_02_query_*
...


---

# 🟦 2. Nomenclatura de Contenedores

Para mantener orden, los contenedores deben nombrarse así:

{modulo}_{submodulo}_container

markdown
Copiar código

Ejemplos:

- `inventario_container`
- `proveedores_container`
- `adquisiciones_container`
- `maquinaria_container`

El nombre debe reflejar el contenido y su submódulo directo.

---

# 🟩 3. Componente Principal: Botonera Superior

Se recomienda reemplazar Tabs de Retool por botones para mayor control.

Botones estándar:

- Inventario  
- Proveedores  
- Presentaciones  
- Adquisiciones  
- Maquinaria  
- Herramientas  

Acciones:

- Cada botón ejecuta un script que:
  - Oculta todos los contenedores  
  - Muestra solo el contenedor seleccionado  
  - Ejecuta el query correspondiente

Script base sugerido:

```js
// Ocultar todo
inventario_container.setHidden(true);
proveedores_container.setHidden(true);
adquisiciones_container.setHidden(true);
maquinaria_container.setHidden(true);
herramientas_container.setHidden(true);

// Mostrar el contenedor actual
{{container}}.setHidden(false);

// Correr la consulta
{{query}}.trigger();
🟨 4. Estructura Estándar por Submódulo
4.1 Inventario
Componentes recomendados:

Table: materiales inventariados

Button: "Agregar desde Excel"

Button: "Agregar Manual"

Button: "Actualizar Cantidades"

Drawer o Modal para editar una fila

Layout:

css
Copiar código
Inventario_container
 ├─ Header (Título + botones)
 ├─ Tabla de inventario
 └─ Modal de edición
4.2 Proveedores
Componentes:

Table: proveedores asignados

Multiselect: lista global de proveedores

Button: "Agregar proveedor a obra"

Button: "Eliminar proveedor"

Layout:

pgsql
Copiar código
Proveedores_container
 ├─ Header
 ├─ Lista Global (Multiselect)
 ├─ Botón agregar
 ├─ Tabla de proveedores asignados
4.3 Presentaciones de Material
Componentes:

Dropdown de material base

Fields: presentación, unidad mercado, contiene

Button: "Crear presentación"

Tabla de presentaciones existentes

Layout:

css
Copiar código
Presentaciones_container
 ├─ Header
 ├─ Formulario de creación
 └─ Tabla de presentaciones existentes
4.4 Adquisiciones (Compras)
Componentes:

Dropdown Proveedor

Date Picker

Table para ítems

Button: "Registrar compra"

Table: compras históricas

Layout:

css
Copiar código
Adquisiciones_container
 ├─ Header
 ├─ Formulario cabecera compra
 ├─ Tabla de detalle (editable)
 └─ Tabla de compras realizadas
🟧 5. Estándares de UI
Todas las tablas deben tener:

filtros

paginación

búsqueda

Todos los formularios deben validar campos obligatorios.

Se deben evitar tabs internos complejos.

Cada contenedor debe tener máximo 1 función principal.

Los nombres de botones deben ser simples y explícitos:

"Crear proveedor"

"Registrar compra"

"Agregar material"

🟥 6. Reglas para Nuevas Pantallas
Siempre incluir header con título.

Los contenedores deben comenzar ocultos.

Las consultas deben ejecutarse solo cuando se selecciona el submódulo.

Todo contenido editable debe estar dentro de un modal, drawer o form.

Evitar scripts largos en la UI; usar JS blocks si es necesario.

FIN DEL DOCUMENTO.
