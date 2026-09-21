-- ============================================================
-- schema.sql
-- Esquema de base de datos para Supabase (PostgreSQL)
-- Ejecutar manualmente en el SQL Editor de Supabase.
-- ============================================================

-- pgcrypto habilita la función gen_random_uuid() para generar
-- UUIDs por defecto en las columnas "id".
-- En Supabase normalmente ya está disponible, pero se declara
-- por seguridad en caso de que el proyecto no la tenga activa.
create extension if not exists pgcrypto;

-- ------------------------------------------------------------
-- Tabla: usuarios
-- Guarda las cuentas de los usuarios registrados en la app.
-- ------------------------------------------------------------
create table if not exists usuarios (
  id uuid primary key default gen_random_uuid(),
  email varchar(255) not null unique,
  password_hash text not null,
  nombre varchar(255),
  created_at timestamptz not null default now()
);

comment on table usuarios is 'Usuarios registrados en la plataforma';
comment on column usuarios.password_hash is 'Contraseña hasheada con bcrypt, nunca se guarda en texto plano';

-- ------------------------------------------------------------
-- Tabla: componentes
-- Catálogo de partes de PC (CPU, GPU, RAM, SSD, Motherboard, PSU, Case).
-- ------------------------------------------------------------
create table if not exists componentes (
  id uuid primary key default gen_random_uuid(),
  tipo varchar(20) not null check (
    tipo in ('CPU', 'GPU', 'RAM', 'SSD', 'Motherboard', 'PSU', 'Case')
  ),
  nombre varchar(255) not null,
  -- Especificaciones flexibles por tipo de componente (ej: sockets, watts, capacidad, etc.)
  especificaciones jsonb not null default '{}'::jsonb,
  precio numeric(10, 2) not null default 0,
  imagen_url text,
  created_at timestamptz not null default now()
);

comment on table componentes is 'Catálogo de componentes de PC disponibles';
comment on column componentes.tipo is 'Categoría del componente: CPU, GPU, RAM, SSD, Motherboard, PSU o Case';
comment on column componentes.especificaciones is 'Ficha técnica en formato JSON, varía según el tipo de componente';

-- Índice para filtrar rápido el catálogo por tipo de componente
create index if not exists idx_componentes_tipo on componentes (tipo);

-- Índice GIN para permitir búsquedas eficientes dentro del JSONB de especificaciones
create index if not exists idx_componentes_especificaciones on componentes using gin (especificaciones);

-- ------------------------------------------------------------
-- Tabla: rankings
-- Puntuación (1-10) que un usuario le da a un componente.
-- Un usuario solo puede puntuar una vez cada componente.
-- ------------------------------------------------------------
create table if not exists rankings (
  id uuid primary key default gen_random_uuid(),
  componente_id uuid not null references componentes (id) on delete cascade,
  usuario_id uuid not null references usuarios (id) on delete cascade,
  puntuacion int not null check (puntuacion >= 1 and puntuacion <= 10),
  created_at timestamptz not null default now(),
  unique (componente_id, usuario_id)
);

comment on table rankings is 'Puntuaciones de usuarios sobre componentes (1 a 10)';
comment on constraint rankings_componente_id_usuario_id_key on rankings is 'Un usuario solo puede puntuar un componente una vez';

create index if not exists idx_rankings_componente_id on rankings (componente_id);
create index if not exists idx_rankings_usuario_id on rankings (usuario_id);

-- ------------------------------------------------------------
-- Tabla: comentarios
-- Comentarios de texto libre que los usuarios dejan en un componente.
-- ------------------------------------------------------------
create table if not exists comentarios (
  id uuid primary key default gen_random_uuid(),
  componente_id uuid not null references componentes (id) on delete cascade,
  usuario_id uuid not null references usuarios (id) on delete cascade,
  texto text not null,
  created_at timestamptz not null default now()
);

comment on table comentarios is 'Comentarios de usuarios sobre componentes';

create index if not exists idx_comentarios_componente_id on comentarios (componente_id);
create index if not exists idx_comentarios_usuario_id on comentarios (usuario_id);
