# ARKEHON — Database Overview (ER Diagram)

Este documento presenta la vista general del modelo de datos de Arkheon.  
Incluye la estructura de los tres módulos principales (global, presupuesto y obra) y sus relaciones clave.

---

# 📊 Diagrama ER (Mermaid)

```mermaid
erDiagram

    %% ========================
    %% GLOBAL
    %% ========================

    global_unidades {
        UUID id PK
        TEXT nombre
        TEXT abreviatura
    }

    global_categorias {
        UUID id PK
        TEXT nombre
        TEXT descripcion
    }

    global_proveedores {
        UUID id PK
        TEXT nombre
        TEXT contacto
        TEXT telefono
        TEXT email
        TEXT direccion
    }

    global_materiales_base {
        UUID id PK
        TEXT codigo
        TEXT nombre
        UUID categoria_id FK
        UUID unidad_base_id FK
    }

    global_materiales_presentacion {
        UUID id PK
        UUID material_id FK
        TEXT nombre_presentacion
        UUID unidad_mercado_id FK
        NUMERIC contiene
    }

    global_categorias ||--o{ global_materiales_base : "categoriza"
    global_unidades ||--o{ global_materiales_base : "unidad base"
    global_unidades ||--o{ global_materiales_presentacion : "unidad mercado"
    global_materiales_base ||--o{ global_materiales_presentacion : "presentaciones"


    %% ========================
    %% PRESUPUESTO
    %% ========================

    presupuesto_unidades {
        UUID id PK
        TEXT nombre
        TEXT abreviatura
    }

    presupuesto_materiales {
        UUID id PK
        TEXT codigo
        TEXT nombre
        UUID unidad_id FK
        NUMERIC precio_unitario
    }

    presupuesto_mano_obra {
        UUID id PK
        TEXT codigo
        TEXT nombre
        UUID unidad_id FK
        NUMERIC rendimiento
        NUMERIC precio_unitario
    }

    presupuesto_equipos {
        UUID id PK
        TEXT codigo
        TEXT nombre
        UUID unidad_id FK
        NUMERIC precio_unitario
    }

    presupuesto_partidas {
        UUID id PK
        TEXT codigo
        TEXT descripcion
        UUID unidad_id FK
        NUMERIC cantidad
        NUMERIC precio_unitario
        NUMERIC precio_total
    }

    presupuesto_partidas_insumos {
        UUID id PK
        UUID partida_id FK
        TEXT tipo
        UUID insumo_id
        NUMERIC cantidad
        NUMERIC rendimiento
    }

    presupuesto_unidades ||--o{ presupuesto_materiales : "unidad"
    presupuesto_unidades ||--o{ presupuesto_mano_obra : "unidad"
    presupuesto_unidades ||--o{ presupuesto_equipos : "unidad"
    presupuesto_unidades ||--o{ presupuesto_partidas : "unidad"
    presupuesto_partidas ||--o{ presupuesto_partidas_insumos : "insumos"


    %% ========================
    %% OBRA
    %% ========================

    obra_obras {
        UUID id PK
        TEXT nombre
        TEXT codigo
        TEXT ubicacion
        DATE fecha_inicio
    }

    obra_obra_proveedores {
        UUID id PK
        UUID obra_id FK
        UUID proveedor_id FK
    }

    obra_inventario_material {
        UUID id PK
        UUID obra_id FK
        UUID material_id FK
        NUMERIC cantidad_presupuestada
        NUMERIC cantidad_real
        UUID unidad_base_id FK
    }

    obra_materiales_presentacion_obra {
        UUID id PK
        UUID obra_id FK
        UUID material_id FK
        TEXT nombre_presentacion
        UUID unidad_mercado_id FK
        NUMERIC contiene
    }

    obra_compras {
        UUID id PK
        UUID obra_id FK
        UUID proveedor_id FK
        DATE fecha
        TEXT observacion
    }

    obra_compras_detalle {
        UUID id PK
        UUID compra_id FK
        UUID presentacion_id FK
        NUMERIC cantidad_mercado
        NUMERIC precio_unitario
        NUMERIC subtotal
    }

    obra_ejecucion_material {
        UUID id PK
        UUID obra_id FK
        UUID material_id FK
        NUMERIC cantidad_consumida
        DATE fecha
        TEXT responsable
        TEXT observacion
    }

    obra_obras ||--o{ obra_obra_proveedores : "proveedores asignados"
    global_proveedores ||--o{ obra_obra_proveedores : "proveedor"

    obra_obras ||--o{ obra_inventario_material : "inventario"
    global_materiales_base ||--o{ obra_inventario_material : "material base"
    global_unidades ||--o{ obra_inventario_material : "unidad base"

    obra_obras ||--o{ obra_materiales_presentacion_obra : "presentaciones"
    global_unidades ||--o{ obra_materiales_presentacion_obra : "unidad mercado"
    global_materiales_base ||--o{ obra_materiales_presentacion_obra : "material"

    obra_obras ||--o{ obra_compras : "compras"
    global_proveedores ||--o{ obra_compras : "proveedor"

    obra_compras ||--o{ obra_compras_detalle : "detalle"
    obra_materiales_presentacion_obra ||--o{ obra_compras_detalle : "presentacion"

    obra_obras ||--o{ obra_ejecucion_material : "consumos"
    global_materiales_base ||--o{ obra_ejecucion_material : "material"
