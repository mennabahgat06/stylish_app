/// Form validators used by login / register / checkout.
class Validators {
  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final isValid = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(value.trim());
    return isValid ? null : 'Enter a valid email';
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    return value.trim().length < 8 ? 'Enter a valid phone number' : null;
  }
}
