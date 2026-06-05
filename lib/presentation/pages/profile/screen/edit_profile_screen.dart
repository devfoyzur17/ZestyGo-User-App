import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/edit_profile_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),

                        // Dynamic Profile Image Container View with Overlay Edit Trigger Circle
                        _buildImagePickerAvatar(context, controller),
                        const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                        // Main Collective Inputs Data Card
                        _buildFormInputCard(context, controller),
                      ],
                    ),
                  ),
                ),

                // Bottom Save Action Multiplier Button Interface panel
                _buildSaveButtonFrame(context, controller),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Transparent customizable top navbar alignment
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: const BoxDecoration(
              color: AppConstColor.backgroundWhite,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: AppConstColor.textBlackColor),
          ),
        ),
      ),
      title: Text(
        "Personal Information",
        style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// Renders profile circle with matching pen illustration icon matching the reference schema
  Widget _buildImagePickerAvatar(BuildContext context, EditProfileController controller) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppConstColor.primaryColor, width: 2),
          ),
          child: CircleAvatar(
            radius: 65,
            backgroundColor: AppConstColor.backgroundWhite,
            backgroundImage: controller.profileImage.isNotEmpty
                ? NetworkImage(controller.profileImage)
                : const NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.snackbar("Image Picker", "Image upload feature can be added with image_picker package.");
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppConstColor.backgroundWhite,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: const Icon(Icons.edit_outlined, size: 18, color: AppConstColor.textBlackColor),
          ),
        )
      ],
    );
  }

  /// Master Input Form container wrapping independent operational field properties
  Widget _buildFormInputCard(BuildContext context, EditProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormInputField(context, title: "Name", hint: "Enter your name", textController: controller.nameController),
          const Divider(color: AppConstColor.dividerColor, height: 24),
          _buildFormInputField(context, title: "Phone", hint: "Enter your phone number", textController: controller.phoneController, keyboardType: TextInputType.phone),
          const Divider(color: AppConstColor.dividerColor, height: 24),
          _buildFormInputField(context, title: "Email", hint: "Enter your email address", textController: controller.emailController, readOnly: true, keyboardType: TextInputType.emailAddress),
          const Divider(color: AppConstColor.dividerColor, height: 24),
          _buildFormInputField(context, title: "Home", hint: "Enter your delivery details", textController: controller.homeController),
        ],
      ),
    );
  }

  /// Blueprint custom widget block separating individual TextField parameters
  Widget _buildFormInputField(
      BuildContext context, {
        required String title,
        required String hint,
        required TextEditingController textController,
        bool readOnly = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: textController,
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: bodyMedium(context)?.copyWith(color: readOnly ? AppConstColor.hintColor : AppConstColor.textBlackColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: caption(context)?.copyWith(color: AppConstColor.hintColor),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 6),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  /// Safe Area compliant baseline framework rendering the custom flat submit toggle button
  Widget _buildSaveButtonFrame(BuildContext context, EditProfileController controller) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: SizedBox(
        width: double.infinity,
        height: Dimensions.BUTTON_DEFAULT_HIGHT,
        child: ElevatedButton(
          onPressed: controller.isSaving ? null : () => controller.updateProfileData(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstColor.primaryColor,
            disabledBackgroundColor: AppConstColor.hintColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
            ),
            elevation: 0,
          ),
          child: controller.isSaving
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          )
              : Text(
            "Save",
            style: bodyMedium(context)?.copyWith(
              color: AppConstColor.textWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}