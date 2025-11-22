-- ==========================================================
-- ARKEHON — Módulo de Presupuesto (Tablas Base)
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS presupuesto;

-- ==========================================
-- 1. Tabla de Unidades (solo para presupuesto)
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.unidades (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nombre TEXT NOT NULL,
  abreviatura TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 2. Materiales del Presupuesto
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.materiales (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  codigo TEXT,
  nombre TEXT NOT NULL,
  unidad_id UUID REFERENCES presupuesto.unidades(id),
  precio_unitario NUMERIC,           -- PU del material
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 3. Mano de Obra del Presupuesto
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.mano_obra (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  codigo TEXT,
  nombre TEXT NOT NULL,
  unidad_id UUID REFERENCES presupuesto.unidades(id),
  rendimiento NUMERIC,               -- rendimiento h/H
  precio_unitario NUMERIC,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 4. Equipos del Presupuesto
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.equipos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  codigo TEXT,
  nombre TEXT NOT NULL,
  unidad_id UUID REFERENCES presupuesto.unidades(id),
  precio_unitario NUMERIC,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 5. Partidas del Presupuesto
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.partidas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  codigo TEXT NOT NULL,
  descripcion TEXT NOT NULL,
  unidad_id UUID REFERENCES presupuesto.unidades(id),
  cantidad NUMERIC,
  precio_unitario NUMERIC,
  precio_total NUMERIC,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 6. Insumos por Partida
-- ==========================================
CREATE TABLE IF NOT EXISTS presupuesto.partidas_insumos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  partida_id UUID REFERENCES presupuesto.partidas(id),
  tipo TEXT NOT NULL,                  -- material / mo / equipo
  insumo_id UUID NOT NULL,             -- depende de tipo
  cantidad NUMERIC NOT NULL,
  rendimiento NUMERIC,                 -- opcional
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================================
-- FIN DEL ARCHIVO
-- ==========================================================
