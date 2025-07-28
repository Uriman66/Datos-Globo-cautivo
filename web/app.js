// ===============================================
// CONTROL DE VISTAS Y ESTADO DE LA APLICACIÓN
// ===============================================
let puertoSeleccionado = null;
let direccionSonda = null;
let intervaloMuestreo = 10;
let intervaloAlmacenamiento = 30;
let sincronizarConPC = true;
let realTimeInterval = null;
let recollectionInterval = null;
let datosRecolectados = null;

// Objeto para almacenar las instancias de las gráficas
const charts = {
    altura: null,
    tiempo: null,
    viento: null
};

// Definir el modo oscuro
const darkTheme = {
    color: ['#3398DB', '#E5323E', '#50a3ba', '#e5a23d', '#96b42d'],
    backgroundColor: 'rgba(30, 30, 30, 0)',
    textStyle: { color: '#e0e0e0' },
    title: { textStyle: { color: '#e0e0e0' } },
    legend: { textStyle: { color: '#e0e0e0' } },
    tooltip: { axisPointer: { lineStyle: { color: '#e0e0e0' }, crossStyle: { color: '#e0e0e0' } } },
    xAxis: { axisLine: { lineStyle: { color: '#6c757d' } }, axisLabel: { textStyle: { color: '#e0e0e0' } } },
    yAxis: { axisLine: { lineStyle: { color: '#6c757d' } }, axisLabel: { textStyle: { color: '#e0e0e0' } } },
    toolbox: { iconStyle: { borderColor: '#e0e0e0' } }
};
echarts.registerTheme('dark_theme', darkTheme);

function mostrarVista(id) {
    document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
    document.getElementById(id).classList.add('active');
}

function mostrarMensaje(vistaId, texto, tipo = 'danger') {
    const vista = document.getElementById(vistaId);
    if (!vista) return;
    const mensajeEl = vista.querySelector('.mensaje');
    if (!mensajeEl) return;
    mensajeEl.className = `mensaje alert alert-${tipo}`; 
    mensajeEl.textContent = texto;
    mensajeEl.style.display = 'block';
}

function limpiarMensajes(vistaId) {
    const vista = document.getElementById(vistaId);
    if (!vista) return;
    const mensajeEl = vista.querySelector('.mensaje');
    if (mensajeEl) {
        mensajeEl.style.display = 'none';
    }
}

function actualizarBarraDeEstado() {
    const statusPuerto = document.getElementById('status-puerto');
    const statusSonda = document.getElementById('status-sonda');
    statusPuerto.textContent = puertoSeleccionado || '--';
    statusSonda.textContent = direccionSonda || '--';
}

// ===============================================
// FLUJO 1: CONTROL DE SONDA (UI)
// ===============================================
function irAPuertos() { mostrarVista('view-puertos'); }

