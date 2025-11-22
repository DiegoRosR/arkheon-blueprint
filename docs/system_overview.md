# ARKEHON — System Overview

Arkheon es un sistema modular diseñado para gestionar todo el ciclo de vida de proyectos de construcción, integrando presupuesto, control de obra, compras e inventario en una plataforma unificada.

Este documento resume la arquitectura general del sistema, sus módulos y sus interrelaciones.

---

# 🟥 1. Visión General

Arkheon está compuesto por 3 módulos principales:

1. **Global**  
   Catálogos universales: materiales base, proveedores, unidades, categorías.

2. **Presupuesto**  
   Información teórica del proyecto (no editable desde obra).

3. **Obra**  
   Operación real: inventario, adquisiciones, presentaciones, consumos y costos.

Cada módulo vive en su propio *schema* dentro de la base de datos.

---

# 🟦 2. Módulo Global

Contiene los catálogos que TODA obra necesita:

- **unidades**: kg, m³, bolsas, barras  
- **categorias**: acero, cemento, agregados  
- **proveedores**: base general de proveedores  
- **materiales_base**: materiales en su forma estándar  
- **materiales_presentacion**: presentaciones genéricas opcionales

Este módulo no tiene información específica de ninguna obra.  
Es la base para estandarizar todo el sistema.

---

# 🟩 3. Módulo Presupuesto

Contiene los datos teóricos del proyecto:

- unidades del presupuesto  
- materiales del presupuesto  
- mano de obra del presupuesto  
- equipos del presupuesto  
- partidas  
- insumos por partida

Reglas clave:

- La información del presupuesto **no se modifica desde obra**.  
- Sirve como punto de referencia para análisis futuros.  
- No depende de proveedores ni compras reales.

---

# 🟧 4. Módulo Obra

Es el corazón del sistema y donde ocurre la operación real:

### Incluye:
- **obras** (proyectos activos)
- **obra_proveedores** (proveedores asignados a cada obra)
- **inventario_material** (stock real y presupuestado)
- **materiales_presentacion_obra** (unidades reales de mercado)
- **compras** (cabecera)
- **compras_detalle** (ítems y subtotales)
- **ejecucion_material** (consumos reales)

Reglas clave:

- Cada obra es independiente.  
- Solo proveedores asignados pueden vender a esa obra.  
- Las compras actualizan automáticamente el inventario real.  
- Los consumos nunca afectan al presupuesto.  
- El inventario refleja siempre la realidad actual.

---

# 🟨 5. Flujo General del Sistema

1. Se crea una obra.  
2. Se asignan proveedores desde la base global.  
3. Se importa el inventario inicial desde el presupuesto (o Excel).  
4. Se crean presentaciones reales del material.  
5. Se registran compras.  
6. Las compras actualizan el inventario.  
7. Se registran consumos de obra.  
8. Se analizan costos reales vs teoría.

---

# 🟪 6. Estructura del Repositorio

arkheon-blueprint/
├── docs/
│ ├── nomenclatura.md
│ ├── reglas_negocio.md
│ ├── workflows.md
│ ├── roadmap.md
│ ├── ui_layout.md
│ ├── data_dictionary.md
│ └── system_overview.md <- este archivo
│
├── sql/
│ ├── global_tablas.sql
│ ├── presupuesto_tablas.sql
│ └── obra_tablas.sql
│
└── README.md


---

# 🟫 7. Para qué sirve este documento

- Proveer una visión rápida del sistema.  
- Ayudar a nuevas IAs o devs a entender Arkheon sin leer todo el repositorio.  
- Servir como punto de inicio para desarrollo y soporte.  

---

FIN DEL DOCUMENTO.
