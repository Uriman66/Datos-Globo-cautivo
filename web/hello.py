import os
import logging
import datetime
import random
from flask import Flask, render_template, request, jsonify, send_from_directory
import pandas as pd
import simulador

# --- Configuración de la Aplicación ---
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
logging.basicConfig(level=logging.DEBUG)
recoleccion_progreso = {"progreso": 0, "completado": True, "datos": None, "filename": None}

# --- Funciones de Ayuda ---
def read_file(file_path):
    try:
        datos = pd.read_csv(file_path, sep=',')
        if len(datos.columns) <= 1:
            raise ValueError("No parece ser un CSV válido.")
        print(f"Archivo '{file_path}' leído exitosamente como CSV.")
    except (ValueError, pd.errors.ParserError):
        try:
            datos = pd.read_csv(file_path, sep=r'\t')
            if len(datos.columns) <= 1:
                 raise ValueError("El formato del archivo no se pudo determinar.")
            print(f"Archivo '{file_path}' leído exitosamente como TXT.")
        except Exception as e:
            logging.error(f"No se pudo leer el archivo '{file_path}': {e}")
            return pd.DataFrame()
    
    if 'Tiempo' not in datos.columns:
        if 'fecha' in datos.columns and 'hora' in datos.columns:
            datos['Tiempo'] = datos['fecha'] + ' ' + datos['hora']
    return datos

# --- Rutas Principales de la UI ---
@app.route('/')
def index():
    return render_template('index.html')

# --- Endpoints de la API ---
@app.route('/enviar_puerto', methods=['POST'])
def recibir_puerto():
    data = request.get_json()
    puerto = data.get('puerto', 'Desconocido')
    if puerto.upper() == "COM1":
        return jsonify({'status': 'error', 'mensaje': f'Error simulado: El puerto {puerto} está ocupado.'}), 400
    logging.info(f"Puerto simulado conectado: {puerto}")
    return jsonify({'status': 'success', 'mensaje': f'Conectado correctamente en el puerto {puerto}'})

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'archivo' not in request.files:
        return jsonify({'mensaje': "No se encontró el campo 'archivo' en el formulario"}), 400
    file = request.files['archivo']
    if file.filename == '':
        return jsonify({'mensaje': 'No se seleccionó ningún archivo'}), 400
    try:
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(filepath)
        contenido_archivo = read_file(filepath)
        if contenido_archivo.empty:
            return jsonify({'mensaje': f'El archivo "{file.filename}" está vacío o tiene un formato no válido.'}), 400
        contenido_json = contenido_archivo.to_dict(orient='records')
        return jsonify({
            'mensaje': f"Archivo '{file.filename}' subido y procesado correctamente.",
            'contenido': contenido_json
        })
    except Exception as e:
        logging.error(f"Error crítico al procesar el archivo subido: {e}")
        return jsonify({'mensaje': 'Ocurrió un error inesperado al procesar el archivo.'}), 500

# === Endpoints de SIMULACIÓN ===
@app.route('/get_realtime_data', methods=['GET'])
def get_realtime_data():
    dato_simulado = simulador.generar_dato_tiempo_real()
    return jsonify(dato_simulado)

@app.route('/start_recollection', methods=['POST'])
def start_recollection():
    global recoleccion_progreso
    if not recoleccion_progreso["completado"]:
        recoleccion_progreso['completado']

    data = request.get_json()
    formato_elegido = data.get('formato', 'txt')
    print(f"Iniciando recolección en formato .{formato_elegido}...")
    
    nombre_base = f"{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.{formato_elegido}"
    ruta_completa = os.path.join(app.config['UPLOAD_FOLDER'], nombre_base)
    
    # Generamos los datos y los guardamos en el estado Y en el archivo
    datos_df = simulador.generar_dataframe_simulado(lineas=100)
    if formato_elegido == 'csv':
        datos_df.to_csv(ruta_completa, sep=',', index=False)
    else:
        datos_df.to_csv(ruta_completa, sep='\t', index=False)
    
    recoleccion_progreso = {
        "progreso": 0, "completado": False,
        "datos": datos_df.to_dict(orient='records'),
        "filename": nombre_base
    }
    return jsonify({"status": "success", "mensaje": "Proceso de recolección iniciado."})

@app.route('/get_recollection_progress', methods=['GET'])
def get_recollection_progress():
    global recoleccion_progreso
    if recoleccion_progreso["completado"]:
        return jsonify({"progreso": 100, "completado": True, "datos": None, "filename": None})

    recoleccion_progreso["progreso"] += random.randint(15, 30)

    if recoleccion_progreso["progreso"] >= 100:
        recoleccion_progreso["progreso"] = 100
        recoleccion_progreso["completado"] = True
        return jsonify({
            "progreso": 100, 
            "completado": True, 
            "datos": recoleccion_progreso["datos"],
            "filename": recoleccion_progreso["filename"]
        })
    else:
        return jsonify({
            "progreso": recoleccion_progreso["progreso"], 
            "completado": False, 
            "datos": None,
            "filename": None
        })

@app.route('/download_file/<path:filename>', methods=['GET'])
def download_file(filename):
    try:
        return send_from_directory(app.config['UPLOAD_FOLDER'], filename, as_attachment=True)
    except FileNotFoundError:
        return jsonify({'mensaje': 'Archivo no encontrado.'}), 404

# --- Bloque de Ejecución ---
if __name__ == '__main__':
    app.run(debug=True, port=5000)