import 'package:flutter/material.dart';

import '../data/curso_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable booleana: true si los datos aún se están cargando, false si ya terminaron
  bool _estaCargando = true;

  // Lista local para guardar los cursos que recibamos de la función asíncrona
  List<Map<String, dynamic>> _cursos = [];

  // initState: Se ejecuta una sola vez de forma automática cuando la pantalla se abre
  @override
  void initState() {
    super.initState();
    // Llamamos a la función para empezar a cargar los datos de inmediato
    _cargarCursos();
  }

  // Función asíncrona para obtener los cursos y actualizar la pantalla
  Future<void> _cargarCursos() async {
    // Activamos el modo de carga para mostrar el círculo de progreso
    setState(() {
      _estaCargando = true;
    });

    // Usamos 'await' para esperar la respuesta de la función simulada (2 segundos)
    final resultado = await obtenerCursosSimulados();

    // Verificamos si la pantalla sigue abierta antes de modificar su estado
    if (!mounted) return;

    // Guardamos los datos recibidos y apagamos el modo de carga
    // setState le dice a Flutter: "Vuelve a dibujar la pantalla con los nuevos datos"
    setState(() {
      _cursos = resultado;
      _estaCargando = false;
    });
  }

  // Función simple para elegir un color según el nivel del curso
  Color _obtenerColorNivel(String nivel) {
    switch (nivel.toLowerCase()) {
      case 'principiante':
        return Colors.green; // Verde principiante
      case 'intermedio':
        return Colors.blue; // Azul intermedio
      case 'avanzado':
        return Colors.deepPurple; // Morado avanzado
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provee la estructura básica de una pantalla (barra superior y cuerpo)
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        // Título visible de la app solicitado en el taller
        title: const Text(
          'Catálogo de Cursos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Centra el texto en la barra superior
        actions: [
          // Botón en la esquina superior para volver a cargar los cursos
          // Muy útil para mostrar el indicador de carga durante el video tutorial
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar cursos',
            onPressed: _estaCargando ? null : _cargarCursos,
          ),
        ],
      ),
      // Si _estaCargando es true, muestra el indicador de carga.
      // Si es false, muestra la lista de cursos en tarjetas.
      body: _estaCargando
          ? _construirIndicadorCarga()
          : _construirListaCursos(),
    );
  }

  // Indicador de carga

  Widget _construirIndicadorCarga() {
    return Center(
      // Center coloca todo exactamente en el centro de la pantalla
      child: Column(
        // Column ordena los elementos de forma vertical (uno debajo de otro)
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Indicador circular de progreso requerido en el taller
          CircularProgressIndicator(),
          SizedBox(height: 16), // Espacio vertical de 16 píxeles
          // Mensaje informativo para el usuario mientras espera
          Text(
            'Cargando cursos disponibles...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Lista con tarjetas de cursos
  Widget _construirListaCursos() {
    return RefreshIndicator(
      // Permite al usuario arrastrar hacia abajo para volver a recargar
      onRefresh: _cargarCursos,
      // ListView.builder construye solo las tarjetas visibles, optimizando la memoria
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _cursos.length, // Cantidad total de cursos a dibujar
        itemBuilder: (context, index) {
          // Extraemos el curso actual de la lista según su posición (índice)
          final curso = _cursos[index];
          // Obtenemos el color adecuado según el nivel del curso
          final colorNivel = _obtenerColorNivel(curso['nivel'] as String);

          // Card: Tarjeta visual con sombra y esquinas redondeadas
          return Card(
            elevation: 3, // Efecto de sombra para dar profundidad
            margin: const EdgeInsets.only(
              bottom: 14,
            ), // Separación entre tarjetas
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16,
              ), // Bordes curvos y modernos
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                16.0,
              ), // Margen interno de la tarjeta
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinea el texto a la izquierda
                children: [
                  // --- FILA SUPERIOR: Categoría y Nivel ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Uno a la izq y otro a la der
                    children: [
                      // Etiqueta de Categoría
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          curso['categoria'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      // Etiqueta de Nivel (con color dinámico según la dificultad)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorNivel.withValues(
                            alpha: 0.15,
                          ), // Fondo suave
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: colorNivel,
                            width: 1,
                          ), // Borde de color
                        ),
                        child: Text(
                          curso['nivel'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: colorNivel,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Separador
                  // --- NOMBRE DEL CURSO ---
                  Text(
                    curso['nombre'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12), // Separador
                  // --- DOCENTE (con icono de persona) ---
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(
                        'Docente: ${curso['docente']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Separador
                  Row(
                    children: [
                      // Icono de reloj y duración en horas (valor int)
                      const Icon(
                        Icons.access_time_filled,
                        size: 18,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${curso['duracion']} horas de clase',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(), // Empuja la calificación hacia el extremo derecho
                      // Icono de estrella y calificación (valor double)
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${curso['calificacion']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Separador
                  // --- CERTIFICADO (Se muestra solo si es true - valor bool) ---
                  if (curso['certificado'] as bool)
                    Row(
                      children: const [
                        Icon(Icons.verified, size: 16, color: Colors.teal),
                        SizedBox(width: 6),
                        Text(
                          'Certificado de finalización incluido',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
