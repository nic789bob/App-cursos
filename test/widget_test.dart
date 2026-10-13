import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_cursos/main.dart';

void main() {
  // testWidgets define una prueba sobre la interfaz gráfica de Flutter
  testWidgets('Valida carga inicial y posterior presentación de cursos', (
    WidgetTester tester,
  ) async {
    // 1. Inflamos y dibujamos la aplicación completa
    await tester.pumpWidget(const CatalogoCursosApp());

    // 2. Al iniciar, debe estar visible el CircularProgressIndicator y el texto de carga
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Cargando cursos disponibles...'), findsOneWidget);

    // 3. Simulamos el paso de los 2 segundos de la función asíncrona
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle(); // Espera a que terminen todas las animaciones

    // 4. Una vez cargado, el indicador de progreso ya NO debe aparecer
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // 5. Debe mostrarse en pantalla el nombre del primer curso cargado
    expect(find.text('Desarrollo de Apps Móviles con Flutter'), findsOneWidget);
  });
}
