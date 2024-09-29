
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/widgets/logout_button.dart';

// Mocking the AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('displays the logout button with correct text', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (context) => mockAuthCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LogoutButton(),
						),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('calls logout when the button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (context) => mockAuthCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LogoutButton(),
						),
					),
				),
			);

			final logoutButton = find.byType(ElevatedButton);
			expect(logoutButton, findsOneWidget);

			await tester.tap(logoutButton);
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
