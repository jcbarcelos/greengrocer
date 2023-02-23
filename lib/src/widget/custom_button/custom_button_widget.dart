import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final double borderRadiusCircular;
  final VoidCallback onPressed;
  final icon;
  final double? fontSize;
  final double? sizedBoxHeight;
  final bool? circularIndicator;
  const CustomButtonWidget({
    super.key,
    required this.title,
    this.borderRadiusCircular = 20.0,
    required this.onPressed,
    this.icon,
    this.fontSize,
    this.sizedBoxHeight,
    this.circularIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator circularProgressIndicator =
        CircularProgressIndicator(
      color: Colors.white,
    );
    return SizedBox(
      height: sizedBoxHeight ?? 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: CustomColors.customSwatchColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  !circularIndicator!
                      ? Container(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Icon(
                                icon,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: fontSize ?? 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : circularProgressIndicator,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
