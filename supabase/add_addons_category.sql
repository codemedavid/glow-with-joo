-- Add-Ons Category and Products
-- Run this in Supabase SQL Editor

-- Step 1: Create the Add-Ons category
INSERT INTO categories (id, name, icon, sort_order, active)
VALUES (gen_random_uuid(), 'Add-Ons', '🛒', 99, true);

-- Step 2: Add the Add-On Products (using the category ID we just created)

-- Pen Cartridge (Steam Sterilized)
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Cartridge (Steam Sterilized)',
  'Sterile pen cartridge for reusable pens. Steam sterilized for safety.',
  30.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 31g/6mm - 10pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 31g/6mm (10pcs)',
  '31 gauge, 6mm pen needles. Pack of 10 pieces. Ultra-fine for comfortable injections.',
  70.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 31g/6mm - 100pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 31g/6mm (100pcs)',
  '31 gauge, 6mm pen needles. Pack of 100 pieces. Ultra-fine for comfortable injections. Best value!',
  450.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 31g/8mm - 10pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 31g/8mm (10pcs)',
  '31 gauge, 8mm pen needles. Pack of 10 pieces. Ultra-fine for comfortable injections.',
  70.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 31g/8mm - 100pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 31g/8mm (100pcs)',
  '31 gauge, 8mm pen needles. Pack of 100 pieces. Ultra-fine for comfortable injections. Best value!',
  450.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 32g/4mm - 10pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 32g/4mm (10pcs)',
  '32 gauge, 4mm pen needles. Pack of 10 pieces. Extra-fine and short for minimal discomfort.',
  70.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Pen Needles 32g/4mm - 100pcs
INSERT INTO products (name, description, base_price, category, available, featured)
VALUES (
  'Pen Needles 32g/4mm (100pcs)',
  '32 gauge, 4mm pen needles. Pack of 100 pieces. Extra-fine and short for minimal discomfort. Best value!',
  450.00,
  (SELECT id FROM categories WHERE name = 'Add-Ons' LIMIT 1),
  true,
  false
);

-- Verify the products were added
SELECT p.name, p.base_price, c.name as category 
FROM products p 
JOIN categories c ON p.category = c.id::text 
WHERE c.name = 'Add-Ons' 
ORDER BY p.name;
