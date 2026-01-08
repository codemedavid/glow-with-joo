-- SLIMMETRY Complete Product Catalog
-- Based on official price list
-- Run this SQL in your Supabase SQL Editor

-- First, clear existing products and variations
DELETE FROM public.product_variations;
DELETE FROM public.products;
DELETE FROM public.categories;

-- =============================================
-- CATEGORIES (Fresh insert, no duplicates)
-- =============================================
INSERT INTO public.categories (id, name, sort_order, icon, active)
VALUES
  ('c0a80121-7ac0-4e78-94f8-585d77059123', 'Weight Management', 1, 'Scale', true),
  ('c0a80121-7ac0-4e78-94f8-585d77059124', 'Beauty & Anti-Aging', 2, 'Sparkles', true),
  ('c0a80121-7ac0-4e78-94f8-585d77059125', 'Wellness & Vitality', 3, 'Heart', true),
  ('c0a80121-7ac0-4e78-94f8-585d77059126', 'Accessories', 4, 'Package', true);


-- =============================================
-- PRODUCTS
-- =============================================

-- 1. Tirzepatide (Weight Management) - Featured
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059301',
  'Tirzepatide',
  'Dual GIP and GLP-1 receptor agonist for advanced metabolic support. Premium quality peptide for weight management. FREE SHIPPING on all Tirzepatide orders.',
  3000.00,
  'c0a80121-7ac0-4e78-94f8-585d77059123',
  true, true, 100, 99.0,
  'Store at 2-8°C. Protect from light.'
);

-- 2. Retatrutide (Weight Management) - Featured
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059302',
  'Retatrutide',
  'Triple-action GLP-1/GIP/Glucagon receptor agonist. Next-generation metabolic peptide for comprehensive weight and metabolic support.',
  1800.00,
  'c0a80121-7ac0-4e78-94f8-585d77059123',
  true, true, 100, 99.0,
  'Store at 2-8°C. Protect from light.'
);

-- 3. Cagrilintide (Weight Management)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059303',
  'Cagrilintide',
  'Long-acting amylin analog for appetite control and metabolic regulation. Works synergistically with GLP-1 agonists.',
  2300.00,
  'c0a80121-7ac0-4e78-94f8-585d77059123',
  true, true, 100, 99.0,
  'Store at 2-8°C. Protect from light.'
);

-- 4. Lemon Bottle 10ml (Weight Management)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059304',
  'Lemon Bottle 10ml',
  'Advanced lipolytic solution for targeted fat reduction. Premium quality formula for body contouring.',
  1500.00,
  'c0a80121-7ac0-4e78-94f8-585d77059123',
  false, true, 100, 99.0,
  'Store at room temperature. Protect from light.'
);

-- 5. GHK-Cu 50mg (Beauty & Anti-Aging)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059305',
  'GHK-Cu 50mg',
  'Copper peptide for skin rejuvenation, collagen production, and anti-aging. Promotes skin elasticity and wound healing.',
  1500.00,
  'c0a80121-7ac0-4e78-94f8-585d77059124',
  true, true, 100, 99.0,
  'Store at -20°C. Protect from light.'
);

-- 6. NAD+ 500mg (Wellness & Vitality)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059306',
  'NAD+ 500mg',
  'Nicotinamide Adenine Dinucleotide for cellular energy, longevity, and metabolic health. Essential coenzyme for mitochondrial function.',
  2000.00,
  'c0a80121-7ac0-4e78-94f8-585d77059125',
  true, true, 100, 99.0,
  'Store at -20°C. Protect from light.'
);

-- 7. Glutathione 1500mg (Beauty & Anti-Aging)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059307',
  'Glutathione 1500mg',
  'Master antioxidant for skin brightening, detoxification, and immune support. High-potency formula for optimal results.',
  2500.00,
  'c0a80121-7ac0-4e78-94f8-585d77059124',
  true, true, 100, 99.0,
  'Store at 2-8°C. Protect from light.'
);

-- 8. AHK-Cu 100mg (Beauty & Anti-Aging)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059308',
  'AHK-Cu 100mg',
  'Advanced copper tripeptide for hair growth stimulation and scalp health. Promotes thicker, healthier hair.',
  1300.00,
  'c0a80121-7ac0-4e78-94f8-585d77059124',
  false, true, 100, 99.0,
  'Store at -20°C. Protect from light.'
);

-- 9. SNAP 8 (Beauty & Anti-Aging)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059309',
  'SNAP 8',
  'Octapeptide for reduction of expression wrinkles. Botox-like peptide for smoother, younger-looking skin.',
  1300.00,
  'c0a80121-7ac0-4e78-94f8-585d77059124',
  false, true, 100, 99.0,
  'Store at -20°C. Protect from light.'
);

-- 10. Peptide Container (Accessories)
INSERT INTO public.products (id, name, description, base_price, category, featured, available, stock_quantity, purity_percentage, storage_conditions)
VALUES (
  'd0a80121-7ac0-4e78-94f8-585d77059310',
  'Peptide Container',
  'Essential storage container for your peptides. Must-have accessory for proper peptide storage and organization.',
  50.00,
  'c0a80121-7ac0-4e78-94f8-585d77059126',
  false, true, 500, 0,
  'N/A'
);


-- =============================================
-- PRODUCT VARIATIONS (Size Options)
-- =============================================

-- Tirzepatide variations: 15mg, 30mg
INSERT INTO public.product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  ('d0a80121-7ac0-4e78-94f8-585d77059301', '15mg', 15, 3000.00, 50),
  ('d0a80121-7ac0-4e78-94f8-585d77059301', '30mg', 30, 4500.00, 50);

-- Retatrutide variations: 5mg, 10mg
INSERT INTO public.product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  ('d0a80121-7ac0-4e78-94f8-585d77059302', '5mg', 5, 1800.00, 50),
  ('d0a80121-7ac0-4e78-94f8-585d77059302', '10mg', 10, 3300.00, 50);

-- Cagrilintide variations: 5mg, 10mg
INSERT INTO public.product_variations (product_id, name, quantity_mg, price, stock_quantity) VALUES
  ('d0a80121-7ac0-4e78-94f8-585d77059303', '5mg', 5, 2300.00, 50),
  ('d0a80121-7ac0-4e78-94f8-585d77059303', '10mg', 10, 3500.00, 50);


-- =============================================
-- VERIFICATION - Check for any duplicate categories
-- =============================================
SELECT name, COUNT(*) as count FROM public.categories GROUP BY name HAVING COUNT(*) > 1;

-- Show all categories
SELECT * FROM public.categories ORDER BY sort_order;
