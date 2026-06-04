import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  // Last revised date tracker
  final String lastUpdatedDate = "June 05, 2026";

  // Structured Privacy Policy Document Sections
  final List<Map<String, String>> policySections = [
    {
      'title': '1. Information We Collect',
      'content': 'We collect information you provide directly to us when creating an account, placing a food order, or communicating with our help desk. This includes your profile name, email address, phone number, real-time GPS delivery coordinates, and transaction history records.'
    },
    {
      'title': '2. How We Use Your Data',
      'content': 'Your gathered processing metrics are strictly utilized to coordinate kitchen dispatch orders, manage secure payment gateways, estimate precise delivery times, handle customer tickets, and dispatch security/promotional alert parameters.'
    },
    {
      'title': '3. Data Security and Storage',
      'content': 'We enforce robust administrative encryption models, Google Cloud Firestore access authentications, and secure tokenized network wrappers to safeguard data structures against malicious interception or unauthorized operational tampering.'
    },
    {
      'title': '4. Third-Party Sharing',
      'content': 'We do not sell, trade, or leak your private identifiers to unknown third parties. Essential logistics data (Name, Contact, and Location Address) is strictly shared only with our registered delivery riders to successfully fulfill your order pipeline.'
    },
    {
      'title': '5. Your Privacy Rights',
      'content': 'You retain total sovereign authority to request permanent profile account deletions, correct dynamic contact data entries, or opt-out of promotional email/push-notification broadcasting schedules at your leisure.'
    },
  ];
}