import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/auth_controller.dart';
import '../../../const/app_const_theme.dart';
import '../../../routes/app_routes.dart';
import '../login/widgets/auth_footer.dart';
import '../login/widgets/auth_primary_button.dart';
import '../login/widgets/auth_text_field.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
    final Size screenSize = MediaQuery.sizeOf(context);
    final double topSpacing =
        screenSize.height *
        0.16; // Restored the default spacing since dropdown is removed

    return Scaffold(
      backgroundColor: AppConstColor.backgroundWhite,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    screenSize.height - MediaQuery.paddingOf(context).vertical,
              ),
              child: GetBuilder<AuthController>(
                // Using GetBuilder instead of Obx to manage state efficiently
                builder: (authController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: topSpacing),
                      Center(
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                color: AppConstColor.textBlackColor,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AuthTextField(
                        label: 'Name',
                        hintText: 'Enter your name',
                        controller: authController.nameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        label: 'E-mail',
                        hintText: 'Enter your email',
                        controller: authController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: authController.passwordController,
                        textInputAction: TextInputAction.done,
                        obscureText: authController.isPasswordHidden,
                        onToggleVisibility:
                            authController.togglePasswordVisibility,
                      ),
                      const SizedBox(height: 28),

                      // --- Register Button State (With Loading Support) ---
                      authController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AuthPrimaryButton(
                              text: 'Register',
                              onPressed: () {
                                // Directly passing 'customer' as the default role for all users in this app
                                authController.signUpUser('customer');
                              },
                            ),
                      const SizedBox(height: 12),
                      AuthFooter(
                        text: 'Already have an account? ',
                        actionText: 'Login',
                        onTap: () => Get.offNamed(RouteName.LOGIN_SCREEN),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