function aceptarPuerto() {
    const inputPuerto = document.getElementById('input-puerto');
    const botonAceptar = document.querySelector('#view-puertos .btn-primary');
    puertoSeleccionado = inputPuerto.value.trim();
    actualizarBarraDeEstado(); 

    if (!puertoSeleccionado) {
        mostrarMensaje('view-puertos', "Por favor, ingresa un nombre de puerto válido.");
        return;
    }

    botonAceptar.disabled = true;
    botonAceptar.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Conectando...`;
    limpiarMensajes('view-puertos');

    fetch('/enviar_puerto', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ puerto: puertoSeleccionado })
    })
    .then(res => {
        if (!res.ok) {
            return res.json().then(err => { throw new Error(err.mensaje || 'Error desconocido del servidor'); });
        }
        return res.json();
    })
    .then(data => {
        document.getElementById('puerto-actual').textContent = puertoSeleccionado;
        mostrarVista('view-sonda');
    })
    .catch(error => {
        console.error('Error al aceptar puerto:', error);
        mostrarMensaje('view-puertos', error.message);
    })
    .finally(() => {
        botonAceptar.disabled = false;
        botonAceptar.textContent = 'Aceptar';
    });
}

function aceptarDireccion() {
    const input = document.getElementById('direccion-sonda');
    direccionSonda = input.value.trim();
    
    if (!/^\d+$/.test(direccionSonda) || direccionSonda === "") {
        mostrarMensaje('view-sonda', "La dirección de la sonda debe ser un número.");
        return;
    }
    
    actualizarBarraDeEstado();
    limpiarMensajes('view-sonda');
    mostrarMenuPrincipal();
}

function mostrarMenuPrincipal() {
    document.getElementById('menu-puerto').textContent = puertoSeleccionado;
    document.getElementById('menu-sonda').textContent = direccionSonda;
    mostrarVista('view-menu');
}

function cambiarSonda() { mostrarVista('view-sonda'); }

function configurarSonda() {
    document.getElementById('conf-puerto').textContent = puertoSeleccionado;
    document.getElementById('conf-sonda').textContent = direccionSonda;
    document.getElementById('intervalo-muestreo').value = intervaloMuestreo;
    document.getElementById('intervalo-almacenamiento').value = intervaloAlmacenamiento;
    document.querySelector(`input[name="hora"][value="${sincronizarConPC ? 'pc' : 'manual'}"]`).checked = true;
    mostrarVista('view-configuracion');
}

function cancelarConfiguracion() { mostrarMenuPrincipal(); }

function aceptarConfiguracion() {
    intervaloMuestreo = parseInt(document.getElementById('intervalo-muestreo').value);
    intervaloAlmacenamiento = parseInt(document.getElementById('intervalo-almacenamiento').value);
    sincronizarConPC = document.querySelector('input[name="hora"]:checked').value === 'pc';
    if (isNaN(intervaloMuestreo) || isNaN(intervaloAlmacenamiento) || intervaloMuestreo < 1 || intervaloMuestreo > 60 || intervaloAlmacenamiento < 1 || intervaloAlmacenamiento > 60) {
        mostrarMensaje('view-configuracion', "Los intervalos deben ser números entre 1 y 60 segundos."); return;
    }
    alert("Configuración enviada con éxito (simulado).");
    mostrarMenuPrincipal();
}

// --- Flujo de Recolección de Datos ---
function recolectarDatos() {
    mostrarVista('view-data');
    const progressBar = document.getElementById('recoleccion-progressbar');
    const statusText = document.getElementById('recoleccion-status');
    const resultadoDiv = document.getElementById('recoleccion-resultado');
    const cancelarBtn = document.getElementById('recoleccion-cancelar-btn');
    const menuBtn = document.getElementById('recoleccion-menu-btn');
    
    progressBar.style.width = '0%';
    progressBar.textContent = '0%';
    progressBar.setAttribute('aria-valuenow', 0);
    progressBar.classList.add('progress-bar-animated');
    progressBar.classList.remove('bg-success');
    statusText.textContent = 'Iniciando recolección...';
    statusText.classList.remove('text-danger');
    resultadoDiv.style.display = 'none';
    resultadoDiv.innerHTML = '';
    cancelarBtn.style.display = 'inline-block';
    menuBtn.style.display = 'none';
    
    const formatoSeleccionado = document.getElementById('formato-archivo').value;
    
    fetch('/start_recollection', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ formato: formatoSeleccionado })
    })
    .then(res => {
        if (!res.ok) {
            return res.json().then(err => { throw new Error(err.mensaje || 'Respuesta no válida del servidor'); });
        }
        return res.json();
    })
    .then(data => {
        console.log(data.mensaje);
        if (recollectionInterval) clearInterval(recollectionInterval);
        recollectionInterval = setInterval(consultarProgreso, 1000);
    })
    .catch(err => {
        console.error(err);
        statusText.textContent = 'Error: ' + err.message;
        statusText.classList.add('text-danger');
    });
}

function consultarProgreso() {
    const progressBar = document.getElementById('recoleccion-progressbar');
    const statusText = document.getElementById('recoleccion-status');
    const resultadoDiv = document.getElementById('recoleccion-resultado');
    const cancelarBtn = document.getElementById('recoleccion-cancelar-btn');
    const menuBtn = document.getElementById('recoleccion-menu-btn');

    fetch('/get_recollection_progress')
        .then(res => res.json())
        .then(data => {
            const progreso = data.progreso;
            progressBar.style.width = `${progreso}%`;
            progressBar.textContent = `${progreso}%`;
            progressBar.setAttribute('aria-valuenow', progreso);
            statusText.textContent = `Recolectando datos... ${progreso}%`;

            if (data.completado && data.datos && data.filename) {
                clearInterval(recollectionInterval);
                recollectionInterval = null;
                statusText.textContent = '¡Recolección completada!';
                progressBar.classList.remove('progress-bar-animated');
                progressBar.classList.add('bg-success');
                
                datosRecolectados = data.datos;
                
                resultadoDiv.style.display = 'block';
                resultadoDiv.innerHTML = `
                    <div class="alert alert-success">
                        Archivo <strong>${data.filename}</strong> generado con éxito.
                    </div>
                    <div class="d-flex justify-content-center gap-2">
                        <a href="/download_file/${data.filename}" class="btn btn-success" download>
                            <i class="bi bi-download"></i> Descargar Archivo
                        </a>
                        <button class="btn btn-info" onclick="graficarDatosRecolectados()">
                            <i class="bi bi-bar-chart-line"></i> Graficar Datos
                        </button>
                    </div>
                `;

                cancelarBtn.style.display = 'none';
                menuBtn.style.display = 'inline-block';
            }
        })
        .catch(err => {
            console.error(err);
            statusText.textContent = 'Error de conexión durante la recolección.';
            clearInterval(recollectionInterval);
        });
}

function cancelarRecoleccion() {
    if (recollectionInterval) {
        clearInterval(recollectionInterval);
        recollectionInterval = null;
    }
    console.log("Recolección cancelada por el usuario.");
    mostrarMenuPrincipal();
}

// --- Flujo de Datos en Tiempo Real ---
function datosTiempoReal() {
    mostrarVista('view-real');
    if (realTimeInterval) clearInterval(realTimeInterval);
    actualizarDatosReales(); 
    realTimeInterval = setInterval(actualizarDatosReales, 3000);
}

function actualizarDatosReales() {
    fetch('/get_realtime_data')
        .then(res => res.json())
        .then(data => {
            document.getElementById('real-temp').innerHTML = `${data.temperatura} <small class="text-muted">°C</small>`;
            document.getElementById('real-hum').innerHTML = `${data.humedad} <small class="text-muted">%</small>`;
            document.getElementById('real-pres').innerHTML = `${data.presion} <small class="text-muted">hPa</small>`;
            document.getElementById('real-wind-speed').innerHTML = `${data.velocidad_viento} <small class="text-muted">m/s</small>`;
            document.getElementById('real-wind-dir').innerHTML = `${data.direccion_viento} <small class="text-muted">°</small>`;
            document.getElementById('wind-rose-img').src = obtenerImagenViento(data.direccion_viento);
        })
        .catch(err => {
            console.error("Error obteniendo datos en tiempo real:", err);
            detenerTiempoReal(); 
            alert("Se perdió la conexión con la sonda.");
        });
}

function detenerTiempoReal() {
    if (realTimeInterval) {
        clearInterval(realTimeInterval);
        realTimeInterval = null;
    }
    mostrarMenuPrincipal();
}

function obtenerImagenViento(grados) {
    const angulosDisponibles = [0, 22, 45, 67, 90, 112, 135, 157, 180, 202, 225, 247, 270, 292, 315, 337];
    let anguloMasCercano = -1;
    let distanciaMinima = Infinity;

    for (const angulo of angulosDisponibles) {
        const diff = Math.abs(angulo - grados);
        const distancia = Math.min(diff, 360 - diff);
        if (distancia < distanciaMinima) {
            distanciaMinima = distancia;
            anguloMasCercano = angulo;
        }
    }
    
    const nombreArchivo = `FLECHA${anguloMasCercano}.gif`;
    return `static/images/${nombreArchivo}`;
}

// ===============================================
// FLUJO 2: ANÁLISIS DE ARCHIVOS
// ===============================================
function irASeleccionarArchivo() { mostrarVista('view-insertar-archivo'); }

function regresarPortada() { 
    puertoSeleccionado = null;
    direccionSonda = null;
    actualizarBarraDeEstado();
    mostrarVista('view-portada'); 
}

function handleFileUpload(event) {
    event.preventDefault();
    const form = event.target;
    const formData = new FormData(form);
    const botonSubmit = form.querySelector('button[type="submit"]');

    botonSubmit.disabled = true;
    botonSubmit.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Cargando...`;

    fetch('/upload', { method: 'POST', body: formData })
    .then(res => res.ok ? res.json() : res.json().then(err => { throw new Error(err.mensaje || 'Error en el servidor'); }))
    .then(data => {
        const contenido = data.contenido;
        if (contenido && contenido.length > 0) {
            mostrarTabla(contenido);
            mostrarVista('view-graficas');
            setTimeout(() => {
                renderAllCharts(contenido);
            }, 100);
        } else {
            alert(data.mensaje || "El archivo no contenía datos válidos o estaba vacío.");
        }
    })
    .catch(err => { console.error('Error al subir archivos:', err); mostrarMensaje('view-insertar-archivo', 'Error al subir el archivo: ' + err.message); })
    .finally(() => {
        botonSubmit.disabled = false;
        botonSubmit.textContent = 'Subir y Graficar';
    });
}

