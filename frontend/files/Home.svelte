<script>
  import { fade } from 'svelte/transition';
  import ThreeBackground from '../components/ThreeBackground.svelte';
  import { navigate } from '../lib/router.js';

  let scrollY = 0;

  function goToCatalog(e) {
    e.preventDefault();
    navigate('/catalog');
  }
</script>

<svelte:window bind:scrollY />

<section class="relative flex min-h-[90vh] items-center justify-center overflow-hidden">
  <ThreeBackground />

  <div
    class="pointer-events-none absolute inset-0 bg-gradient-to-br from-blue-950 via-purple-950 to-slate-950 opacity-80"
    style="transform: translateY({scrollY * 0.2}px)"
  ></div>

  <div
    class="relative z-10 flex flex-col items-center px-4 text-center"
    in:fade={{ duration: 800 }}
  >
    <h1
      class="mb-4 bg-gradient-to-r from-cyan-400 via-blue-400 to-purple-400 bg-clip-text text-4xl font-extrabold text-transparent sm:text-5xl md:text-6xl"
    >
      Jean Sebastian de la Rosa Escobedo
    </h1>

    <p class="mb-8 max-w-xl text-lg text-gray-300 sm:text-xl">
      Catálogo Interactivo de Componentes para Programación
    </p>

    <button
      on:click={goToCatalog}
      class="rounded-full bg-gradient-to-r from-blue-600 via-purple-600 to-cyan-500 px-8 py-3 font-semibold text-white shadow-lg transition-transform duration-300 hover:scale-105 hover:shadow-2xl"
    >
      Ver catálogo
    </button>
  </div>
</section>
