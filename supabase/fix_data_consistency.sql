-- ============================================
-- COMPREHENSIVE FIX FOR PRODUCT CATEGORIES
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Create missing 'Cognitive Enhancement' category if it doesn't exist
INSERT INTO public.categories (id, name, icon, sort_order, active)
VALUES (
  gen_random_uuid(),
  'Cognitive Enhancement',
  'Sparkles', -- Using Sparkles as it exists in SubNav
  9,
  true
)
ON CONFLICT DO NOTHING;
-- Note: If we can't use ON CONFLICT(name) because name isn't unique constraint, we use WHERE NOT EXISTS
INSERT INTO public.categories (name, icon, sort_order, active)
SELECT 'Cognitive Enhancement', 'Sparkles', 9, true
WHERE NOT EXISTS (SELECT 1 FROM public.categories WHERE name = 'Cognitive Enhancement');

-- 2. Clean up and Normalize Product Categories
-- This updates matches ignoring case and whitespace
UPDATE public.products p
SET category = c.id::text
FROM public.categories c
WHERE LOWER(TRIM(p.category)) = LOWER(TRIM(c.name));

-- 3. Verify Data
SELECT 
    p.name as product_name, 
    p.category as category_id, 
    c.name as category_name
FROM public.products p
LEFT JOIN public.categories c ON p.category = c.id::text
ORDER BY category_name NULLS LAST, product_name;

-- 4. Check for Orphans (Products with no mapped category)
SELECT name, category FROM public.products 
WHERE category NOT IN (SELECT id::text FROM public.categories);
