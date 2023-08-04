import 'package:flutter/material.dart';

class AppColor{

 // background and btn color
 static const WhiteColor = Color(0xffffffff);
 static const GreyColor = Color(0xbee8e8e8);
 static const OrangeColor = Color(0xffff660e);
 static const GreyDark = Color(0xff757575);
 static const GreyLight = Color(0xffb3b3b3);
 static const BlackColor = Color(0xe8000000);

}


TextStyle mTextStyle13({
 Color mColor = AppColor.GreyDark,
 FontWeight mFontWeight = FontWeight.normal
}) {
 return TextStyle(
  fontSize: 13,
  color: mColor,
  fontWeight: mFontWeight,
 );
}

TextStyle mTextStyle16({
 Color mColor = AppColor.GreyDark,
 FontWeight mFontWeight = FontWeight.normal
}) {
 return TextStyle(
  fontSize: 16,
  color: mColor,
  fontWeight: mFontWeight,
 );
}



// ------------------------------------ //
//   Spacer Widget Selection  //

Widget widthSpacer ({ double mWidth = 10.0})
{
 return SizedBox(
  width: mWidth,
 );
}

Widget heightSpacer ({ double mHeight = 10.0})
{
 return SizedBox(
  height: mHeight,
 );
}

// ------------------------------------ //
//   InputDecoration Selection  //

InputDecoration mInputDecoration({
 String? hint,
 String? mLabelText,
 double? mFontSize,
 Color? filledColor = AppColor.GreyColor,
 Color? preFixColor = AppColor.GreyDark,
 Color? suffixColor = AppColor.BlackColor,
 Color? hintColor = AppColor.GreyDark,
 Color? labelColor = AppColor.GreyDark,
 double radius = 15,
 Widget? prefixIcon,
 EdgeInsetsGeometry? padding,
 IconData? suffixIcon,
 String? mCounterText,
 double mIconSize = 20,
}) {
 return InputDecoration(
  filled: true,
  fillColor: filledColor,
  hintText: hint,
  hintStyle: TextStyle(color: hintColor),
  labelText: mLabelText,
  labelStyle: TextStyle(color: labelColor, fontSize: mFontSize),
  prefixIcon: prefixIcon != null ? prefixIcon : null,
  prefixIconColor: preFixColor,
  counterText: mCounterText,
  contentPadding: padding,
  suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: mIconSize) : null,
  suffixIconColor: suffixColor,
  enabledBorder: mGetBorder(radius: radius),
  focusedBorder: mGetBorder(radius: radius),
 );
}


// ------------------------------------ //
//   InputDecoration Selection  //
OutlineInputBorder mGetBorder({
 double radius = 15,
 Color borderColor = AppColor.WhiteColor,
 double borderWidth = 1
}){
 return OutlineInputBorder(
     borderRadius: BorderRadius.circular(radius),
     borderSide: BorderSide(
         color: borderColor,
         width: borderWidth
     )
 );
}