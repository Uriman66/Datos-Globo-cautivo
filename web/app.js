// Control de vistas
function mostrarVista(id) {
  document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
  document.getElementById(id).classList.add('active');
}

// Ir a selección de puertos
function irAPuertos() {
  mostrarVista('view-puertos');
  actualizarPuertos(); // auto-scan al entrar
}

// Simulación: Puertos disponibles (en versión real se consulta al backend)
function actualizarPuertos() {
  const lista = document.getElementById('lista-puertos');
  const mensaje = document.getElementById('mensaje-puertos');
  mensaje.textContent = 'Buscando puertos...';

  // Llamada real será con fetch('/api/puertos') en versión backend
  setTimeout(() => {
    const puertos = ['COM3', 'COM4', 'COM5']; // simulado
    lista.innerHTML = '';
    if (puertos.length === 0) {
      mensaje.textContent = 'No se encontraron puertos.';
    } else {
      puertos.forEach(p => {
        const opt = document.createElement('option');
        opt.textContent = p;
        opt.value = p;
        lista.appendChild(opt);
      });
      mensaje.textContent = 'Puertos encontrados:';
    }
  }, 1000);
}

function aceptarPuerto() {
  const puerto = document.getElementById('lista-puertos').value;
  console.log('Puerto seleccionado:', puerto);
  alert(`Puerto ${puerto} seleccionado`);
  // mostrarVista('view-siguiente'); // siguiente paso
}

let puertoSeleccionado = null;
let direccionSonda = null;

function aceptarPuerto() {
  const lista = document.getElementById('lista-puertos');
  puertoSeleccionado = lista.value;
  if (!puertoSeleccionado) {
    alert("Selecciona un puerto.");
    return;
  }

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
