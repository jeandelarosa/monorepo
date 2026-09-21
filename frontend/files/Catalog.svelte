<script>
  import { onMount } from 'svelte';
  import { fly } from 'svelte/transition';
  import { get } from '../lib/api.js';
  import ComponentCard from '../components/ComponentCard.svelte';

  const CATEGORIAS = ['CPU', 'GPU', 'RAM', 'SSD', 'Motherboard', 'PSU', 'Case'];

  let componentes = [];
  let loading = true;
  let error = '';
  let searchTerm = '';
  let categoriaActiva = 'Todos';

  onMount(async () => {
    try {
      const data = await get('/api/componentes');
      componentes = data.componentes;
    } catch (err) {
      error = err.message;
    } finally {
      loading = false;
    }
  });

  $: filtrados = componentes.filter((c) => {
    const coincideCategoria = categoriaActiva === 'Todos' || c.tipo === categoriaActiva;
    const coincideBusqueda = c.nombre.toLowerCase().includes(searchTerm.toLowerCase());
    return coincideCategoria && coincideBusqueda;
  });
</script>

<section class="px-4 py-10 sm:px-8">
  <h1 class="mb-2 text-3xl font-bold text-white">Catálogo</h1>
  <p class="mb-8 text-gray-400">Explora los componentes disponibles.</p>

  <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
    <input
      type="text"
      bind:value={searchTerm}
      placeholder="Buscar por nombre..."
      class="w-full rounded-lg border border-gray-700 bg-gray-900 px-4 py-2 text-white placeholder-gray-500 transition-colors focus:border-blue-500 focus:outline-none sm:max-w-xs"
    />

    <div class="flex flex-wrap gap-2">
      <button
        on:click={() => (categoriaActiva = 'Todos')}
        class="rounded-full px-3 py-1 text-sm transition-colors duration-200 {categoriaActiva === 'Todos' ? 'bg-blue-600 text-white' : 'bg-gray-800 text-gray-300 hover:bg-gray-700'}"
      >
        Todos
      </button>
      {#each CATEGORIAS as categoria}
        <button
          on:click={() => (categoriaActiva = categoria)}
          class="rounded-full px-3 py-1 text-sm transition-colors duration-200 {categoriaActiva === categoria ? 'bg-blue-600 text-white' : 'bg-gray-800 text-gray-300 hover:bg-gray-700'}"
        >
          {categoria}
        </button>
      {/each}
    </div>
  </div>

  {#if loading}
    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
      {#each Array(8) as _}
        <div class="animate-pulse rounded-xl border border-gray-800 bg-gray-900 p-4">
          <div class="mb-3 h-36 w-full rounded-lg bg-gray-800"></div>
          <div class="mb-2 h-4 w-16 rounded bg-gray-800"></div>
          <div class="mb-2 h-5 w-3/4 rounded bg-gray-800"></div>
          <div class="h-4 w-1/2 rounded bg-gray-800"></div>
        </div>
      {/each}
    </div>
  {:else if error}
    <p class="rounded bg-red-900/50 px-4 py-3 text-sm text-red-300">{error}</p>
  {:else if filtrados.length === 0}
    <p class="text-gray-400">No se encontraron componentes con esos filtros.</p>
  {:else}
    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
      {#each filtrados as componente, i (componente.id)}
        <div in:fly={{ y: 20, duration: 400, delay: i * 60 }}>
          <ComponentCard {componente} />
        </div>
      {/each}
    </div>
  {/if}
</section>