function mostrarTabla(datos) {
    const contenedor = document.getElementById('tabla-container');
    contenedor.innerHTML = '';
    if (datos.length === 0) { contenedor.textContent = "No hay datos para mostrar."; return; }
    const tabla = document.createElement('table');
    tabla.className = 'table table-striped table-hover table-sm';
    const encabezados = Object.keys(datos[0]);
    const thead = tabla.createTHead();
    const filaCabecera = thead.insertRow();
    encabezados.forEach(col => { const th = document.createElement('th'); th.scope = 'col'; th.textContent = col; filaCabecera.appendChild(th); });
    const tbody = tabla.createTBody();
    datos.forEach(fila => { const row = tbody.insertRow(); encabezados.forEach(col => { const cell = row.insertCell(); cell.textContent = fila[col]; }); });
    contenedor.appendChild(tabla);
}

function mostrarContenido() { mostrarVista('view-contenido'); }
function mostrarGraficas() { mostrarVista('view-graficas'); }

// ===============================================
// LÓGICA DE GRÁFICOS Y RELACIONADOS
// ===============================================

function graficarDatosRecolectados() {
    if (!datosRecolectados) {
        alert("No hay datos recolectados para graficar.");
        return;
    }
    console.log("Graficando los datos recién recolectados...");
    mostrarTabla(datosRecolectados);
    mostrarVista('view-graficas');
    setTimeout(() => {
        renderAllCharts(datosRecolectados);
    }, 100);
}

