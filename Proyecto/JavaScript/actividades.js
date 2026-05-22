document.addEventListener("DOMContentLoaded", () => {
    // Ruta del archivo JSON que genera tu programa Java
    const rutaJson = "JSON/actividades_web.json"; 
    const contenedor = document.getElementById("contenedor-actividades");

    // Realizar la petición para leer el archivo JSON
    fetch(rutaJson)
        .then(response => {
            if (!response.ok) {
                throw new Error("No se pudo cargar el archivo JSON de actividades");
            }
            return response.json();
        })
        .then(actividades => {
            // Limpiamos el contenedor por si acaso
            contenedor.innerHTML = "";

            // Si no hay actividades en el JSON, mostramos un mensaje informativo
            if (actividades.length === 0) {
                contenedor.innerHTML = `<div class="col-12 text-center"><p>No hay actividades programadas en este momento.</p></div>`;
                return;
            }

            // Bucle para recorrer los objetos extraídos del JSON
            actividades.forEach((act, index) => {
                // Calculamos el número de actividad (1 al 10) según la posición del bucle
                const numeroActividad = index + 1;

                // Extraemos "a mano" los valores definidos en el HTML usando los atributos data-*
                // Si por alguna razón no existiera el atributo, asignamos un valor por defecto
                const capacidadSala = contenedor.getAttribute(`data-cap-${numeroActividad}`) || "20";
                const plazasLibres = contenedor.getAttribute(`data-lib-${numeroActividad}`) || "5";

                // Evaluamos si quedan pocas plazas para cambiar el color del texto a rojo si quedan 2 o menos
                const claseColorPlazas = parseInt(plazasLibres) <= 2 ? "text-danger fw-bold" : "text-success fw-bold";

                // Creamos la estructura de la tarjeta Bootstrap:
                // Los primeros datos vienen 100% del JSON y los aforos se toman de lo que pusiste a mano en el HTML
                const tarjetaHTML = `
                    <div class="col-md-4">
                        <div class="card actividad-card shadow">
                            <div class="card-body">
                                <h5 class="titulo-tarjeta">${act.nombre_actividad}</h5>
                                <p><strong>Sala:</strong> ${act.nombre_sala}</p>
                                <p><strong>Entrenador:</strong> ${act.nombre_entrenador}</p>
                                <p><strong>Fecha:</strong> ${act.fecha_inicio}</p>
                                <hr>
                                <p class="text-secondary small mb-1"><strong>Capacidad máxima:</strong> ${capacidadSala} personas</p>
                                <p class="mb-0 ${claseColorPlazas}"><strong>Plazas libres:</strong> ${plazasLibres} disponibles</p>
                            </div>
                        </div>
                    </div>
                `;
                // Inyectamos la tarjeta generada en el contenedor del HTML
                contenedor.innerHTML += tarjetaHTML;
            });
        })
        .catch(error => {
            console.error("Error al cargar las actividades:", error);
            contenedor.innerHTML = `<div class="col-12 text-center text-danger"><p>Error al cargar el panel de actividades.</p></div>`;
        });
});