-- ============================================
-- CLEANUP UNUSED CATEGORIES
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Check which categories have 0 products
SELECT c.name, COUNT(p.id) as product_count
FROM categories c
LEFT JOIN products p ON p.category = c.id::text
GROUP BY c.name
ORDER BY product_count ASC;

-- 2. Delete empty categories (Safe Delete)
-- This deletes any category that has NO products linked to it.
DELETE FROM categories
WHERE id::text NOT IN (SELECT DISTINCT category FROM products WHERE category IS NOT NULL);

-- 3. (Optional) Explicitly remove specific categories if you want to force them out,
-- even if they were manually created or intended for future use.
-- Uncomment lines below if 'Safe Delete' didn't catch them because of ghost references.
/*
DELETE FROM categories WHERE name IN (
  'Wellness & Vitality',
  'GLP-1 Agonists',
  'Insulin Pens',
  'Accessories',
  'Bundles & Kits'
);
*/

-- 4. Verify remaining categories
SELECT name FROM categories WHERE active = true ORDER BY sort_order;
