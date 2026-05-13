import 'package:flutter/material.dart';
import '../const/app_const_dimensions.dart';
import '../const/styles.dart';

class CustomOutlineTextField extends StatefulWidget {
  final String? header;
  final String hintText;
  final String? prefixText; // ✅ new parameter
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
  final String? Function(String?)? validator;

  const CustomOutlineTextField({
    super.key,
    this.header,
    this.hintText = '',
    this.prefixText, // ✅ optional
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
    this.validator,
  });

  @override
  _CustomOutlineTextFieldState createState() => _CustomOutlineTextFieldState();
}

class _CustomOutlineTextFieldState extends State<CustomOutlineTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Section
        if (widget.header != null) ...[
          RichText(
            text: TextSpan(
              text: widget.header,
              style: bodyMedium(context)!.copyWith(
                color: widget.headerColor ?? const Color(0xFF1F2C52),
                fontWeight: FontWeight.bold,
                fontSize: Dimensions
                    .FONT_SIZE_DEFAULT,
              ),
              children: [
                if (widget.isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLines: widget.maxLines,
          style: bodyMedium(context)!.copyWith(
            color: widget.textColor ?? Colors.black87,
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
          ),
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: bodyMedium(context)!.copyWith(
              color: Colors.grey.withOpacity(0.6),
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            // ✅ Left-aligned currency symbol, always visible
            prefixIcon: widget.prefixText != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12, right: 6),
                    child: Text(
                      widget.prefixText!,
                      style: bodyMedium(context)!.copyWith(
                        color: Colors.black87,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  )
                : null,

            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),

            // Suffix Icon (Password toggle)
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF1F2C52),
                      size: 20,
                    ),
                  )
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor.withOpacity(0.7),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor.withOpacity(0.7),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: const BorderSide(
                color: Color(0xFF1F2C52),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            errorStyle: const TextStyle(fontSize: 12, height: 1.2),
          ),
        ),
      ],
    );
  }
}
