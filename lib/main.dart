import 'package:flutter/material.dart';

// Importamos nuestra pantalla principal donde se muestra el catálogo de cursos
import 'screens/home_screen.dart';

// Función principal: Es lo primero que se ejecuta al iniciar la aplicación
void main() {
  // runApp se encarga de inflar y dibujar el widget principal en la pantalla del celular
  runApp(const CatalogoCursosApp());
}

// StatelessWidget: Es un widget sin estado propio, no cambia por sí solo una vez creado
class CatalogoCursosApp extends StatelessWidget {
  const CatalogoCursosApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp configura el diseño global, tema y navegación de la app
    return MaterialApp(
      title: 'Catálogo de Cursos',

      // Oculta la etiqueta roja de "DEBUG" en la esquina superior derecha
      debugShowCheckedModeBanner: false,

      // Configuración de colores y estilo visual usando Material 3
      theme: ThemeData(
        useMaterial3: true,
        // Genera una paleta de colores coherente a partir de un color base (índigo)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        // Estilo predeterminado para las barras superiores (AppBar)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),

      // 'home' indica cuál es la primera pantalla que verá el usuario
      home: const HomeScreen(),
    );
  }
}
