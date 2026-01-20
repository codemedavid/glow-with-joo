-- ============================================
-- UPDATE STOCKS & REMOVE 'PEPTIDES' CATEGORY
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Restock ALL Products
-- Set stock to 100 and ensure they are marked available
UPDATE products
SET stock_quantity = 100,
    available = true;

-- 2. Restock ALL Variations
-- Also set variations (like "Vials Only") to 100
UPDATE product_variations
SET stock_quantity = 100;

-- 3. Remove 'Peptides' Category
-- This deletes the category specifically named 'Peptides'
DELETE FROM categories
WHERE name = 'Peptides';

-- 4. Verify Results
SELECT name, stock_quantity, available FROM products LIMIT 5;
