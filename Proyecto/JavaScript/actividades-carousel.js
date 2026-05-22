document.addEventListener("DOMContentLoaded", () => {
  // Referencias a elementos del DOM
  const contenedor = document.getElementById("contenedor-actividades"); // contenedor de tarjetas
  const prevBtn = document.getElementById("prev-btn"); // botón anterior
  const nextBtn = document.getElementById("next-btn"); // botón siguiente

  // Configuración de paginación del "carousel"
  const pageSize = 3; // pageSize: número de tarjetas visibles por página
  let page = 0;       // page: índice de página actual (0-based)

  /**
   * updateButtons(totalItems)
   * Actualiza el estado (disabled) de los botones prev/next según la página actual y el total de elementos.
   * totalItems: número total de tarjetas en el contenedor.
   */
  function updateButtons(totalItems) {
    prevBtn.disabled = page === 0;
    nextBtn.disabled = (page + 1) * pageSize >= totalItems;
  }

  /**
   * showPage()
   * Muestra solo los elementos correspondientes a la página actual y oculta el resto.
   * Calcula el slice visible en función de page y pageSize.
   */
  function showPage() {
    const items = Array.from(contenedor.children).filter(n => n.nodeType === 1);
    const total = items.length;
    if (total === 0) return; // no hay elementos, no hacer nada
    const start = page * pageSize;
    // Recorremos todos los elementos y togglamos la clase d-none según corresponda
    items.forEach((el, i) => {
      if (i >= start && i < start + pageSize) {
        el.classList.remove("d-none"); // visible
      } else {
        el.classList.add("d-none");    // oculto
      }
    });
    updateButtons(total);
    // opcional: desplazar vista al contenedor para mejorar UX al cambiar de página
    const wrapper = document.getElementById("carousel-wrapper");
    if (wrapper) wrapper.scrollIntoView({ behavior: "smooth", block: "nearest" });
  }

  // Eventos para navegación
  prevBtn.addEventListener("click", () => {
    if (page > 0) {
      page--;
      showPage();
    }
  });

  nextBtn.addEventListener("click", () => {
    const total = Array.from(contenedor.children).length;
    if ((page + 1) * pageSize < total) {
      page++;
      showPage();
    }
  });

  // Observador para detectar cuando actividades.js añade las tarjetas al DOM
  const observer = new MutationObserver((mutations) => {
    const total = Array.from(contenedor.children).length;
    if (total > 0) {
      // inicializar: mostrar primera página y habilitar botón next si procede
      page = 0;
      showPage();
    }
  });

  if (contenedor) {
    observer.observe(contenedor, { childList: true, subtree: false });
    // Si ya hubiera contenido (por alguna razón), inicializar ahora
    if (contenedor.children.length > 0) {
      showPage();
    }
  }
});