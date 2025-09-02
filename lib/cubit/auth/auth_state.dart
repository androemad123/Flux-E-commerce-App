class AuthState {
  final bool isPasswordVisible;
  final bool? isLoginLoading;
  final bool? isLoginSuccess;
  final bool? isLoginError;
  final String? loginErrorMessage;
  final bool? isRegisterLoading;
  final bool? isRegisterSuccess;
  final bool? isRegisterError;
  final String? registerErrorMessage;

  AuthState({
    this.isPasswordVisible = false,
    this.isLoginLoading,
    this.isLoginSuccess,
    this.isLoginError,
    this.loginErrorMessage,
    this.isRegisterLoading,
    this.isRegisterSuccess,
    this.isRegisterError,
    this.registerErrorMessage,
  });

  // factory AuthState.initial() => AuthState(isPasswordVisible: false);

  AuthState copyWith({
    bool? isPasswordVisible,
    bool? isLoginLoading,
    bool? isLoginSuccess,
    bool? isLoginError,
    String? loginErrorMessage,
    bool? isRegisterLoading,
    bool? isRegisterSuccess,
    bool? isRegisterError,
    String? registerErrorMessage,
  }) {
    return AuthState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isLoginError: isLoginError ?? this.isLoginError,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
      isRegisterError: isRegisterError ?? this.isRegisterError,
      registerErrorMessage: registerErrorMessage ?? this.registerErrorMessage,
    );
  }
}
