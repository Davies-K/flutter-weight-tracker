part of values;

TextStyle textStyle = GoogleFonts.lato();

class AppTextStyles {
  static final titleStyle = textStyle.copyWith(
      fontSize: Sizes.TEXT_SIZE_16, color: AppColors.primaryColor);

  static final headerStyle = textStyle.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: Sizes.TEXT_SIZE_32,
      color: AppColors.black);

  static final paragraph = textStyle.copyWith(color: AppColors.black);
  static TextStyle fieldText() {
    return TextStyle(
      fontSize: Utils.screenWidth * 0.035,
      color: AppColors.black,
    );
  }
}
