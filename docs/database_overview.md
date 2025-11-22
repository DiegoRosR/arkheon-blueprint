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


```
erDiagram
    obra_general_obras ||--o{ obra_economia_inventario_material : "inventario"
    obra_general_obras ||--o{ obra_economia_proveedores : "proveedores"

    obra_economia_proveedores_catalogo ||--o{ obra_economia_proveedores : "asignacion"

    obra_economia_inventario_material ||--o{ obra_economia_presentacion_material : "presentaciones"
```
