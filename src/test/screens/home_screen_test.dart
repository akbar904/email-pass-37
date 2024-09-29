
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_flutter_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mocking necessary dependencies
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		// Test if HomeScreen contains a LogoutButton
		testWidgets('should display LogoutButton', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.byType(LogoutButton), findsOneWidget);
		});

		// Test if HomeScreen contains specific text 'Home'
		testWidgets('should display Home text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Home'), findsOneWidget);
		});
	});
}
