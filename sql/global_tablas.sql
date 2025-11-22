-- ==========================================================
-- ARKEHON — Global Tables (Catálogos Universales)
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS global;

-- ==========================================
-- 1. Tabla de Unidades
-- ==========================================
CREATE TABLE IF NOT EXISTS global.unidades (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,             -- Ej: kilogramo, metro cúbico
  abreviatura TEXT NOT NULL,        -- Ej: kg, m3
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 2. Tabla de Categorías (Opcional pero útil)
-- ==========================================
CREATE TABLE IF NOT EXISTS global.categorias (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,             -- Ej: Acero, Cemento, Agregados
  descripcion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 3. Tabla de Proveedores
-- ==========================================
CREATE TABLE IF NOT EXISTS global.proveedores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,
  contacto TEXT,
  telefono TEXT,
  email TEXT,
  direccion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 4. Tabla de Materiales Base
-- ==========================================
CREATE TABLE IF NOT EXISTS global.materiales_base (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  codigo TEXT,                      -- Código del material (opcional)
  nombre TEXT NOT NULL,             -- Ej: Acero corrugado
  categoria_id UUID REFERENCES global.categorias(id),
  unidad_base_id UUID REFERENCES global.unidades(id), 
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 5. Tabla de Presentaciones de Material
-- ==========================================
CREATE TABLE IF NOT EXISTS global.materiales_presentacion (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  material_id UUID REFERENCES global.materiales_base(id),
  nombre_presentacion TEXT NOT NULL,  -- Ej: Barra 1/2", Bolsa 50kg
  unidad_mercado_id UUID REFERENCES global.unidades(id),
  contiene NUMERIC,                   -- Cantidad que contiene (ej: 50kg)
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================================
-- FIN DEL ARCHIVO
-- ==========================================================
