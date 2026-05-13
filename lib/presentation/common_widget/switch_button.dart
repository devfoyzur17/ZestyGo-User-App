import 'package:flutter/material.dart';

import '../const/app_const_dimensions.dart';

/// Custom Switch Button Widget
/// - Displays a title and a switch.
/// - Provides styling and theming customization.
class SwitchButton extends StatelessWidget {
  final String title; // Label text for the switch
  final bool value; // Switch state (ON/OFF)
  final Function(bool) onChanged; // Callback for switch state change

  const SwitchButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_EXTRA_SMALL + 2,
        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL + 2,

        left: Dimensions.PADDING_SIZE_DEFAULT - 1,
        right: Dimensions.PADDING_SIZE_DEFAULT + 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: -2,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Transform.scale(
            scale: 0.8,
            child: Transform.translate(
              offset: const Offset(12.0, 0.0),
              child: Theme(

                data: ThemeData(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                ),
                child: Switch(
                  trackOutlineColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ), // Track border color
                  activeColor: Colors.white, // Switch thumb color when ON
                  inactiveTrackColor: Theme.of(
                    context,
                  ).primaryColor.withOpacity(0.5), // Track color when OFF
                  activeTrackColor: Theme.of(
                    context,
                  ).primaryColor, // Track color when ON
                  inactiveThumbColor: Theme.of(
                    context,
                  ).disabledColor, // Thumb color when OFF
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
