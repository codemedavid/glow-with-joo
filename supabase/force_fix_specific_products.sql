-- ============================================
-- FORCE FIX PRODUCT CATEGORIES (Brute Force)
-- Run this in Supabase SQL Editor
-- ============================================

-- This script explicitly maps specific products to their correct category IDs
-- avoiding any potential issues with string comparison.

-- 1. Fix 'Beauty & Anti-Aging' Products (Snap-8, GHKCu)
-- Category ID: c0a80121-0003-4e78-94f8-585d77059003
UPDATE products 
SET category = 'c0a80121-0003-4e78-94f8-585d77059003'
WHERE name LIKE '%Snap-8%' 
   OR name LIKE '%GHKCu%'
   OR category LIKE '%Beauty%';

-- 2. Fix 'Cognitive Enhancement' Products (Semax, Selank)
-- We'll look up the ID ensuring we get the one we created
UPDATE products 
SET category = (SELECT id::text FROM categories WHERE name = 'Cognitive Enhancement' LIMIT 1)
WHERE name LIKE '%Semax%' 
   OR name LIKE '%Selank%'
   OR category LIKE '%Cognitive%';

-- 3. Fix 'Weight Management' Products (Tirzepatide)
-- Category ID: c0a80121-0002-4e78-94f8-585d77059002
UPDATE products 
SET category = 'c0a80121-0002-4e78-94f8-585d77059002'
WHERE name LIKE '%Tirzepatide%'
   OR category LIKE '%Weight%';

-- 4. Fix 'Add-Ons' (Needles, Cartridges)
-- We'll look up the ID
UPDATE products 
SET category = (SELECT id::text FROM categories WHERE name = 'Add-Ons' LIMIT 1)
WHERE name LIKE '%Needle%' 
   OR name LIKE '%Cartridge%'
   OR category LIKE '%Add-On%';

-- 5. Final Verification
SELECT name, category FROM products ORDER BY name;
