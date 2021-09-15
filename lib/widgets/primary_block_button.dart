import 'package:flutter/material.dart';
import 'package:plendify/values/values.dart';

class PrimaryBlockButton extends StatelessWidget {
  final double? width;
  final Color? color;
  final String title;
  final VoidCallback? onButtonTap;
  const PrimaryBlockButton(
      {Key? key, required this.title, this.onButtonTap, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonTap,
      child: Container(
          width: width ?? double.infinity,
          height: Utils.screenHeight * 0.060,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: color ?? AppColors.primaryColor),
          child: Center(
            child: Text(title,
                style: AppTextStyles.titleStyle.copyWith(color: Colors.white)),
          )),
    );
  }
}
