# ARKEHON — System Overview

Arkheon es un sistema modular diseñado para gestionar todo el ciclo de vida de proyectos de construcción, integrando presupuesto, control de obra, compras e inventario en una plataforma unificada.

Este documento resume la arquitectura general del sistema, sus módulos y sus interrelaciones.

---

## 🟥 1. Visión General
Arkheon es un sistema modular inspirado en DDD, dividido en:
- **Global** — catálogos universales (unidades, materiales base, categorías)
- **Presupuesto** — información teórica del proyecto
- **Obra** — operación real del proyecto

Cada módulo vive en un schema independiente.

---

## 🟧 2. Módulo Obra (Control de Obra)

El módulo OBRA ahora está estructurado en 5 dominios escalables:

### 1. `obra_general`
Datos base:
- obras
- estado
- historial

### 2. `obra_economia`
Economía de obra:
- inventarios (materiales, suministros, herramientas, maquinaria)
- adquisiciones (compras, detalle, pagos)
- proveedores (catálogo + asignación por obra)
- presentaciones de materiales
- envíos a obra
- inversiones
- histórico

### 3. `obra_ejecucion`
Ejecución física:
- avances
- subcontratos
- consumos (material, MO, equipos)

### 4. `obra_balance`
Análisis y consolidación:
- flujo de fondos
- balances
- KPIs

### 5. `obra_utilidades`
Herramientas internas:
- parámetros
- plantillas
- reportes

### M02 – Control de Obra
#### M02_02 – Inventario
- Vista general del stock real de la obra.
- Fase 1: solo lectura (no permite modificaciones).
- Requiere el estado global `state_obra_id`.
- Datos divididos en: materiales, suministros, maquinaria y herramientas.

## Estructura UI del Módulo OBRA en Retool

La interfaz de Control de Obra en Retool se organiza en cinco dominios, reflejando la arquitectura de datos:

- M02_00_General
- M02_01_Economia
- M02_02_Ejecucion
- M02_03_Balance
- M02_04_Utilidades

Cada dominio contiene queries con prefijos jerárquicos:

Ejemplo:
M02_01_01_query_inventario_material

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
