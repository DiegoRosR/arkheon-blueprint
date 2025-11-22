-- ==========================================================
-- ARKEHON — Módulo de Obra (Control Real de Proyecto)
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS obra;

-- ==========================================
-- 1. Tabla de Obras
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.obras (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,
  codigo TEXT,
  ubicacion TEXT,
  fecha_inicio DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 2. Proveedores asignados a una obra
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.obra_proveedores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  obra_id UUID REFERENCES obra.obras(id) ON DELETE CASCADE,
  proveedor_id UUID REFERENCES global.proveedores(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 3. Inventario de Material por Obra
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.inventario_material (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  obra_id UUID REFERENCES obra.obras(id) ON DELETE CASCADE,
  material_id UUID REFERENCES global.materiales_base(id),
  cantidad_presupuestada NUMERIC,
  cantidad_real NUMERIC DEFAULT 0,
  unidad_base_id UUID REFERENCES global.unidades(id), 
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ===============================================================
-- 4. Presentaciones de Material para Obra (unidad de mercado real)
-- ===============================================================
CREATE TABLE IF NOT EXISTS obra.materiales_presentacion_obra (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  obra_id UUID REFERENCES obra.obras(id) ON DELETE CASCADE,
  material_id UUID REFERENCES global.materiales_base(id),
  nombre_presentacion TEXT NOT NULL,
  unidad_mercado_id UUID REFERENCES global.unidades(id),
  contiene NUMERIC NOT NULL,     -- conversión a unidad base
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 5. Compras (Cabecera)
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.compras (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  obra_id UUID REFERENCES obra.obras(id) ON DELETE CASCADE,
  proveedor_id UUID REFERENCES global.proveedores(id),
  fecha DATE NOT NULL,
  observacion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 6. Compras Detalle (Ítems)
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.compras_detalle (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  compra_id UUID REFERENCES obra.compras(id) ON DELETE CASCADE,
  presentacion_id UUID REFERENCES obra.materiales_presentacion_obra(id),
  cantidad_mercado NUMERIC NOT NULL,      -- ejemplo: 10 bolsas de 50kg
  precio_unitario NUMERIC NOT NULL,
  subtotal NUMERIC NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 7. Ejecución Real de Material (Consumos)
-- ==========================================
CREATE TABLE IF NOT EXISTS obra.ejecucion_material (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  obra_id UUID REFERENCES obra.obras(id) ON DELETE CASCADE,
  material_id UUID REFERENCES global.materiales_base(id),
  cantidad_consumida NUMERIC NOT NULL,
  fecha DATE NOT NULL,
  responsable TEXT,
  observacion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================================
-- FIN DEL ARCHIVO
-- ==========================================================
