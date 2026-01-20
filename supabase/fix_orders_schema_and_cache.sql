-- ============================================
-- FIX ORDER SCHEMA AND RELOAD CACHE (UPDATED)
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Ensure promo_codes table exists
CREATE TABLE IF NOT EXISTS promo_codes (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  code TEXT NOT NULL UNIQUE,
  discount_type TEXT NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value DECIMAL(10, 2) NOT NULL,
  min_purchase_amount DECIMAL(10, 2) DEFAULT 0,
  max_discount_amount DECIMAL(10, 2),
  start_date TIMESTAMPTZ,
  end_date TIMESTAMPTZ,
  usage_limit INTEGER,
  usage_count INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Ensure orders table has ALL required columns
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS courier_id UUID, -- Fixes "Could not find 'courier_id'"
ADD COLUMN IF NOT EXISTS shipping_location TEXT,
ADD COLUMN IF NOT EXISTS promo_code_id UUID REFERENCES promo_codes(id),
ADD COLUMN IF NOT EXISTS promo_code TEXT,
ADD COLUMN IF NOT EXISTS discount_applied DECIMAL(10, 2) DEFAULT 0;

-- 3. CRITICAL: Force schema cache reload
-- This fixes the "PGRST204" or "schema cache" errors
NOTIFY pgrst, 'reload schema';
