-- COMPLETE RESTORATION SCRIPT - WITH PEN TYPE PRICING (JAN 2026)
-- This script will:
-- 1. DROP and RECREATE tables to ensure clean schema
-- 2. Restore products with pen type pricing from provided price list
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

-- Updated product_variations with pen type pricing columns
CREATE TABLE product_variations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity_mg DECIMAL(10,2) NOT NULL,
  -- Complete Set price (with insulin syringes & alcohol swabs)
  price DECIMAL(10,2) NOT NULL,
  -- Disposable Pen price (includes 3 needles) - NULL means not available
  disposable_pen_price DECIMAL(10,2),
  -- Reusable Pen price (includes cartridge & 3 needles) - NULL means not available  
  reusable_pen_price DECIMAL(10,2),
  stock_quantity INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 2. RESTORE PRODUCTS (WITH PEN TYPE PRICING)
-- ==========================================

DO $$
DECLARE
  pid UUID;
BEGIN
  
  -- ===========================================
  -- RESEARCH PEPTIDES
  -- ===========================================

  -- 1. TIRZEPATIDE (15mg, 30mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Tirzepatide', 'Dual GIP/GLP-1 receptor agonist for metabolic research.', 'research', 2000.00, 99.5, 0, true, true, '/products/01_tirzepatide_15mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '15mg', 15.0, 2000.00, 2300.00, 2800.00, 50),
  (pid, '30mg', 30.0, 2900.00, 3200.00, 3700.00, 50);

  -- 2. SS31 (10mg, 50mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('SS-31', 'Mitochondrial targeted peptide for cellular health.', 'research', 2000.00, 99.0, 0, true, false, '/products/10_ss31_10mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10mg', 10.0, 2000.00, 2300.00, 2800.00, 50),
  (pid, '50mg', 50.0, 3600.00, 3900.00, 4400.00, 50);

  -- 3. MOTS-C (10mg, 40mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('MOTS-C', 'Mitochondrial derived peptide for metabolic regulation.', 'research', 1800.00, 98.5, 0, true, false, '/products/12_mots_c_10mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10mg', 10.0, 1800.00, 2100.00, 2600.00, 50),
  (pid, '40mg', 40.0, 2700.00, 3000.00, 3500.00, 50);

  -- 4. KPV (5mg, 10mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('KPV', 'Lysine-Proline-Valine peptide for inflammation.', 'research', 1600.00, 99.0, 0, true, false, '/products/20_kpv_5mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '5mg', 5.0, 1600.00, 1900.00, 2400.00, 50),
  (pid, '10mg', 10.0, 1700.00, 2000.00, 2500.00, 50);

  -- 5. TESAMORELIN (5mg, 10mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Tesamorelin', 'GHRH analog for visceral fat reduction.', 'research', 2100.00, 99.0, 0, true, false, '/products/22_tesamorelin_5mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '5mg', 5.0, 2100.00, 2400.00, 2900.00, 50),
  (pid, '10mg', 10.0, 2600.00, 2900.00, 3400.00, 50);

  -- 6. EPITALON (10mg, 50mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Epitalon', 'Synthetic peptide for telomere length and longevity.', 'research', 1800.00, 99.0, 0, true, true, '/products/24_epitalon_10mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10mg', 10.0, 1800.00, 2100.00, 2600.00, 50),
  (pid, '50mg', 50.0, 2200.00, 2500.00, 3000.00, 50);

  -- ===========================================
  -- WELLNESS & SUPPORT
  -- ===========================================

  -- 7. NAD+ (500mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('NAD+', 'Essential coenzyme for cellular energy and metabolism.', 'wellness', 2100.00, 99.5, 50, true, true, '/products/03_nad_500mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '500mg', 500.0, 2100.00, 2400.00, 2900.00, 50);

  -- 8. DSIP (5mg, 15mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('DSIP', 'Delta Sleep-Inducing Peptide for sleep regulation research.', 'wellness', 2000.00, 99.0, 0, true, false, '/products/06_dsip_5mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '5mg', 5.0, 2000.00, 2300.00, 2800.00, 50),
  (pid, '15mg', 15.0, 2400.00, 2700.00, 3200.00, 50);

  -- 9. GLUTATHIONE (1500mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Glutathione', 'Master antioxidant for cellular protection.', 'wellness', 1900.00, 99.0, 50, true, true, '/products/08_glutathione_1500mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '1500mg', 1500.0, 1900.00, 2200.00, 2700.00, 50);

  -- 10. KLOW (Combo) - CU50+TB10+BC10+KPV10
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('KLOW', 'Premium Blend: CU50 + TB10 + BC10 + KPV10.', 'wellness', 3000.00, 99.0, 50, true, true, '/products/14_klow_blend.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, 'Blend', 80.0, 3000.00, 3300.00, 3800.00, 50);

  -- 11. SEMAX + SELANK (10mg each)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Semax + Selank', 'Nootropic stack: Semax (10mg) + Selank (10mg).', 'wellness', 2200.00, 99.0, 50, true, true, '/products/19_semax_selank.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, 'Combo', 20.0, 2200.00, NULL, NULL, 50);

  -- 12. PT-141 (10mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('PT-141', 'Bremelanotide for sexual health research.', 'wellness', 1900.00, 99.0, 50, true, false, '/products/26_pt141_10mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10mg', 10.0, 1900.00, 2200.00, 2700.00, 50);

  -- ===========================================
  -- COSMETIC & SKINCARE
  -- ===========================================

  -- 13. GHK-CU (50mg, 100mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('GHK-CU', 'Copper peptide complex for tissue repair and anti-aging.', 'cosmetic', 1700.00, 99.0, 0, true, true, '/products/04_ghkcu_50mg.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '50mg', 50.0, 1700.00, 2000.00, 2500.00, 50),
  (pid, '100mg', 100.0, 1900.00, 2200.00, 2700.00, 50);

  -- 14. LIPO-C WITH B12
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Lipo-C with B12', 'Fat burning blend with Vitamin B12.', 'cosmetic', 2000.00, 99.0, 50, true, false, '/products/09_lipo_c_b12.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10ml', 10.0, 2000.00, 2300.00, 2800.00, 50);

  -- 15. LEMON BOTTLE (NA for pen options)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Lemon Bottle', 'Fat dissolving solution.', 'cosmetic', 1900.00, 99.0, 50, true, false, '/products/15_lemon_bottle.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10ml', 10.0, 1900.00, NULL, NULL, 50);

  -- 16. KPV + GHK-CU (10mg + 50mg)
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('KPV + GHK-Cu', 'Combination of KPV (10mg) and GHK-Cu (50mg).', 'cosmetic', 2200.00, 99.0, 50, true, false, '/products/16_kpv_ghkcu_blend.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, 'Combo', 60.0, 2200.00, 2500.00, 3000.00, 50);

  -- 17. SNAP-8 (Botox in bottle) - NA for pen options
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Snap-8 (Botox in bottle)', 'Acetyle Glutamyl Heptapeptide-3 solution.', 'cosmetic', 1800.00, 99.0, 50, true, true, '/products/17_snap8.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10mg', 10.0, 1800.00, NULL, NULL, 50);

  -- 18. GHK-CU COSMETIC GRADE (1 GRAM) - NA for pen options
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('GHK-Cu Cosmetic Grade', 'Pure GHK-Cu powder for cosmetic formulation.', 'cosmetic', 1700.00, 99.0, 50, true, false, '/products/18_ghkcu_cosmetic_1g.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '1g', 1000.0, 1700.00, NULL, NULL, 50);

  -- ===========================================
  -- SUPPLIES & ACCESSORIES (No pen options)
  -- ===========================================

  -- 19. PEN CARTRIDGE
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Cartridge (3ml)', 'Steam sterilized empty cartridge for pen injector.', 'supplies', 30.00, 100.0, 50, true, false, '/products/supplies_cartridge.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '1pc', 1.0, 30.00, NULL, NULL, 100);

  -- 20. PEN NEEDLES 31G 6MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (31G, 6mm)', 'High-quality pen needles for comfortable injection. 31 Gauge, 6mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_31g_6mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, NULL, NULL, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, NULL, NULL, 50);

  -- 21. PEN NEEDLES 31G 8MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (31G, 8mm)', 'High-quality pen needles. 31 Gauge, 8mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_31g_8mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, NULL, NULL, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, NULL, NULL, 50);

  -- 22. PEN NEEDLES 32G 4MM
  INSERT INTO products (name, description, category, base_price, purity_percentage, stock_quantity, available, featured, image_url)
  VALUES ('Pen Needles (32G, 4mm)', 'Ultra-fine pen needles for minimal pain. 32 Gauge, 4mm length.', 'supplies', 70.00, 100.0, 50, true, false, '/products/supplies_needles_32g_4mm.png')
  RETURNING id INTO pid;
  
  INSERT INTO product_variations (product_id, name, quantity_mg, price, disposable_pen_price, reusable_pen_price, stock_quantity) VALUES
  (pid, '10pcs', 10.0, 70.00, NULL, NULL, 100),
  (pid, '100pcs (Box)', 100.0, 450.00, NULL, NULL, 50);

  -- UPDATE AVAILABILITY based on variations
  UPDATE products p
  SET available = EXISTS (
    SELECT 1 FROM product_variations pv 
    WHERE pv.product_id = p.id AND pv.stock_quantity > 0
  )
  WHERE EXISTS (SELECT 1 FROM product_variations pv2 WHERE pv2.product_id = p.id);

END $$;



RAISE NOTICE '✅ Products restored with pen type pricing successfully!';
