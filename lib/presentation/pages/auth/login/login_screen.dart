import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/auth_controller.dart';
import '../../../const/app_const_theme.dart';
import '../../../routes/app_routes.dart';
import 'widgets/auth_footer.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_text_field.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
    final Size screenSize = MediaQuery.sizeOf(context);
    final double topSpacing = screenSize.height * 0.18;

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
                builder: (authController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: topSpacing),
                      Center(
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                            color: AppConstColor.textBlackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
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
                        onToggleVisibility: authController.togglePasswordVisibility,
                      ),
                      const SizedBox(height: 28),
                      authController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AuthPrimaryButton(
                        text: 'Login',
                        onPressed: () {
                          authController.loginUser();
                        },
                      ),
                      const SizedBox(height: 12),
                      AuthFooter(
                        text: "Don't have an account? ",
                        actionText: 'Register',
                        onTap: () => Get.offNamed(RouteName.REGISTER_SCREEN),
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