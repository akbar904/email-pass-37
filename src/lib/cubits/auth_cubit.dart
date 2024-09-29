
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_package_name/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		// Simulate a login process
		final user = User(email: email);
		emit(Authenticated(user: user));
	}

	void logout() {
		emit(Unauthenticated());
	}
}
