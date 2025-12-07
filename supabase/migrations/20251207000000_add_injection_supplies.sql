-- Complete Database Setup for HP GLOW
-- Run this in your Supabase SQL Editor
-- This creates all tables and adds the injection supplies products

-- ============================================
-- STEP 1: Drop existing tables (if any)
-- ============================================
DROP TABLE IF EXISTS product_variations CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS payment_methods CASCADE;
DROP TABLE IF EXISTS site_settings CASCADE;
DROP TABLE IF EXISTS coa_reports CASCADE;
DROP TABLE IF EXISTS orders CASCADE;

-- ============================================
-- STEP 2: Create Tables
-- ============================================

-- Categories table
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  icon TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Products table
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
  purity_percentage DECIMAL(5,2) DEFAULT 0,
  molecular_weight TEXT,
  cas_number TEXT,
  sequence TEXT,
  storage_conditions TEXT DEFAULT 'Room temperature',
  inclusions TEXT[],
  stock_quantity INTEGER DEFAULT 0,
  available BOOLEAN DEFAULT true,
  featured BOOLEAN DEFAULT false,
  image_url TEXT,
  safety_sheet_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Product variations table
CREATE TABLE product_variations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity_mg DECIMAL(10,2) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Payment methods table
CREATE TABLE payment_methods (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  account_number TEXT NOT NULL,
  account_name TEXT NOT NULL,
  qr_code_url TEXT,
  active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Site settings table
CREATE TABLE site_settings (
  id TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  type TEXT DEFAULT 'text',
  description TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- COA reports table
CREATE TABLE coa_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_name TEXT NOT NULL,
  batch TEXT DEFAULT 'Unknown',
  test_date DATE NOT NULL,
  purity_percentage DECIMAL(5,2) DEFAULT 99.0,
  quantity TEXT,
  task_number TEXT,
  verification_key TEXT,
  image_url TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Orders table
CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name TEXT NOT NULL,
  customer_email TEXT NOT NULL,
  customer_phone TEXT NOT NULL,
  shipping_address TEXT NOT NULL,
  shipping_city TEXT NOT NULL,
  shipping_state TEXT NOT NULL,
  shipping_zip_code TEXT NOT NULL,
  shipping_country TEXT NOT NULL DEFAULT 'Philippines',
  shipping_location TEXT,
  shipping_fee DECIMAL(10,2) DEFAULT 0,
  order_items JSONB NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  payment_method_id TEXT,
  payment_method_name TEXT,
  payment_proof_url TEXT,
  contact_method TEXT,
  order_status TEXT DEFAULT 'new',
  payment_status TEXT DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- STEP 3: Create Indexes
-- ============================================
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_available ON products(available);
CREATE INDEX idx_products_featured ON products(featured);
CREATE INDEX idx_product_variations_product_id ON product_variations(product_id);
CREATE INDEX idx_categories_active ON categories(active);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- ============================================
-- STEP 4: Create Triggers
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_payment_methods_updated_at BEFORE UPDATE ON payment_methods
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_site_settings_updated_at BEFORE UPDATE ON site_settings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- STEP 5: Enable RLS and Policies
-- ============================================
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_variations ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE coa_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Allow public read access
CREATE POLICY "Allow public read access on categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Allow public read access on products" ON products FOR SELECT USING (true);
CREATE POLICY "Allow public read access on product_variations" ON product_variations FOR SELECT USING (true);
CREATE POLICY "Allow public read access on payment_methods" ON payment_methods FOR SELECT USING (true);
CREATE POLICY "Allow public read access on site_settings" ON site_settings FOR SELECT USING (true);
CREATE POLICY "Allow public read access on coa_reports" ON coa_reports FOR SELECT USING (true);

-- Allow public insert/update (for admin - in production, use auth)
CREATE POLICY "Allow public insert on categories" ON categories FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on categories" ON categories FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on categories" ON categories FOR DELETE USING (true);

CREATE POLICY "Allow public insert on products" ON products FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on products" ON products FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on products" ON products FOR DELETE USING (true);

CREATE POLICY "Allow public insert on product_variations" ON product_variations FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on product_variations" ON product_variations FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on product_variations" ON product_variations FOR DELETE USING (true);

CREATE POLICY "Allow public insert on payment_methods" ON payment_methods FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on payment_methods" ON payment_methods FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on payment_methods" ON payment_methods FOR DELETE USING (true);

CREATE POLICY "Allow public insert on coa_reports" ON coa_reports FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on coa_reports" ON coa_reports FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on coa_reports" ON coa_reports FOR DELETE USING (true);

CREATE POLICY "Allow public insert on orders" ON orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public read on orders" ON orders FOR SELECT USING (true);
CREATE POLICY "Allow public update on orders" ON orders FOR UPDATE USING (true);

-- ============================================
-- STEP 6: Insert Categories
-- ============================================
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('injection-pens', 'Injection Pens', '💉', 1, true),
  ('needles', 'Needles', '📍', 2, true),
  ('syringes', 'Syringes', '🩺', 3, true),
  ('accessories', 'Accessories', '🧰', 4, true);

-- ============================================
-- STEP 7: Insert Products
-- ============================================

-- Candy Colored Peppie Pen (with case)
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Candy Colored Peppie Pen (with case)', 'Colorful injection pen with protective case. Available in multiple vibrant colors.', 'injection-pens', 670, 100, true, true, 'Room temperature');

INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Yellow', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)'
UNION ALL SELECT id, 'Purple', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)'
UNION ALL SELECT id, 'Green', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)'
UNION ALL SELECT id, 'Blue', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)'
UNION ALL SELECT id, 'Gray', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)'
UNION ALL SELECT id, 'Orange', 0, 670, 20 FROM products WHERE name = 'Candy Colored Peppie Pen (with case)';

