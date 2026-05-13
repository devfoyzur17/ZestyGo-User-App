import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final bool isWhite;
  final bool isSmall;
  const CustomLoader({super.key, this.isWhite = false, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: isSmall ? 30 : 40,
        height: isSmall ? 30 : 40,
        child: CircularProgressIndicator(
          strokeWidth: isSmall ? 3 : null,
          color: isWhite
              ? Theme.of(context).cardColor
              : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
