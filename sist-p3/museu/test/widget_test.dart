import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:museu/main.dart';

void main() {
  testWidgets('cadastra, edita, cancela e exclui obras', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Lista()));

    expect(find.text('Museu'), findsOneWidget);
    expect(find.text('Nenhum registro'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pump();
    expect(find.text('Preencha todos os campos'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '   ');
    await tester.enterText(find.byType(TextField).at(1), 'Tarsila do Amaral');
    await tester.enterText(find.byType(TextField).at(2), 'Óleo');
    await tester.tap(find.text('Salvar'));
    await tester.pump();
    expect(find.text('Preencha todos os campos'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Abaporu');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Abaporu'), findsOneWidget);
    expect(find.text('Tarsila do Amaral'), findsOneWidget);
    expect(find.text('Óleo'), findsOneWidget);
    expect(find.text('Nenhum registro'), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Operários');
    await tester.enterText(find.byType(TextField).at(1), 'Tarsila do Amaral');
    await tester.enterText(find.byType(TextField).at(2), 'Óleo');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Abaporu'), findsOneWidget);
    expect(find.text('Operários'), findsOneWidget);

    await tester.tap(find.text('Abaporu'));
    await tester.pumpAndSettle();
    expect(find.text('Editar'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(2), 'Óleo sobre tela');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Abaporu'), findsOneWidget);
    expect(find.text('Óleo sobre tela'), findsOneWidget);
    expect(find.text('Operários'), findsOneWidget);

    await tester.tap(find.text('Operários'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Mudou');
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(find.text('Operários'), findsOneWidget);
    expect(find.text('Mudou'), findsNothing);

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();
    expect(find.text('Abaporu'), findsNothing);
    expect(find.text('Operários'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text('Nenhum registro'), findsOneWidget);
  });
}
