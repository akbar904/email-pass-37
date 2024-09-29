
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/cubits/auth_cubit.dart';
import 'package:simple_flutter_app/cubits/auth_state.dart';
import 'package:simple_flutter_app/widgets/login_form.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocConsumer<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is Authenticated) {
						Navigator.of(context).pushReplacement(
							MaterialPageRoute(builder: (_) => HomeScreen()),
						);
					}
				},
				builder: (context, state) {
					if (state is AuthLoading) {
						return Center(child: CircularProgressIndicator());
					}
					return LoginForm();
				},
			),
		);
	}
}
