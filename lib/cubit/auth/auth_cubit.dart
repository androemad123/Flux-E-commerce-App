import 'dart:developer';

import 'package:depi_graduation/data/auth/auth_data_source.dart';
import 'package:depi_graduation/cubit/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authDataSource}) : super(AuthState());
  final AuthDataSource authDataSource;
  void togglePasswordVisibility() =>
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));

  void resetAuthState() {
    emit(AuthState());
  }

  String _getErrorMessage(dynamic error) {
    final String errorString = error.toString().toLowerCase();

    if (errorString.contains('email-already-in-use')) {
      return 'This email is already registered. Please try logging in instead.';
    } else if (errorString.contains('weak-password')) {
      return 'Password is too weak. Please choose a stronger password.';
    } else if (errorString.contains('invalid-credential')) {
      return 'Incorrect email or password, please try again.';
    } else if (errorString.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (errorString.contains('user-not-found')) {
      return 'No account found with this email. Please register first.';
    } else if (errorString.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (errorString.contains('network')) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An error occurred. Please try again.';
    }
  }

  Future<void> login({String? email, String? password}) async {
    emit(
      state.copyWith(
        isLoginLoading: true,
        isLoginError: false,
        isLoginSuccess: false,
      ),
    );
    try {
      await authDataSource.login(
        email!,
        password!,
      );
      emit(state.copyWith(isLoginLoading: false, isLoginSuccess: true));
      // Reset state after successful login
      Future.delayed(const Duration(milliseconds: 500), () {
        resetAuthState();
      });
    } catch (e) {
      emit(state.copyWith(
        isLoginLoading: false,
        isLoginError: true,
        loginErrorMessage: _getErrorMessage(e),
      ));
      log(e.toString());
    }
  }

  Future<void> register({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    emit(
      state.copyWith(
        isRegisterLoading: true,
        isRegisterError: false,
        isRegisterSuccess: false,
      ),
    );

    try {
      await authDataSource.register(
        name!,
        email!,
        // phone!,
        password!,
      );
      emit(state.copyWith(isRegisterLoading: false, isRegisterSuccess: true));
      // Reset state after successful registration
      Future.delayed(const Duration(milliseconds: 500), () {
        resetAuthState();
      });
    } catch (e) {
      emit(state.copyWith(
        isRegisterLoading: false,
        isRegisterError: true,
        registerErrorMessage: _getErrorMessage(e),
      ));
      log(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(
      state.copyWith(
        isLoginLoading: true,
        isLoginError: false,
        isLoginSuccess: false,
      ),
    );
    try {
      await authDataSource.signInWithGoogle();
      emit(state.copyWith(isLoginLoading: false, isLoginSuccess: true));
      // Reset state after successful login
      Future.delayed(const Duration(milliseconds: 500), () {
        resetAuthState();
      });
    } catch (e) {
      emit(state.copyWith(
        isLoginLoading: false,
        isLoginError: true,
        loginErrorMessage: _getErrorMessage(e),
      ));
      log(e.toString());
    }
  }
}
