# 🏗️ ARKEHON — Blueprint Oficial  
**Sistema Integral para Presupuestos y Control de Obra**

Bienvenido al repositorio oficial del **Blueprint Maestro** de **Arkheon**, un ecosistema digital diseñado para gestionar presupuestos, control de obra, inventarios, adquisiciones y procesos constructivos de manera centralizada, escalable y profesional.

Este repositorio contiene la **arquitectura técnica**, **documentación**, **diagramas**, **scripts SQL**, y **lineamientos del sistema**.

---

## 📘 Contenido del Repositorio

arkheon-blueprint/
│
├── docs/
│ └── ARKEHON_BLUEPRINT_MASTER.md # Documento maestro (arquitectura completa)
│
├── sql/
│ └── .gitkeep # Scripts SQL (por llenar)
│
├── diagrams/
│ └── .gitkeep # Diagramas lógicos y ERD
│
├── examples/
│ └── .gitkeep # Ejemplos futuros de uso
│
└── README.md # Este archivo


---

## 🧠 ¿Qué es Arkheon?

Arkheon es una plataforma modular creada para gestionar:

- Presupuestos (insumos, mano de obra, equipos, partidas)
- Control de obra real (materiales, compras, proveedores)
- Inventarios por proyecto
- Presentaciones de materiales
- Adquisiciones y costos reales
- Proveedores globales y por obra
- Tablas globales normalizadas para toda la empresa

Su arquitectura está basada en:
- **Domain Driven Design (DDD)**
- **Esquemas por módulos**
- **Tablas limpias, normalizadas y escalables**
- **Compatibilidad con Retool + Supabase**
- Crecimiento modular sin romper compatibilidad

---

## 🗂️ Módulos Principales

### **GLOBAL**
Catálogos universales usados por todos los proyectos:
- Proveedores  
- Unidades  
- Materiales base  
- Presentaciones  
- Configuración global

### **PRESUPUESTO**
Módulo teórico del sistema:
- Partidas  
- Materiales  
- Mano de obra  
- Equipos  
- Insumos por partida  

### **OBRA**
Control real del proyecto:
- Inventario (material, insumos, maquinaria, herramientas)  
- Adquisiciones (compras, pagos, detalle de compra)  
- Presentaciones específicas por obra  
- Proveedores asociados  
- Ejecución (material, MO, equipo)  

---

## 🏷️ Estándar de Nomenclatura

- Esquemas: `global`, `presupuesto`, `obra`, `obra_inventario`  
- Tablas: `dominio_subdominio_funcion`  
- Columnas FK:  
  - `obra_id`  
  - `proveedor_id`  
  - `material_id`  
  - `partida_id`  
  - `presentacion_id`

---

## 📄 Blueprint Maestro

Toda la arquitectura detallada se encuentra en:

➡️ **/docs/ARKEHON_BLUEPRINT_MASTER.md**

Este archivo contiene:
- Diagramas
- Esquemas
- Tablas
- Relaciones
- Nomenclatura
- Reglas de negocio
- Descripción de todos los módulos

---

## 🚀 Roadmap del Proyecto

- [ ] Generación de diagramas ERD  
- [ ] Scripts SQL generados automáticamente  
- [ ] Documentación completa de flujos  
- [ ] Conexión con Retool  
- [ ] Versionado semántico  
- [ ] Integración futura con IA (automatización de compras, recomendaciones de consumo)  

---

## 👨‍💼 Autor

**Diego**  
Arquitecto · Creador de Arkheon  
Apasionado por BIM, control de obra y transformación digital.

---

## 🤝 Contribuciones

Este repositorio está pensado para crecer y evolucionar.  
Las contribuciones (futuras) serán bienvenidas a través de PRs, issues o documentación adicional.

---

## 📜 Licencia

MIT License.  
Eres libre de usar, modificar y construir sobre Arkheon.

