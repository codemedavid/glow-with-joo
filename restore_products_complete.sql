-- COMPLETE RESTORATION SCRIPT - UPDATED FROM IMAGE (JAN 2026)
-- This script will:
-- 1. DROP and RECREATE tables to ensure clean schema
-- 2. Restore products exactly as per the provided image list
-- 3. Include local image URLs for all products
-- 4. Update site settings

-- ==========================================
-- 1. SCHEMA RESET (DROP AND RECREATE)
-- ==========================================

DROP TABLE IF EXISTS product_variations CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  icon TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO categories (id, name, icon, sort_order, active) VALUES
('all', 'All Products', 'Grid', 0, true),
('research', 'Research Peptides', 'FlaskConical', 1, true),
('cosmetic', 'Cosmetic & Skincare', 'Sparkles', 2, true),
('wellness', 'Wellness & Support', 'Leaf', 3, true),
('supplies', 'Supplies & Accessories', 'Package', 4, true);

CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL REFERENCES categories(id),
  base_price DECIMAL(10,2) NOT NULL,
  discount_price DECIMAL(10,2),
  discount_start_date TIMESTAMPTZ,
  discount_end_date TIMESTAMPTZ,
  discount_active BOOLEAN DEFAULT false,
  purity_percentage DECIMAL(5,2) DEFAULT 99.00,
  molecular_weight TEXT,
  cas_number TEXT,
  sequence TEXT,
  storage_conditions TEXT DEFAULT 'Store at -20°C',
  stock_quantity INTEGER DEFAULT 0,
  available BOOLEAN DEFAULT true,
  featured BOOLEAN DEFAULT false,
  image_url TEXT,
  safety_sheet_url TEXT,
  inclusions TEXT[] DEFAULT '{ "Insulin Syringes", "Alcohol Swabs" }',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE product_variations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity_mg DECIMAL(10,2) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 2. RESTORE PRODUCTS (WITH IMAGES)
-- ==========================================

DO $$
DECLARE
  pid UUID;
BEGIN
  
  -- PEPTIDE PRODUCTS REMOVED AS REQUESTED (ONLY SUPPLIES REMAIN)


  -- 19. PEN CARTRIDGE
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Cartridge (3ml)', 'Steam sterilized empty cartridge for pen injector.', 'supplies', 30.00, 100.0, 50, true, false, '/products/supplies_cartridge.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  (pid, '1pc', 1.0, 30.00, 100);

  -- 20. PEN NEEDLES 31G 6MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (31G, 6mm)', 'High-quality pen needles for comfortable injection. 31 Gauge, 6mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_31g_6mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, 50);

  -- 21. PEN NEEDLES 31G 8MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (31G, 8mm)', 'High-quality pen needles. 31 Gauge, 8mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_31g_8mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, 50);

  -- 22. PEN NEEDLES 32G 4MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (32G, 4mm)', 'Ultra-fine pen needles for minimal pain. 32 Gauge, 4mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_32g_4mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, 50);

  -- UPDATE AVAILABILITY based on variations
  UPDATE products p
  SET available = EXISTS (
    SELECT 1 FROM product_variations pv 
    WHERE pv.product_id = p.id AND pv.stock_quantity > 0
  )
  WHERE EXISTS (SELECT 1 FROM product_variations pv2 WHERE pv2.product_id = p.id);

END $$;

-- ==========================================
-- 3. RESTORE SITE SETTINGS
-- ==========================================

DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'site_settings') THEN
    CREATE TABLE site_settings (
      id TEXT PRIMARY KEY,
      value TEXT NOT NULL,
      type TEXT DEFAULT 'text',
      description TEXT,
      updated_at TIMESTAMPTZ DEFAULT NOW()
    );
  END IF;
END $$;

INSERT INTO site_settings (id, value, type, description) VALUES
('site_name', 'HP GLOW', 'text', 'Website Name'),
('site_tagline', 'Premium pep solutions for radiance, confidence & vitality.', 'text', 'Website Tagline'),
('site_description', 'Premium pep solutions for radiance, confidence & vitality.', 'text', 'Website Description'),
('contact_instagram', 'https://www.instagram.com/hpglowpeptides', 'url', 'Instagram profile URL'),
('contact_viber', '09062349763', 'text', 'Viber phone number')
ON CONFLICT (id) DO UPDATE SET
  value = EXCLUDED.value,
  type = EXCLUDED.type,
  description = EXCLUDED.description,
  updated_at = NOW();

RAISE NOTICE '✅ Image-based restoration completed successfully!';
