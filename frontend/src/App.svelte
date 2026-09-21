<script>
  import { onMount } from 'svelte';

  let selectedCategory = 'all';
  let animateTitle = false;
  let floatingObjects = [];
  let mouseX = 0;
  let mouseY = 0;
  let animationFrameId;

  onMount(() => {
    animateTitle = true;
    // Crear objetos flotantes
    floatingObjects = Array.from({ length: 12 }, (_, i) => ({
      id: i,
      icon: ['💻', '⚙️', '<>', '📱', '🔧', '🎨', '📊', '⚡', '🔐', '🌐', '📡', '🖱️'][i],
      left: Math.random() * 100,
      top: Math.random() * 100,
      duration: 15 + Math.random() * 10,
      delay: Math.random() * 5,
      size: 40 + Math.random() * 40,
      opacity: 0.1 + Math.random() * 0.3,
      offsetX: 0,
      offsetY: 0,
      currentOffsetX: 0,
      currentOffsetY: 0,
    }));

    // Escuchar movimiento del mouse
    document.addEventListener('mousemove', handleMouseMove);

    // Iniciar animación continua
    function animate() {
      floatingObjects = floatingObjects.map(obj => {
        const objElement = document.getElementById(`float-${obj.id}`);
        if (objElement) {
          const rect = objElement.getBoundingClientRect();
          const objCenterX = rect.left + rect.width / 2;
          const objCenterY = rect.top + rect.height / 2;

          // Calcular distancia y ángulo del mouse al objeto
          const dx = mouseX - objCenterX;
          const dy = mouseY - objCenterY;
          const distance = Math.sqrt(dx * dx + dy * dy);

          // Radio de influencia del mouse (en píxeles)
          const radius = 250;

          if (distance < radius) {
            // Calcular fuerza repulsiva (mientras más cerca, más fuerte)
            const force = (1 - distance / radius) * 60;
            const angle = Math.atan2(dy, dx);

            // Invertir la dirección para repeler
            obj.offsetX = -Math.cos(angle) * force;
            obj.offsetY = -Math.sin(angle) * force;
          } else {
            // Volver a la posición original lentamente
            obj.offsetX = obj.offsetX * 0.85;
            obj.offsetY = obj.offsetY * 0.85;
          }

          // Suavizar la transición actual
          obj.currentOffsetX += (obj.offsetX - obj.currentOffsetX) * 0.15;
          obj.currentOffsetY += (obj.offsetY - obj.currentOffsetY) * 0.15;

          // Aplicar transformación
          objElement.style.transform = `translate(${obj.currentOffsetX}px, ${obj.currentOffsetY}px)`;
        }
        return obj;
      });

      animationFrameId = requestAnimationFrame(animate);
    }

    animate();

    return () => {
      document.removeEventListener('mousemove', handleMouseMove);
      cancelAnimationFrame(animationFrameId);
    };
  });

  function handleMouseMove(event) {
    mouseX = event.clientX;
    mouseY = event.clientY;
  }

  const components = [
    { id: 1, name: 'Intel Core i9-14900K', category: 'cpu', rating: 9.8, price: '$589' },
    { id: 2, name: 'NVIDIA RTX 4090', category: 'gpu', rating: 9.9, price: '$1,599' },
    { id: 3, name: 'Corsair Vengeance 64GB', category: 'ram', rating: 9.6, price: '$299' },
    { id: 4, name: 'Samsung 990 Pro 2TB', category: 'ssd', rating: 9.7, price: '$199' },
    { id: 5, name: 'ASUS ROG STRIX Z890', category: 'motherboard', rating: 9.5, price: '$549' },
    { id: 6, name: 'Corsair HX1500i', category: 'psu', rating: 9.4, price: '$349' },
  ];

  const programs = [
    { id: 1, name: 'Visual Studio Code', type: 'IDE', rating: 9.8 },
    { id: 2, name: 'Git & GitHub', type: 'Version Control', rating: 9.7 },
    { id: 3, name: 'Docker', type: 'Containerization', rating: 9.6 },
    { id: 4, name: 'Node.js', type: 'Runtime', rating: 9.8 },
    { id: 5, name: 'Svelte', type: 'Frontend Framework', rating: 9.5 },
    { id: 6, name: 'Express.js', type: 'Backend Framework', rating: 9.7 },
  ];

  const filteredComponents = selectedCategory === 'all' 
    ? components 
    : components.filter(c => c.category === selectedCategory);

  const categories = [
    { value: 'all', label: 'Todos' },
    { value: 'cpu', label: 'Procesadores' },
    { value: 'gpu', label: 'Tarjetas Gráficas' },
    { value: 'ram', label: 'Memoria RAM' },
    { value: 'ssd', label: 'Almacenamiento' },
  ];
