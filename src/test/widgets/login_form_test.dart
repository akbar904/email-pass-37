
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_flutter_app/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_flutter_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_flutter_app/cubits/auth_state.dart';

// Mock AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('initial state shows email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('shows login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('calls login method when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			// Enter email and password
			await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
			await tester.enterText(find.byType(TextFormField).last, 'password123');

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => mockAuthCubit.login('test@example.com', 'password123')).called(1);
		});
	});
}
