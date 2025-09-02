class AppValidators {
  static final RegExp _emailRegExp = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  static final RegExp _phoneRegExp = RegExp(r'^\+?[\d\s\-\(\)]+$');

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, include a letter and a number';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!_nameRegExp.hasMatch(value)) {
      return 'Enter a valid name (letters and spaces only)';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!_phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