</script>

<style>
  @keyframes float {
    0%, 100% {
      transform: translateY(0px) translateX(0px) rotate(0deg);
      opacity: var(--opacity);
    }
    25% {
      transform: translateY(-30px) translateX(20px) rotate(90deg);
      opacity: calc(var(--opacity) * 0.5);
    }
    50% {
      transform: translateY(-60px) translateX(-20px) rotate(180deg);
      opacity: var(--opacity);
    }
    75% {
      transform: translateY(-30px) translateX(30px) rotate(270deg);
      opacity: calc(var(--opacity) * 0.5);
    }
  }

  @keyframes glow {
    0%, 100% {
      text-shadow: 0 0 10px rgba(16, 185, 129, 0.3);
    }
    50% {
      text-shadow: 0 0 30px rgba(16, 185, 129, 0.6);
    }
  }

  :global(body) {
    background: linear-gradient(135deg, #0a0e27 0%, #1a1a3e 100%);
    color: #fff;
    margin: 0;
    padding: 0;
  }

  .floating-objects-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 1;
    overflow: hidden;
  }

  .floating-object {
    position: absolute;
    font-size: var(--size, 40px);
    opacity: var(--opacity, 0.2);
    animation: float var(--duration, 20s) ease-in-out var(--delay, 0s) infinite;
    filter: blur(0.5px);
    will-change: transform;
  }

  .hero {
    position: relative;
    z-index: 10;
    min-height: 100vh;
    background: linear-gradient(135deg, rgba(15, 52, 96, 0.9) 0%, rgba(26, 26, 62, 0.9) 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }

  .hero-content {
    text-align: center;
    z-index: 2;
    animation: fadeInUp 1s ease-out;
  }

  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(30px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .hero-title {
    font-size: 4rem;
    font-weight: 900;
    margin: 0 0 20px 0;
    background: linear-gradient(135deg, #10b981 0%, #06b6d4 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    animation: glow 3s ease-in-out infinite;
  }

  .hero-subtitle {
    font-size: 1.5rem;
    color: #a0aec0;
    margin-bottom: 15px;
  }

  .hero-description {
    font-size: 1.1rem;
    color: #cbd5e0;
    max-width: 600px;
    margin-bottom: 40px;
    line-height: 1.6;
  }

  .cta-button {
    padding: 15px 40px;
    font-size: 1rem;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(135deg, #10b981 0%, #06b6d4 100%);
    border: none;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
  }

  .cta-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 40px rgba(16, 185, 129, 0.5);
  }

  .section {
    position: relative;
    z-index: 10;
    padding: 80px 40px;
    background: linear-gradient(135deg, #1a1a3e 0%, #0f3460 100%);
    margin: 40px 0;
  }

  .section-title {
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 10px;
    background: linear-gradient(135deg, #10b981 0%, #06b6d4 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .section-subtitle {
    text-align: center;
    color: #a0aec0;
    font-size: 1.1rem;
    margin-bottom: 40px;
  }

  .filters {
    display: flex;
    gap: 15px;
    justify-content: center;
    margin-bottom: 50px;
    flex-wrap: wrap;
  }

  .filter-btn {
    padding: 10px 20px;
    background: rgba(16, 185, 129, 0.1);
    border: 2px solid rgba(16, 185, 129, 0.3);
    color: #10b981;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 600;
  }

  .filter-btn:hover {
    background: rgba(16, 185, 129, 0.2);
    border-color: #10b981;
  }

  .filter-btn.active {
    background: linear-gradient(135deg, #10b981 0%, #06b6d4 100%);
    border-color: transparent;
    color: #fff;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    max-width: 1200px;
    margin: 0 auto;
  }

  .card {
    background: linear-gradient(135deg, rgba(15, 52, 96, 0.5) 0%, rgba(26, 26, 62, 0.5) 100%);
    border: 1px solid rgba(16, 185, 129, 0.2);
    padding: 30px;
    border-radius: 15px;
    transition: all 0.3s ease;
    cursor: pointer;
  }

  .card:hover {
    transform: translateY(-10px);
    border-color: #10b981;
    box-shadow: 0 20px 40px rgba(16, 185, 129, 0.2);
    background: linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(6, 182, 212, 0.1) 100%);
  }

  .card-title {
    font-size: 1.3rem;
    margin: 0 0 8px 0;
    color: #10b981;
  }

  .card-subtitle {
    color: #a0aec0;
    font-size: 0.9rem;
    margin-bottom: 15px;
  }

  .card-rating {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
  }

  .stars {
    font-size: 1rem;
  }

  .rating-number {
    color: #06b6d4;
    font-weight: 600;
  }

  .card-price {
    color: #10b981;
    font-size: 1.3rem;
    font-weight: 700;
    margin: 0;
  }

  footer {
    position: relative;
    z-index: 10;
    background: linear-gradient(135deg, #0a0e27 0%, #1a1a3e 100%);
    padding: 30px;
    text-align: center;
    color: #a0aec0;
    border-top: 1px solid rgba(16, 185, 129, 0.1);
  }

  @media (max-width: 768px) {
    .hero-title {
      font-size: 2.5rem;
    }

    .section {
      padding: 40px 20px;
    }

    .grid {
      grid-template-columns: 1fr;
    }
  }
</style>

<div class="floating-objects-container">
  {#each floatingObjects as obj (obj.id)}
    <div 
      id="float-{obj.id}"
      class="floating-object"
      style="
        left: {obj.left}%;
        top: {obj.top}%;
        --size: {obj.size}px;
        --duration: {obj.duration}s;
        --delay: {obj.delay}s;
        --opacity: {obj.opacity};
      "
    >
      {obj.icon}
    </div>
  {/each}
</div>

<section class="hero">
  <div class="hero-content">
    <h1 class="hero-title">Jean Sebastian de la Rosa Escobedo</h1>
    <h2 class="hero-subtitle">Catálogo de Componentes & Programas Profesionales</h2>
    <p class="hero-description">
      Descubre los mejores componentes de hardware y herramientas de desarrollo para potenciar tu productividad. 
      Desde procesadores de última generación hasta frameworks modernos.
    </p>
    <button class="cta-button" on:click={() => window.scrollTo({top: window.innerHeight, behavior: 'smooth'})}>
      Explorar Catálogo
    </button>
  </div>
</section>

<section class="section">
  <h2 class="section-title">🖥️ Componentes Premium</h2>
  <p class="section-subtitle">Hardware de última generación para máximo rendimiento</p>
  
  <div class="filters">
    {#each categories as category (category.value)}
      <button 
        class="filter-btn {selectedCategory === category.value ? 'active' : ''}"
        on:click={() => selectedCategory = category.value}
      >
        {category.label}
      </button>
    {/each}
  </div>

  <div class="grid">
    {#each filteredComponents as component (component.id)}
      <div class="card">
        <h3 class="card-title">{component.name}</h3>
        <p class="card-subtitle">{component.category.toUpperCase()}</p>
        <div class="card-rating">
          <span class="stars">{'⭐'.repeat(Math.floor(component.rating))}</span>
          <span class="rating-number">{component.rating}</span>
        </div>
        <p class="card-price">{component.price}</p>
      </div>
    {/each}
  </div>
</section>

<section class="section">
  <h2 class="section-title">💻 Herramientas de Desarrollo</h2>
  <p class="section-subtitle">Los mejores programas y frameworks para desarrolladores</p>
  
  <div class="grid">
    {#each programs as program (program.id)}
      <div class="card">
        <h3 class="card-title">{program.name}</h3>
        <p class="card-subtitle">{program.type}</p>
        <div class="card-rating">
          <span class="stars">{'⭐'.repeat(Math.floor(program.rating))}</span>
          <span class="rating-number">{program.rating}</span>
        </div>
      </div>
    {/each}
  </div>
</section>

<footer>
  <p>© 2026 Jean Sebastian de la Rosa Escobedo. Todos los derechos reservados. | Desarrollado con Svelte + Node.js</p>
</footer>