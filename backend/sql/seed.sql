-- ============================================================
-- seed.sql
-- Datos de ejemplo para poblar la tabla "componentes".
-- Ejecutar manualmente en el SQL Editor de Supabase,
-- después de haber corrido schema.sql.
-- ============================================================

-- ------------------------------------------------------------
-- CPUs (5 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'CPU',
  'AMD Ryzen 5 7600X',
  '{"socket": "AM5", "nucleos": 6, "hilos": 12, "frecuencia_base_ghz": 4.7, "frecuencia_turbo_ghz": 5.3, "tdp_w": 105}',
  299.99,
  'https://example.com/img/ryzen-5-7600x.jpg'
),
(
  'CPU',
  'AMD Ryzen 7 7800X3D',
  '{"socket": "AM5", "nucleos": 8, "hilos": 16, "frecuencia_base_ghz": 4.2, "frecuencia_turbo_ghz": 5.0, "tdp_w": 120}',
  449.99,
  'https://example.com/img/ryzen-7-7800x3d.jpg'
),
(
  'CPU',
  'Intel Core i5-13600K',
  '{"socket": "LGA1700", "nucleos": 14, "hilos": 20, "frecuencia_base_ghz": 3.5, "frecuencia_turbo_ghz": 5.1, "tdp_w": 125}',
  319.99,
  'https://example.com/img/core-i5-13600k.jpg'
),
(
  'CPU',
  'Intel Core i7-13700K',
  '{"socket": "LGA1700", "nucleos": 16, "hilos": 24, "frecuencia_base_ghz": 3.4, "frecuencia_turbo_ghz": 5.4, "tdp_w": 125}',
  409.99,
  'https://example.com/img/core-i7-13700k.jpg'
),
(
  'CPU',
  'Intel Core i9-14900K',
  '{"socket": "LGA1700", "nucleos": 24, "hilos": 32, "frecuencia_base_ghz": 3.2, "frecuencia_turbo_ghz": 6.0, "tdp_w": 125}',
  589.99,
  'https://example.com/img/core-i9-14900k.jpg'
);

-- ------------------------------------------------------------
-- GPUs (3 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'GPU',
  'NVIDIA GeForce RTX 4070',
  '{"vram_gb": 12, "tipo_memoria": "GDDR6X", "bus_memoria_bit": 192, "tdp_w": 200, "conector_alimentacion": "1x 12VHPWR"}',
  599.99,
  'https://example.com/img/rtx-4070.jpg'
),
(
  'GPU',
  'NVIDIA GeForce RTX 4080 Super',
  '{"vram_gb": 16, "tipo_memoria": "GDDR6X", "bus_memoria_bit": 256, "tdp_w": 320, "conector_alimentacion": "1x 12VHPWR"}',
  999.99,
  'https://example.com/img/rtx-4080-super.jpg'
),
(
  'GPU',
  'AMD Radeon RX 7800 XT',
  '{"vram_gb": 16, "tipo_memoria": "GDDR6", "bus_memoria_bit": 256, "tdp_w": 263, "conector_alimentacion": "2x 8-pin"}',
  549.99,
  'https://example.com/img/rx-7800-xt.jpg'
);

-- ------------------------------------------------------------
-- RAM (2 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'RAM',
  'Corsair Vengeance DDR5 32GB (2x16GB) 6000MHz',
  '{"capacidad_gb": 32, "tipo": "DDR5", "velocidad_mhz": 6000, "latencia_cl": 30, "modulos": 2}',
  109.99,
  'https://example.com/img/corsair-vengeance-ddr5-32gb.jpg'
),
(
  'RAM',
  'Kingston Fury Beast DDR4 16GB (2x8GB) 3200MHz',
  '{"capacidad_gb": 16, "tipo": "DDR4", "velocidad_mhz": 3200, "latencia_cl": 16, "modulos": 2}',
  49.99,
  'https://example.com/img/kingston-fury-beast-ddr4-16gb.jpg'
);

-- ------------------------------------------------------------
-- SSDs (2 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'SSD',
  'Samsung 990 Pro 1TB NVMe',
  '{"capacidad_gb": 1000, "interfaz": "PCIe 4.0 NVMe", "lectura_mb_s": 7450, "escritura_mb_s": 6900, "factor_forma": "M.2 2280"}',
  99.99,
  'https://example.com/img/samsung-990-pro-1tb.jpg'
),
(
  'SSD',
  'Western Digital Blue SA510 500GB SATA',
  '{"capacidad_gb": 500, "interfaz": "SATA III", "lectura_mb_s": 560, "escritura_mb_s": 520, "factor_forma": "2.5 pulgadas"}',
  39.99,
  'https://example.com/img/wd-blue-sa510-500gb.jpg'
);

-- ------------------------------------------------------------
-- Motherboards (2 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'Motherboard',
  'ASUS ROG Strix B650-A Gaming WiFi',
  '{"socket": "AM5", "chipset": "B650", "formato": "ATX", "ranuras_ram": 4, "ram_max_gb": 128, "wifi": true}',
  229.99,
  'https://example.com/img/asus-rog-strix-b650-a.jpg'
),
(
  'Motherboard',
  'MSI PRO Z790-A WiFi',
  '{"socket": "LGA1700", "chipset": "Z790", "formato": "ATX", "ranuras_ram": 4, "ram_max_gb": 128, "wifi": true}',
  219.99,
  'https://example.com/img/msi-pro-z790-a.jpg'
);

-- ------------------------------------------------------------
-- PSUs (2 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'PSU',
  'Corsair RM750e 750W 80+ Gold',
  '{"potencia_w": 750, "certificacion": "80+ Gold", "modular": "Full", "formato": "ATX"}',
  99.99,
  'https://example.com/img/corsair-rm750e.jpg'
),
(
  'PSU',
  'EVGA SuperNOVA 650 GT 650W 80+ Gold',
  '{"potencia_w": 650, "certificacion": "80+ Gold", "modular": "Full", "formato": "ATX"}',
  79.99,
  'https://example.com/img/evga-supernova-650-gt.jpg'
);

-- ------------------------------------------------------------
-- Cases (2 ejemplos)
-- ------------------------------------------------------------
insert into componentes (tipo, nombre, especificaciones, precio, imagen_url) values
(
  'Case',
  'NZXT H5 Flow',
  '{"formato": "ATX Mid Tower", "compatibilidad_mb": ["ATX", "Micro-ATX", "Mini-ITX"], "ventiladores_incluidos": 2, "panel_lateral": "Vidrio templado"}',
  94.99,
  'https://example.com/img/nzxt-h5-flow.jpg'
),
(
  'Case',
  'Lian Li Lancool 216',
  '{"formato": "ATX Mid Tower", "compatibilidad_mb": ["E-ATX", "ATX", "Micro-ATX", "Mini-ITX"], "ventiladores_incluidos": 3, "panel_lateral": "Vidrio templado"}',
  109.99,
  'https://example.com/img/lian-li-lancool-216.jpg'
);
