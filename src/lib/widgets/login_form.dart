
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_flutter_app/cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					TextFormField(
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your email';
							}
							return null;
						},
					),
					TextFormField(
						controller: _passwordController,
						decoration: InputDecoration(labelText: 'Password'),
						obscureText: true,
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your password';
							}
							return null;
						},
					),
					ElevatedButton(
						onPressed: () {
							if (_formKey.currentState!.validate()) {
								BlocProvider.of<AuthCubit>(context).login(
									_emailController.text,
									_passwordController.text,
								);
							}
						},
						child: Text('Login'),
					),
				],
			),
		);
	}
}
