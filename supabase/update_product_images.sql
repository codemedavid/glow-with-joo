-- Update Product Images - LOCAL VERSION (No Supabase Storage needed!)
-- Images are served from /products/ folder
-- Run this in Supabase SQL Editor

UPDATE products SET image_url = '/products/01_tirzepatide_15mg.png' 
WHERE LOWER(name) LIKE '%tirzepatide%15%' OR LOWER(name) LIKE '%tirzepetide%15%';

UPDATE products SET image_url = '/products/02_tirzepatide_30mg.png' 
WHERE LOWER(name) LIKE '%tirzepatide%30%' OR LOWER(name) LIKE '%tirzepetide%30%';

UPDATE products SET image_url = '/products/03_nad_500mg.png' 
WHERE LOWER(name) LIKE '%nad%500%';

UPDATE products SET image_url = '/products/04_ghkcu_50mg.png' 
WHERE LOWER(name) LIKE '%ghk%cu%50%' AND LOWER(name) NOT LIKE '%kpv%' AND LOWER(name) NOT LIKE '%cosmetic%';

UPDATE products SET image_url = '/products/05_ghkcu_100mg.png' 
WHERE LOWER(name) LIKE '%ghk%cu%100%';

UPDATE products SET image_url = '/products/06_dsip_5mg.png' 
WHERE LOWER(name) LIKE '%dsip%5%' AND LOWER(name) NOT LIKE '%15%';

UPDATE products SET image_url = '/products/07_dsip_15mg.png' 
WHERE LOWER(name) LIKE '%dsip%15%';

UPDATE products SET image_url = '/products/08_glutathione_1500mg.png' 
WHERE LOWER(name) LIKE '%glutathione%';

UPDATE products SET image_url = '/products/09_lipo_c_b12.png' 
WHERE LOWER(name) LIKE '%lipo%c%' OR LOWER(name) LIKE '%lipo%b12%';

UPDATE products SET image_url = '/products/10_ss31_10mg.png' 
WHERE LOWER(name) LIKE '%ss31%10%' OR LOWER(name) LIKE '%ss-31%10%';

UPDATE products SET image_url = '/products/11_ss31_50mg.png' 
WHERE LOWER(name) LIKE '%ss31%50%' OR LOWER(name) LIKE '%ss-31%50%';

UPDATE products SET image_url = '/products/12_mots_c_10mg.png' 
WHERE LOWER(name) LIKE '%mots%c%10%' OR LOWER(name) LIKE '%mots-c%10%';

UPDATE products SET image_url = '/products/13_mots_c_40mg.png' 
WHERE LOWER(name) LIKE '%mots%c%40%' OR LOWER(name) LIKE '%mots-c%40%';

UPDATE products SET image_url = '/products/14_klow_blend.png' 
WHERE LOWER(name) LIKE '%klow%';

UPDATE products SET image_url = '/products/15_lemon_bottle.png' 
WHERE LOWER(name) LIKE '%lemon%bottle%';

UPDATE products SET image_url = '/products/16_kpv_ghkcu_blend.png' 
WHERE LOWER(name) LIKE '%kpv%' AND LOWER(name) LIKE '%ghk%';

UPDATE products SET image_url = '/products/17_snap8.png' 
WHERE LOWER(name) LIKE '%snap%8%' OR LOWER(name) LIKE '%snap-8%';

UPDATE products SET image_url = '/products/18_ghkcu_cosmetic_1g.png' 
WHERE LOWER(name) LIKE '%ghk%cosmetic%' OR LOWER(name) LIKE '%cosmetic%grade%';

UPDATE products SET image_url = '/products/19_semax_selank.png' 
WHERE LOWER(name) LIKE '%semax%' AND LOWER(name) LIKE '%selank%';

UPDATE products SET image_url = '/products/20_kpv_5mg.png' 
WHERE LOWER(name) LIKE '%kpv%5%' AND LOWER(name) NOT LIKE '%ghk%';

UPDATE products SET image_url = '/products/21_kpv_10mg.png' 
WHERE LOWER(name) LIKE '%kpv%10%' AND LOWER(name) NOT LIKE '%ghk%';

UPDATE products SET image_url = '/products/22_tesamorelin_5mg.png' 
WHERE LOWER(name) LIKE '%tesamorelin%5%';

UPDATE products SET image_url = '/products/23_tesamorelin_10mg.png' 
WHERE LOWER(name) LIKE '%tesamorelin%10%';

UPDATE products SET image_url = '/products/24_epitalon_10mg.png' 
WHERE LOWER(name) LIKE '%epitalon%10%';

UPDATE products SET image_url = '/products/25_epitalon_50mg.png' 
WHERE LOWER(name) LIKE '%epitalon%50%';

UPDATE products SET image_url = '/products/26_pt141_10mg.png' 
WHERE LOWER(name) LIKE '%pt141%' OR LOWER(name) LIKE '%pt-141%';

-- Verify the updates
SELECT name, image_url FROM products ORDER BY name;
