# ARKEHON — Integration Notes

Este documento describe cómo Arkheon se integra con Supabase, Retool, GitHub y herramientas externas.  
Su objetivo es garantizar que todas las partes del sistema trabajen juntas de manera consistente y predecible.

---

# 🟥 1. Integración con Supabase

Supabase es la base de datos principal de Arkheon.  
Se usa para:

- almacenamiento estructurado (schemas global, presupuesto, obra)
- permisos y roles
- ejecución de SQL
- autenticación (si aplica)
- almacenamiento de archivos (storage)

## 1.1 Conexión desde Retool
En Retool:

1. Ir a **Resources → Create New**  
2. Seleccionar **PostgreSQL**  
3. Configurar:
   - Host: el host de Supabase  
   - Database: `postgres`  
   - User: el de tu proyecto  
   - Password: la clave de tu proyecto  
   - SSL: ON  

4. Guardar como recurso:  
arkheon_supabase

markdown
Copiar código

## 1.2 Ejecución de SQL del repositorio
Todos los archivos SQL del directorio `/sql` pueden aplicarse en Supabase con:

- SQL Editor Web  
- CLI de Supabase  
- o pgAdmin

Orden recomendado:

1. `global_tablas.sql`  
2. `presupuesto_tablas.sql`  
3. `obra_tablas.sql`  

---

# 🟦 2. Integración con Retool

Retool es la UI donde vive Arkheon.

## 2.1 Estructura recomendada
Cada módulo debe ser una app separada:

- `M01_Presupuesto`  
- `M02_Control_de_Obra`  
- futuro: `M03_Finanzas`, etc.

Dentro de cada app:

- un contenedor principal por submódulo  
- botones de navegación  
- queries manuales solo cuando son necesarios  
- queries desactivadas en "Run on load"

## 2.2 Nomenclatura recomendada
Queries:
query_inventario_material
query_proveedores
query_compras
query_presentaciones

makefile
Copiar código

Componentes:
inventario_container
proveedores_container
adquisiciones_container
presentaciones_container

csharp
Copiar código

## 2.3 Ejecución de queries
Nunca ejecutar queries automáticamente.  
Deben correr:

- cuando el usuario selecciona la obra  
- cuando navega a un submódulo  
- cuando presiona un botón (crear, guardar, actualizar)

Scripts base:

```js
inventario_container.setHidden(true);
proveedores_container.setHidden(true);

inventario_container.setHidden(false);
query_inventario_material.trigger();
🟩 3. Integración con Excel / CSV
Arkheon usa Excel en 2 casos:

Importación inicial de inventario desde Prescom

Carga masiva de datos de apoyo

3.1 Reglas para importación
El Excel debe:

tener encabezados claros

evitar comas como separadores decimales (usar punto)

usar texto para códigos de materiales

no incluir fórmulas

no incluir filas vacías

3.2 Flujo recomendado
Limpiar Excel

Convertir a CSV UTF-8

Importar en Supabase con “Table Editor → Import Data”

Convertir tipos de columna después de la carga

Asignar obra_id manualmente en bulk:

sql
Copiar código
UPDATE obra.inventario_material
SET obra_id = 'xxxxx-uuid'
WHERE obra_id IS NULL;
🟧 4. Integración con GitHub
GitHub es el repositorio oficial del Blueprint (no del código final).
Aquí vive:

documentación técnica

SQL estructural

estándares de desarrollo

diagramas

definiciones de UI

4.1 Estructura
sql
Copiar código
docs/
sql/
README.md
4.2 Uso para IA
Las IAs deben recibir el link al repositorio cuando:

necesiten generar SQL

crear nuevas tablas

entender flujos de Arkheon

proponer mejoras de UI o integraciones

Siempre deben trabajar siguiendo tu documentación.

🟨 5. Integración entre módulos
5.1 Global → Obra
Relaciones clave:

materiales_base

unidades

proveedores

5.2 Presupuesto → Obra
Solo una relación:

cantidad_presupuestada es la referencia

Ningún dato del presupuesto debe alterarse desde obra.

5.3 Obra → Análisis
Las compras y consumos alimentan:

análisis de costos reales

reportes

variaciones vs presupuesto

🟪 6. Integración con otras IAs
Reglas para cualquier IA que use este entorno:

Debe leer la documentación antes de generar código.

No debe crear tablas nuevas sin justificarlas.

Debe respetar los schemas:

global.

presupuesto.

obra.

Si detecta inconsistencias, debe consultarte antes de ejecutar cambios.

Todos los ejemplos deben basarse en:

api_queries.md

data_dictionary.md

workflows.md

FIN DEL DOCUMENTO.
