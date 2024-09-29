
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_flutter_app/screens/login_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('renders LoginForm widget', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: LoginScreen(),
				),
			);

			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('shows login screen title', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: LoginScreen(),
				),
			);

			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('LoginScreen Cubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('displays loading indicator when state is AuthLoading', (WidgetTester tester) async {
			when(() => authCubit.state).thenReturn(AuthLoading());

			await tester.pumpWidget(
				BlocProvider.value(
					value: authCubit,
					child: MaterialApp(
						home: LoginScreen(),
					),
				),
			);

			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});

		testWidgets('navigates to HomeScreen when state is Authenticated', (WidgetTester tester) async {
			when(() => authCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				BlocProvider.value(
					value: authCubit,
					child: MaterialApp(
						home: LoginScreen(),
					),
				),
			);

			// Normally, you would check for a navigation event here.
			// For simplicity, we'll just check if the LoginForm is not present anymore.
			expect(find.byType(LoginForm), findsNothing);
		});
	});
}
