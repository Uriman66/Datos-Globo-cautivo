// Control de vistas
function mostrarVista(id) {
    document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
    document.getElementById(id).classList.add('active');
}

// Ir a selección de puertos
function irAPuertos() {
    mostrarVista('view-puertos');
}

let puertoSeleccionado = null;
let direccionSonda = null;

function aceptarPuerto() {
    const inputPuerto = document.getElementById('input-puerto'); // Obtenemos el input de texto
    puertoSeleccionado = inputPuerto.value.trim(); // Obtenemos el valor y quitamos espacios en blanco

    if (!puertoSeleccionado) {
        alert("Por favor, ingresa un puerto.");
        return;
    }

    // Opcional: Puedes añadir una validación más robusta aquí para el formato del puerto
    // Por ejemplo, para asegurar que se parezca a 'COMX' o '/dev/ttyUSBX'
    // if (!/^COM\d+$/.test(puertoSeleccionado) && !/^\/dev\/ttyUSB\d+$/.test(puertoSeleccionado)) {
    //     alert("El formato del puerto no es válido. Ej: COM3 o /dev/ttyUSB0");
    //     return;
    // }

    document.getElementById('puerto-actual').textContent = puertoSeleccionado;
    mostrarVista('view-sonda');
}


function cambiarPuerto() {
    mostrarVista('view-puertos');
}

function direccionAuto() {
    // Funcionalidad pendiente, aquí solo mostramos un mensaje
    alert("Función automática no implementada.");
}

function aceptarDireccion() {
    const input = document.getElementById('direccion-sonda');
    direccionSonda = input.value.trim();

    if (!/^\d+$/.test(direccionSonda)) {
        alert("La dirección de la sonda no es válida.");
        return;
    }

    console.log(`Puerto: ${puertoSeleccionado}, Dirección: ${direccionSonda}`);
    // Aquí iría la siguiente vista: elige acción
    alert(`Puerto ${puertoSeleccionado}, Sonda ${direccionSonda} aceptados`);
    // mostrarVista('view-elige');  // siguiente paso
}

function mostrarMenuPrincipal() {
    document.getElementById('menu-puerto').textContent = puertoSeleccionado;
    document.getElementById('menu-sonda').textContent = direccionSonda;
    mostrarVista('view-menu');
}

function aceptarDireccion() {
    const input = document.getElementById('direccion-sonda');
    direccionSonda = input.value.trim();

    if (!/^\d+$/.test(direccionSonda)) {
        alert("La dirección de la sonda no es válida.");
        return;
    }

    mostrarMenuPrincipal();
}

function cambiarSonda() {
    mostrarVista('view-sonda');
}

function configurarSonda() {
    alert("Ir a vista de configuración de sonda (pendiente)");
    // mostrarVista('view-configuracion');
}

function datosTiempoReal() {
    alert("Ir a vista de datos en tiempo real (pendiente)");
    // mostrarVista('view-tiempo-real');
}

function recolectarDatos() {
    alert("Iniciar recuperación de datos (pendiente)");
    // mostrarVista('view-recuperacion');
}

let intervaloMuestreo = 10;
let intervaloAlmacenamiento = 30;
let sincronizarConPC = true;

function configurarSonda() {
    document.getElementById('conf-puerto').textContent = puertoSeleccionado;
    document.getElementById('conf-sonda').textContent = direccionSonda;

    // Prellenar valores
    document.getElementById('intervalo-muestreo').value = intervaloMuestreo;
    document.getElementById('intervalo-almacenamiento').value = intervaloAlmacenamiento;
    document.querySelector(`input[name="hora"][value="${sincronizarConPC ? 'pc' : 'manual'}"]`).checked = true;

    mostrarVista('view-configuracion');
}

function cancelarConfiguracion() {
    mostrarMenuPrincipal();
}

function aceptarConfiguracion() {
    intervaloMuestreo = parseInt(document.getElementById('intervalo-muestreo').value);
    intervaloAlmacenamiento = parseInt(document.getElementById('intervalo-almacenamiento').value);
    sincronizarConPC = document.querySelector('input[name="hora"]:checked').value === 'pc';

    if (intervaloMuestreo < 1 || intervaloMuestreo > 60 || intervaloAlmacenamiento < 1 || intervaloAlmacenamiento > 60) {
        alert("Los intervalos deben estar entre 1 y 60 segundos.");
        return;
    }

    // Aquí enviarías al backend los datos por fetch() (no implementado aún)
    console.log({
        puerto: puertoSeleccionado,
        direccion: direccionSonda,
        sincConPC: sincronizarConPC,
        iSample: intervaloMuestreo,
        iSave: intervaloAlmacenamiento,
    });

    alert("Configuración enviada con éxito.");
    mostrarMenuPrincipal();
}

function recolectarDatos() {
    mostrarVista('view-data');
    console.log("recolectando datos");
}

function datosTiempoReal() {
    mostrarVista('view-real');
    console.log("recolectando datos");
}
