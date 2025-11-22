# ARKEHON — BLUEPRINT MAESTRO (v1.0)
**Arquitectura de datos oficial**  
**Autor:** Diego & ChatGPT  
**Formato:** Markdown (.md)  
**Última actualización:** 2025-11-21

---

# 📐 1. ARQUITECTURA GENERAL DE ARKEHON
Arkheon se basa en una arquitectura modular inspirada en Domain-Driven Design (DDD).  
Cada módulo del negocio vive en su propio “dominio” o schema, con responsabilidades claras.

## 🎯 Objetivos de la arquitectura
- Alto orden y claridad  
- Escalabilidad a largo plazo  
- Evitar mezclas entre módulos  
- Estándar profesional  
- Fácil mantenimiento  
- Integración limpia con Retool + Supabase  

---

# 🗂️ 2. LISTA DE SCHEMAS

## GLOBAL (catálogos universales)
- global.proveedores
- global.unidades
- global.materiales_base
- global.materiales_presentacion
- global.categorias
- global.configuracion

## PRESUPUESTO
- presupuesto.bases
- presupuesto.partidas
- presupuesto.insumos_materiales
- presupuesto.insumos_mo
- presupuesto.insumos_equipos
- presupuesto.unidades
- presupuesto.equipos
- presupuesto.materiales
- presupuesto.mano_obra

## OBRA (Control de Obra)
### obra.general
- obra.obras
- obra.estado
- obra.historial

### obra.proveedores
- obra.obra_proveedores

### obra.inventario
- obra.inventario_material
- obra.inventario_suministro
- obra.inventario_maquinaria
- obra.inventario_herramientas

### obra.presentaciones
- obra.materiales_presentacion

### obra.adquisiciones
- obra.compras
- obra.compras_detalle
- obra.compras_pago

### obra.costos
- obra.ejecucion_material
- obra.ejecucion_mo
- obra.ejecucion_equipo

---

# 🏷 3. NOMENCLATURA OFICIAL

## Esquemas
```
global
presupuesto
obra
obra_inventario
obra_proveedores
obra_adquisiciones
obra_presentaciones
```

## Tablas (formato)
```
<dominio>_<subdominio>_<funcion>
```

## Columnas estándar
```
id uuid PRIMARY KEY
created_at timestamptz DEFAULT now()
updated_at timestamptz DEFAULT now()
```

---

# 🧩 4. RELACIONES ENTRE MÓDULOS

global.materiales_base.id → obra_inventario_material.material_id  
global.proveedores.id → obra.obra_proveedores.proveedor_id  
global.materiales_presentacion.id → obra.materiales_presentacion.presentacion_id  

presupuesto.partidas.id → presupuesto.partidas_insumos.partida_id  

obra.obras.id → obra_inventario_material.obra_id  

---

# 📦 5. DESCRIPCIÓN DE TABLAS CLAVE

## global.proveedores
- id
- nombre
- contacto
- telefono
- email

## obra.obras
- id
- nombre
- codigo
- fecha_inicio
- fecha_fin
- direccion

## obra.obra_proveedores
- id
- obra_id
- proveedor_id

## obra.inventario_material
- id
- obra_id
- material_id
- cantidad_presupuestada
- cantidad_real

## obra.materiales_presentacion
- id
- material_id
- nombre_presentacion
- unidad_mercado
- contiene
- conversion_kg

---

# 📊 6. DIAGRAMA LÓGICO
```
          [global.proveedores]
                    |
                    | proveedor_id
                    |
        [obra.obra_proveedores]
                    |
                    | obra_id
                    |
              [obra.obras]
                    |
         -------------------------
         |           |           |
  [obra.inventario] [obra.adquisiciones] [obra.presentaciones]
```

---

# 🚀 FIN DEL BLUEPRINT
