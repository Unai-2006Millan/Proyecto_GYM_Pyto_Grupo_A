// Leemos el archivo JSON que exportó tu aplicación Java
fetch('JSON/horario_web.json')
    .then(respuesta => respuesta.json())
    .then(actividades => {
        
        // Recorremos la lista de actividades del JSON una por una
        actividades.forEach(act => {
            
            // Creamos un objeto Fecha en JS a partir del texto "2026-05-18"
            // Le añadimos 'T00:00:00' para evitar desfases de zonas horarias al leer la fecha
            const objetoFecha = new Date(act.fecha + 'T00:00:00');
            
            // Lista para saber qué día corresponde al número que nos da JS (0=Domingo, 1=Lunes...)
            const diasTxt = ['domingo', 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'];
            const nombreDia = diasTxt[objetoFecha.getDay()]; 

            // Buscamos la celda usando el ID. Ejemplo: "lunes-08:00"
            const celda = document.getElementById(`${nombreDia}-${act.hora}`);
            
            // Si la celda existe en nuestro HTML, le metemos el nombre de la actividad
            if (celda) {
                celda.innerText = act.nombre_actividad;
            }
        });
        
    })
    .catch(error => console.error("Error cargando el archivo JSON:", error));