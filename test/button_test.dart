import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pv239_qwiz/common/widget/button.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  testWidgets('Button executes callback when pressed', (WidgetTester tester) async {
    final mockCallback = MockCallback();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Button(
          label: 'Test button',
          onPressed: mockCallback,
        ),
      ),
    );

    await tester.tap(find.text('Test button'));

    verify(mockCallback.call()).called(1);
  });
}
