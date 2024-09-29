
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('App initializes with LoginScreen', (WidgetTester tester) async {
			when(() => authCubit.state).thenReturn(Unauthenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => authCubit,
					child: MyApp(),
				),
			);

			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
			expect(find.byType(ElevatedButton), findsOneWidget); // Login button
		});

		testWidgets('App navigates to HomeScreen on authentication', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([Unauthenticated(), Authenticated()]),
				initialState: Unauthenticated(),
			);

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => authCubit,
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();

			expect(find.text('Home'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget); // Logout button
		});

		testWidgets('App navigates back to LoginScreen on logout', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream.fromIterable([Authenticated(), Unauthenticated()]),
				initialState: Authenticated(),
			);

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => authCubit,
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();

			expect(find.text('Login'), findsOneWidget);
		});
	});
}
