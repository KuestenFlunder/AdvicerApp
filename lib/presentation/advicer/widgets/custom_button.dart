import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  const CustomButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkResponse(
      onTap: () => onPressed(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            //* secondaryContainer is accent Color
            color: themeData.colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Get Advice",
              style: themeData.textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}
