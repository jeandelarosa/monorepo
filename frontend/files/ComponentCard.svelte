<script>
  export let componente;

  const BADGE_COLORS = {
    CPU: 'bg-blue-600/20 text-blue-300 border-blue-500/40',
    GPU: 'bg-purple-600/20 text-purple-300 border-purple-500/40',
    RAM: 'bg-cyan-600/20 text-cyan-300 border-cyan-500/40',
    SSD: 'bg-emerald-600/20 text-emerald-300 border-emerald-500/40',
    Motherboard: 'bg-pink-600/20 text-pink-300 border-pink-500/40',
    PSU: 'bg-orange-600/20 text-orange-300 border-orange-500/40',
    Case: 'bg-slate-600/20 text-slate-300 border-slate-500/40',
  };

  $: badgeClass = BADGE_COLORS[componente.tipo] || BADGE_COLORS.Case;

  $: descripcion = componente.especificaciones
    ? Object.entries(componente.especificaciones)
        .map(([clave, valor]) => `${clave.replace(/_/g, ' ')}: ${valor}`)
        .join(' · ')
    : '';
</script>

<div
  class="group rounded-xl border border-gray-800 bg-gray-900 p-4 shadow transition-all duration-300 hover:-translate-y-1 hover:scale-105 hover:shadow-2xl hover:shadow-purple-900/30"
>
  {#if componente.imagen_url}
    <img
      src={componente.imagen_url}
      alt={componente.nombre}
      loading="lazy"
      class="mb-3 h-36 w-full rounded-lg object-cover"
    />
  {:else}
    <div class="mb-3 flex h-36 w-full items-center justify-center rounded-lg bg-gray-800 text-gray-600">
      Sin imagen
    </div>
  {/if}

  <span class="inline-block rounded-full border px-2 py-0.5 text-xs font-medium {badgeClass}">
    {componente.tipo}
  </span>

  <h3 class="mt-2 text-lg font-semibold text-white">{componente.nombre}</h3>

  {#if descripcion}
    <p class="mt-1 line-clamp-2 text-xs text-gray-400">{descripcion}</p>
  {/if}

  <p class="mt-3 text-xl font-bold text-cyan-400">${componente.precio}</p>
</div>
