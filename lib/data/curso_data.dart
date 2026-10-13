// Usamos List<Map<String, dynamic>>:
// - List: Una lista ordenada de elementos (corchetes []).
// - Map: Un conjunto de pares clave-valor (llaves {}).
// - String: Las claves siempre son texto (por ejemplo: 'nombre', 'docente').
// - dynamic: Los valores pueden ser de diferentes tipos (String, int, bool, double)

// - duracion: int (número entero de horas, ideal para cálculos o filtros).
// - certificado: bool (true/false, valor lógico).
final List<Map<String, dynamic>> cursos = [
  {
    'nombre': 'Desarrollo de Apps Móviles con Flutter',
    'docente': 'Ing. Carlos Mendoza',
    'duracion': 45, // int: 45 duración de curso
    'nivel': 'Intermedio', // String: Dificultad del curso
    'certificado': true, // bool: Sí incluye certificado
    'calificacion': 4.9, // double: Calificación promedio
    'categoria': 'Móvil', // String: Área temática
  },
  {
    'nombre': 'Fundamentos de Programación en Dart',
    'docente': 'Lic. Andrea Gómez',
    'duracion': 30, // int: 30 duración de curso
    'nivel': 'Principiante',
    'certificado': true, // bool: Sí incluye certificado
    'calificacion': 4.7, // double: Calificación
    'categoria': 'Lenguajes',
  },
  {
    'nombre': 'Arquitectura Limpia y Buenas Prácticas',
    'docente': 'MSc. Fernando Romero',
    'duracion': 50, // int: 50 duración de curso
    'nivel': 'Avanzado',
    'certificado': true, // bool: Sí incluye certificado
    'calificacion': 5.0, // double: Calificación perfecta
    'categoria': 'Arquitectura',
  },
  {
    'nombre': 'Diseño de Interfaces de Usuario (UI/UX)',
    'docente': 'Dis. Mariana Silva',
    'duracion': 25, // int: 25 duración de curso
    'nivel': 'Principiante',
    'certificado': false, // bool: No incluye certificado (taller rápido)
    'calificacion': 4.6, // double: Calificación
    'categoria': 'Diseño',
  },
  {
    'nombre': 'Gestión de Estado y Servicios Backend',
    'docente': 'Ing. Roberto Paz',
    'duracion': 40, // int: 40 horas
    'nivel': 'Intermedio',
    'certificado': true, // bool: Sí incluye certificado
    'calificacion': 4.8, // double: Calificación
    'categoria': 'Backend & Cloud',
  },
];

// Función asíncrona que simula una consulta de red

// Conceptos clave explicados de forma simple:
// - Future<...>: Promesa de que en el futuro obtendremos una lista de cursos.
// - async: Palabra clave que se coloca antes del cuerpo de la función para
//          permitir el uso de 'await' sin bloquear la aplicación.
// - await: Pausa la ejecución de esta función hasta que la tarea termine
//          (en este caso, esperar los 2 segundos de conexión).
Future<List<Map<String, dynamic>>> obtenerCursosSimulados() async {
  // Future.delayed simula el tiempo de espera que tarda un servidor en responder
  await Future.delayed(const Duration(seconds: 2));

  // Una vez pasados los 2 segundos, retornamos la lista de cursos
  return cursos;
}
