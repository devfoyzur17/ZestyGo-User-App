import 'package:flutter/material.dart';
import '../const/app_const_dimensions.dart';
import '../const/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? header;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isRequired;
  final Color? headerColor;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isEnabled;
  final int? maxLines;
  final Color? textColor;
  final bool isPassword;
  // Added validator property
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.header,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.isRequired = true,
    this.headerColor,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.textColor,
    this.isPassword = false,
    this.validator, // Initialize validator
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Section
        widget.header != null
            ? RichText(
                text: TextSpan(
                  text: widget.header,
                  style: bodyMedium(context)!.copyWith(
                    color: widget.headerColor ?? const Color(0xFF1F2C52),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                  children: [
                    if (widget.isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              )
            : const SizedBox(),

        const SizedBox(height: 8),

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator, // Link the validator here
          obscureText: widget.isPassword ? _obscureText : false,
          style: bodyMedium(
            context,
          )!.copyWith(color: widget.textColor ?? Colors.black87),
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: bodyMedium(context)!.copyWith(
              color: Colors.grey.withOpacity(0.7),
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
            filled: false,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),

            // Suffix Icon Configuration
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF1F2C52),
                      size: 20,
                    ),
                  )
                : null,

            // Error Styling
            errorStyle: const TextStyle(fontSize: 12, height: 1),

            // Underline styling
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1F2C52), width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1F2C52), width: 1.5),
            ),
            // The border that shows when there is a validation error
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1F2C52)),
            ),
          ),
        ),
      ],
    );
  }
}