function renderAllCharts(datosRaw) {
    // Preprocesar los datos: convertir a número y ordenar
    const datos = datosRaw.map(d => ({
        Altura: parseFloat(d['Altura']),
                                     Temperatura: parseFloat(d['Temperatura']),
                                     Humedad: parseFloat(d['Humedad']),
                                     Presión: parseFloat(d['Presión']),
                                     Ozono: parseFloat(d['Ozono']),
                                     Tiempo: d['Tiempo'], // Asumimos que ya es string bien formateado
                                     Dirección: parseFloat(d['Dirección']),
                                     Velocidad: parseFloat(d['Velocidad'])
    }));

    // Ordenar por Altura para la gráfica correspondiente
    const datosPorAltura = [...datos].sort((a, b) => a.Altura - b.Altura);
    // Ordenar por Tiempo si deseas, aunque puede ser innecesario si ya viene ordenado

    graficarVariablesVsAltura(datosPorAltura);
    graficarVariablesVsTiempo(datos);
    graficarViento(datos);
}


function graficarVariablesVsAltura(datos) {
    const chartDom = document.getElementById('chart');
    if (charts.altura) { charts.altura.dispose(); }
    const isDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    charts.altura = echarts.init(chartDom, isDarkMode ? 'dark_theme' : null);
    const option = {
        title: { text: 'Variables vs Altura' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'cross' } },
        legend: { data: ['Temperatura', 'Humedad', 'Presión', 'Ozono'] },
        xAxis: { type: 'value', name: 'Altura (m)', nameLocation: 'middle', nameGap: 30 },
        yAxis: { type: 'value', name: 'Valor de Variable' },
        toolbox: { feature: { saveAsImage: { title: 'Guardar como imagen' }, dataZoom: { title: { zoom: 'Hacer zoom', back: 'Restaurar zoom' } }, restore: { title: 'Restaurar' } } },
        dataZoom: [ { type: 'slider', start: 0, end: 100 } ],
        series: [
            { name: 'Temperatura', type: 'line', smooth: true, data: datos.map(d => [d['Altura'], d['Temperatura']]) },
            { name: 'Humedad', type: 'line', smooth: true, data: datos.map(d => [d['Altura'], d['Humedad']]) },
            { name: 'Presión', type: 'line', smooth: true, data: datos.map(d => [d['Altura'], d['Presión']]) },
            { name: 'Ozono', type: 'line', smooth: true, data: datos.map(d => [d['Altura'], d['Ozono']]) }
        ]
    };
    charts.altura.setOption(option);
}

