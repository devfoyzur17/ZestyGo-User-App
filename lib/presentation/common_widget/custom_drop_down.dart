import 'package:flutter/material.dart';
import '../const/app_const_dimensions.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? dwValue;
  final List<T> dwItems;
  final Function(T? value) onChange;
  final double? width;
  final String? hintText;
  final Color? textColor;
  final Color? borderColor;
  final Color? bgColor;
  final Color? itemColor;
  final TextStyle? titleTextStyle;
  final bool isFillColor;
  final bool isBorder;
  final String? title;
  final bool isRequired;

  // আইটেমটি স্ট্রিং হিসেবে দেখানোর জন্য ফাংশন
  final String Function(T) itemAsString;

  const CustomDropDown({
    super.key,
    required this.dwItems,
    required this.dwValue,
    required this.onChange,
    required this.itemAsString, // এটি এখন আবশ্যক
    this.width,
    this.bgColor,
    this.borderColor,
    this.hintText,
    this.textColor,
    this.itemColor,
    this.titleTextStyle,
    this.isFillColor = false,
    this.isBorder = true,
    this.isRequired = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // টাইটেল সেকশন (যদি থাকে)
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(
              children: [
                Text(
                  title!,
                  style: titleTextStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isRequired)
                  const Text(" *", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),

        SizedBox(
          width: width ?? double.infinity,
          height: 50,
          child: ButtonTheme(
            alignedDropdown: true,
            padding: EdgeInsets.zero,
            child: DropdownButtonFormField<T>(
              dropdownColor: bgColor ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT + 2),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL,
                ),
                filled: true,
                fillColor: bgColor ?? Theme.of(context).cardColor,

                // বর্ডার স্টাইল
                border: isBorder ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  borderSide: BorderSide(color: borderColor ?? Theme.of(context).primaryColor.withOpacity(0.2)),
                ) : InputBorder.none,

                enabledBorder: isBorder ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  borderSide: BorderSide(color: borderColor ?? Theme.of(context).disabledColor.withOpacity(0.2)),
                ) : InputBorder.none,

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),

              hint: Text(
                hintText ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  color: textColor ?? Theme.of(context).hintColor,
                ),
              ),

              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).disabledColor,
              ),

              isExpanded: true,
              value: dwValue,
              onChanged: onChange,

              // ডাইনামিক আইটেম লিস্ট
              items: dwItems.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemAsString(item), // এখানে ডাইনামিকভাবে ভ্যালু বসবে
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      color: itemColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}