-- Candy Colored Peppie Pen Set
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Candy Colored Peppie Pen Set', 'Complete pen set including 1 Sterilized Cartridge + 3 pcs 4mm Needle. Available in multiple vibrant colors.', 'injection-pens', 700, 100, true, true, 'Room temperature');

INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Yellow', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set'
UNION ALL SELECT id, 'Purple', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set'
UNION ALL SELECT id, 'Green', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set'
UNION ALL SELECT id, 'Blue', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set'
UNION ALL SELECT id, 'Gray', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set'
UNION ALL SELECT id, 'Orange', 0, 700, 20 FROM products WHERE name = 'Candy Colored Peppie Pen Set';

-- Huma Pen Ergo
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Huma Pen Ergo', 'Ergonomic injection pen for comfortable use.', 'injection-pens', 900, 50, true, false, 'Room temperature');

-- Disposable Pen
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Disposable Pen', 'Single-use disposable injection pen. Available in Orange and Green.', 'injection-pens', 200, 100, true, false, 'Room temperature');

INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Orange', 0, 200, 50 FROM products WHERE name = 'Disposable Pen'
UNION ALL SELECT id, 'Green', 0, 200, 50 FROM products WHERE name = 'Disposable Pen';

-- Pen Cartridge (Steam Sterilized)
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Cartridge (Steam Sterilized)', 'Steam sterilized cartridge for injection pens.', 'accessories', 25, 200, true, false, 'Room temperature');

-- Pen Cartridge (UV Sterilized) - SOLD OUT
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Cartridge (UV Sterilized)', 'UV sterilized cartridge for injection pens. Currently SOLD OUT.', 'accessories', 0, 0, false, false, 'Room temperature');

-- Pen Needles (10pcs) – Generic Brand
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (10pcs) – Generic Brand', 'Pack of 10 generic brand pen needles.', 'needles', 40, 100, true, false, 'Room temperature');

-- Insulin Syringe 100s (Generic) – Coming Soon
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Insulin Syringe 100s (Generic)', '1ml 31g/8mm insulin syringe. 100 pieces per box. Coming Soon.', 'syringes', 500, 0, false, false, 'Room temperature');

-- Insulin Syringe 10s (Generic) – Coming Soon
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Insulin Syringe 10s (Generic)', '1ml 31g/8mm insulin syringe. 10 pieces per pack. Coming Soon.', 'syringes', 55, 0, false, false, 'Room temperature');

-- Pen Needles (100s) – Generic Brand 31g/8mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (100s) – Generic Brand 31g/8mm', '100 pieces pen needles, 31g/8mm size.', 'needles', 380, 50, true, false, 'Room temperature');

-- Pen Needles (10s) – Generic Brand 31g/8mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (10s) – Generic Brand 31g/8mm', '10 pieces pen needles, 31g/8mm size.', 'needles', 40, 100, true, false, 'Room temperature');

-- Pen Needles (100s) – Generic Brand 32g/4mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (100s) – Generic Brand 32g/4mm', '100 pieces pen needles, 32g/4mm size.', 'needles', 380, 50, true, false, 'Room temperature');

-- Pen Needles (10s) – Generic Brand 32g/4mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (10s) – Generic Brand 32g/4mm', '10 pieces pen needles, 32g/4mm size.', 'needles', 40, 100, true, false, 'Room temperature');

-- Pen Needles (100s) – Generic Brand 29g/12mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (100s) – Generic Brand 29g/12mm', '100 pieces pen needles, 29g/12mm size.', 'needles', 480, 50, true, false, 'Room temperature');

-- Pen Needles (10s) – Generic Brand 29g/12mm
INSERT INTO products (name, description, category, base_price, stock_quantity, available, featured, storage_conditions)
VALUES ('Pen Needles (10s) – Generic Brand 29g/12mm', '10 pieces pen needles, 29g/12mm size.', 'needles', 50, 100, true, false, 'Room temperature');

-- ============================================
-- STEP 8: Insert Default Payment Methods
-- ============================================
INSERT INTO payment_methods (id, name, account_number, account_name, active, sort_order) VALUES
  ('gcash', 'GCash', '09XXXXXXXXX', 'HP GLOW', true, 1),
  ('maya', 'Maya', '09XXXXXXXXX', 'HP GLOW', true, 2);

-- ============================================
-- STEP 9: Insert Site Settings
-- ============================================
INSERT INTO site_settings (id, value, type, description) VALUES
  ('site_name', 'HP GLOW', 'text', 'Website name'),
  ('site_tagline', 'Premium Injection Supplies', 'text', 'Website tagline'),
  ('contact_email', 'info@hpglow.com', 'email', 'Contact email'),
  ('contact_phone', '+63 XXX XXX XXXX', 'text', 'Contact phone number');

-- ============================================
-- VERIFICATION
-- ============================================
SELECT 'Setup Complete! Here is a summary:' as status;
SELECT 'Categories: ' || COUNT(*) FROM categories;
SELECT 'Products: ' || COUNT(*) FROM products;
SELECT 'Variations: ' || COUNT(*) FROM product_variations;
SELECT 'Payment Methods: ' || COUNT(*) FROM payment_methods;
