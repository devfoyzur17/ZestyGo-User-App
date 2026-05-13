import 'package:flutter/material.dart';

import '../const/app_const_dimensions.dart';

void showCenterSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          decoration: BoxDecoration(
            color: isError ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT + 2),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isError ? Colors.white : Colors.black,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  // show overlay
  overlay.insert(overlayEntry);

  // auto remove after 2 sec
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