function graficarVariablesVsTiempo(datos) {
    const chartDom = document.getElementById('chart-tiempo');
    if (charts.tiempo) { charts.tiempo.dispose(); }
    const isDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    charts.tiempo = echarts.init(chartDom, isDarkMode ? 'dark_theme' : null);
    const option = { /* ... tu configuración de gráfica ... */
        title: { text: 'Variables vs Tiempo' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'cross' } },
        legend: { data: ['Temperatura', 'Humedad', 'Presión', 'Ozono'] },
        xAxis: { type: 'category', name: 'Tiempo', data: datos.map(d => d['Tiempo']) },
        yAxis: { type: 'value', name: 'Valor de Variable' },
        toolbox: { feature: { saveAsImage: { title: 'Guardar como imagen' }, dataZoom: { title: { zoom: 'Hacer zoom', back: 'Restaurar zoom' } }, restore: { title: 'Restaurar' } } },
        dataZoom: [ { type: 'slider', start: 0, end: 100 } ],
        series: [
            { name: 'Temperatura', type: 'line', smooth: true, data: datos.map(d => d['Temperatura']) },
            { name: 'Humedad', type: 'line', smooth: true, data: datos.map(d => d['Humedad']) },
            { name: 'Presión', type: 'line', smooth: true, data: datos.map(d => d['Presión']) },
            { name: 'Ozono', type: 'line', smooth: true, data: datos.map(d => d['Ozono']) }
        ]
    };
    charts.tiempo.setOption(option);
}

function graficarViento(datos) {
    const chartDom = document.getElementById('chart-viento');
    if (charts.viento) { charts.viento.dispose(); }
    const isDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    charts.viento = echarts.init(chartDom, isDarkMode ? 'dark_theme' : null);
    const option = { /* ... tu configuración de gráfica ... */
        title: { text: 'Dirección e Intensidad del Viento vs Tiempo' },
        tooltip: { trigger: 'axis' },
        legend: { data: ['Dirección (°)', 'Velocidad (m/s)'] },
        xAxis: { type: 'category', name: 'Tiempo', data: datos.map(d => d['Tiempo']) },
        yAxis: { type: 'value', name: 'Valor' },
        toolbox: { feature: { saveAsImage: { title: 'Guardar como imagen' }, dataZoom: { title: { zoom: 'Hacer zoom', back: 'Restaurar zoom' } }, restore: { title: 'Restaurar' } } },
        dataZoom: [ { type: 'slider', start: 0, end: 100 } ],
        series: [
            { name: 'Dirección (°)', type: 'line', smooth: true, data: datos.map(d => parseFloat(d['Dirección'])) },
            { name: 'Velocidad (m/s)', type: 'line', smooth: true, data: datos.map(d => parseFloat(d['Velocidad'])) }
        ]
    };
    charts.viento.setOption(option);
}

// ===============================================
// INICIALIZACIÓN Y EVENTOS GLOBALES
// ===============================================
function inicializarApp() {
    const form = document.getElementById('uploadForm');
    if (form) {
        form.addEventListener('submit', handleFileUpload);
    }
    actualizarBarraDeEstado();
    mostrarVista('view-portada');

    window.addEventListener('resize', () => {
        for (const chartName in charts) {
            if (charts[chartName]) {
                charts[chartName].resize();
            }
        }
    });
}

document.addEventListener('DOMContentLoaded', inicializarApp);
