import 'package:flutter/cupertino.dart';

class Validator {
  /// Validates email
  /// Returns error message if invalid, null if valid
  String? validateEmail(String email) {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      return "Email cannot be empty.";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trimmedEmail)) {
      return "Please enter a valid email address.";
    }

    return null;
  }

  String? validateOtp(String otp) {
    final trimmedOtp = otp.trim();

    if (trimmedOtp.isEmpty) {
      return "OTP cannot be empty.";
    }

    // OTP must be 6 digits
    final otpRegex = RegExp(r'^\d{6}$');
    if (!otpRegex.hasMatch(trimmedOtp)) {
      return "OTP must be exactly 6 digits.";
    }

    return null;
  }

  /// Password rule flags
  bool isLengthValid = false; // At least 8 characters
  bool hasNumber = false; // At least 1 number
  bool hasLowercase = false; // At least 1 lowercase letter
  bool hasUppercase = false; // At least 1 uppercase letter
  bool isConfirmMatched = false; // Confirm password matches

  /// Validate main password rules
  /// Returns true if all password rules pass
  bool validatePassword(String password) {
    isLengthValid = password.length >= 8;
    hasNumber = RegExp(r'[0-9]').hasMatch(password);
    hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    hasUppercase = RegExp(r'[A-Z]').hasMatch(password);

    return isLengthValid && hasNumber && hasLowercase && hasUppercase;
  }

  /// Validate confirm password
  bool validateConfirmPassword(String password, String confirmPassword) {
    isConfirmMatched = password == confirmPassword;
    return isConfirmMatched;
  }

  /// Check if password and confirm password are valid
  bool isPasswordAndConfirmValid(String password, String confirmPassword) {
    final passwordValid = validatePassword(password);
    final confirmValid = validateConfirmPassword(password, confirmPassword);

    return passwordValid && confirmValid;
  }

  /// Sign in validation
  Map<String, String?> signInValidation({
    required TextEditingController signInEmailController,
    required TextEditingController signInPasswordController,
  }) {
    final email = signInEmailController.text.trim();
    final password = signInPasswordController.text.trim();

    String? emailError;
    String? passwordError;

    // ---------------- EMAIL VALIDATION ----------------
    if (email.isEmpty) {
      emailError = "Email cannot be empty.";
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emailError = "Please enter a valid email address.";
      }
    }

    // ---------------- PASSWORD VALIDATION ----------------
    if (password.isEmpty) {
      passwordError = "Password cannot be empty.";
    } else if (password.length < 8) {
      passwordError = "Password must be at least 8 characters long.";
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      passwordError = "Password must contain at least one lowercase letter.";
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      passwordError = "Password must contain at least one uppercase letter.";
    }

    return {
      "emailErrorMessage": emailError,
      "passwordErrorMessage": passwordError,
    };
  }
}
