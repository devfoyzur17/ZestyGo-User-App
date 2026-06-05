import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/support_controller.dart';
import '../../const/app_const_dimensions.dart';
import '../../const/app_const_theme.dart';
import '../../const/styles.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(
      init: SupportController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Quick Contact Channels (Call / Email)
                _buildQuickContactRow(context),
                const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                // Section 2: Frequently Asked Questions (FAQ)
                Text(
                  "Frequently Asked Questions",
                  style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimensions.FREE_SIZE_SMALL),
                _buildFaqList(controller),
                const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                // Section 3: Send us a Message Form
                Text(
                  "Still need help? Send a Message",
                  style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimensions.FREE_SIZE_SMALL),
                _buildContactForm(context, controller),
              ],
            ),
          ),
        );
      },
    );
  }

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
        "Help & Support",
        style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// Renders Quick Hotlines for Calling and Emailing support agents
  Widget _buildQuickContactRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSupportMethodCard(
            context,
            icon: Icons.phone_in_talk_rounded,
            title: "Call Hotline",
            subtitle: "+880 1700-000000",
            iconColor: Colors.blue,
            onTap: () {
             },
          ),
        ),
        const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
        Expanded(
          child: _buildSupportMethodCard(
            context,
            icon: Icons.mail_outline_rounded,
            title: "Email Us",
            subtitle: "support@zestygo.com",
            iconColor: Colors.deepOrange,
            onTap: () {

            },
          ),
        ),
      ],
    );
  }

  /// Blueprint grid card layout component for contact options
  Widget _buildSupportMethodCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color iconColor,
        required VoidCallback onTap,
      }) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Text(title, style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: caption(context)?.copyWith(color: AppConstColor.hintColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          InkWell(
            onTap: onTap,
            child: Text(
              "Connect",
              style: bodyMedium(context)?.copyWith(color: AppConstColor.primaryColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  /// Generates animated expansion tiles targeting customer FAQs
  Widget _buildFaqList(SupportController controller) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.faqs.length,
      separatorBuilder: (_, __) => const SizedBox(height: Dimensions.FREE_SIZE_SMALL),
      itemBuilder: (context, index) {
        final faq = controller.faqs[index];
        bool isExpanded = faq['isExpanded'] ?? false;

        return Container(
          decoration: BoxDecoration(
            color: AppConstColor.cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () => controller.toggleFaq(index),
                title: Text(
                  faq['question'],
                  style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: AppConstColor.hintColor,
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                    bottom: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      faq['answer'],
                      style: bodyMedium(context)?.copyWith(color: AppConstColor.hintColor),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Professional Custom Message Input Form fields block
  Widget _buildContactForm(BuildContext context, SupportController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Describe your issue or feedback precisely:",
            style: caption(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          TextField(
            controller: controller.messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Type your message here...",
              hintStyle: caption(context)?.copyWith(color: AppConstColor.hintColor),
              fillColor: AppConstColor.backgroundGray,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                borderSide: const BorderSide(color: AppConstColor.primaryColor, width: 1),
              ),
            ),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

          // Submit Action Ticket button wrapper triggering remote cloud integration pipelines
          SizedBox(
            width: double.infinity,
            height: Dimensions.BUTTON_DEFAULT_HIGHT,
            child: ElevatedButton(
              onPressed: controller.isSubmitting ? null : () => controller.submitTicket(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstColor.primaryColor,
                disabledBackgroundColor: AppConstColor.hintColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
                ),
                elevation: 0,
              ),
              child: controller.isSubmitting
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : Text(
                "Submit Message",
                style: bodyMedium(context)?.copyWith(
                  color: AppConstColor.textWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}