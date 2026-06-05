import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/privacy_policy_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(
      init: PrivacyPolicyController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Intro Badge Panel
                _buildHeaderIntroBlock(context, controller),
                const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                // Main Policy Text Clauses Stack Wrapper
                _buildPolicyClausesList(context, controller),
                const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                // Footer Legal Disclaimer Node
                _buildFooterDisclaimer(context),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Custom transparent AppBar mapping with standard back arrow redirection
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
        "Privacy Policy",
        style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// Informative banner highlighting policy versioning metrics
  Widget _buildHeaderIntroBlock(BuildContext context, PrivacyPolicyController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        border: Border.all(color: AppConstColor.primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_outlined, color: AppConstColor.primaryColor, size: 24),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(
                "We Care About Your Privacy",
                style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold, color: AppConstColor.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Please read our official privacy documentation guidelines to understand how your dynamic identity metrics are safely gathered, handled, and encrypted.",
            style: caption(context)?.copyWith(color: AppConstColor.textBlackColor.withOpacity(0.7)),
          ),
          const Divider(height: 20, color: AppConstColor.dividerColor),
          Text(
            "Last Updated: ${controller.lastUpdatedDate}",
            style: caption(context)?.copyWith(fontWeight: FontWeight.bold, color: AppConstColor.hintColor),
          ),
        ],
      ),
    );
  }

  /// Builds a card listing all individual legal sub-sections cleanly
  Widget _buildPolicyClausesList(BuildContext context, PrivacyPolicyController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.policySections.length,
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Divider(color: AppConstColor.backgroundGray, thickness: 1),
        ),
        itemBuilder: (context, index) {
          final section = controller.policySections[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section['title'] ?? '',
                style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold, color: AppConstColor.textBlackColor),
              ),
              const SizedBox(height: 6),
              Text(
                section['content'] ?? '',
                style: bodyMedium(context)?.copyWith(color: AppConstColor.hintColor, height: 1.4),
                textAlign: TextAlign.justify,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Bottom static copyright/disclaimer text line
  Widget _buildFooterDisclaimer(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          children: [
            Text(
              "If you have any questions or legal inquiries regarding our privacy terms, feel free to drop a ticket inside the Help & Support interface page.",
              style: caption(context)?.copyWith(color: AppConstColor.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "© 2026 ZestyGo. All Rights Reserved.",
              style: caption(context)?.copyWith(fontWeight: FontWeight.bold, color: AppConstColor.hintColor.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}