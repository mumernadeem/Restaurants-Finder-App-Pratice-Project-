import 'package:flutter/material.dart';

class AppUtils {
  extraLargeTitleHeadingStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 36,
    );
  }

  extraLargeBoldHeadingStyle({color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 36,
    );
  }

  mediumTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
    );
  }

  mediumBoldStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  largeBoldStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
  }

  largeTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 19,
      fontWeight: FontWeight.w400,
    );
  }

  xLargeTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );
  }

  xLargeBoldTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
  }

  smallTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 13,
    );
  }

  smallBoldStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );
  }

  extraSmallTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 11,
    );
  }

  extraSmallUnderlineTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 11,
      decoration: TextDecoration.underline,
    );
  }

  xHeadingStyle(color) {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: color,
        decoration: TextDecoration.none);
  }

  xHeadingStyleUnderline(color, decColor) {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: color,
        decoration: TextDecoration.underline,
        decorationColor: decColor);
  }

  headingStyle(color) {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: color,
        decoration: TextDecoration.none);
  }

  button({
    onTap,
    width,
    height,
    fontSize,
    text,
    border,
    textColor,
    buttonColor,
    borderRadius,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: buttonColor,
          border: border,
        ),
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(color: textColor, fontSize: fontSize ?? 18)),
          ],
        ),
      ),
    );
  }

  iconTextField({
    color,
    expands = false,
    autofocus = false,
    padding,
    maxLines,
    keyboardType,
    borderRadius,
    width,
    height,
    hintText,
    borderColor,
    textColor,
    controller,
    hintTextColor,
    check = false,
    borderWidth,
    textAlign,
    onChanged,
    contentPadding,
    suffixIcon,
    fontSize,
    obscuringCharacter,
    obscureText,
    prefixIcon,
    onTap,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: padding != null
          ? Padding(
              padding: padding,
              child: TextField(
                textAlign: textAlign ?? TextAlign.start,
                obscureText: obscureText,
                expands: expands,
                maxLines: maxLines,
                obscuringCharacter: obscuringCharacter,
                onChanged: onChanged,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
                keyboardType: keyboardType,
                onTap: onTap,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hintStyle: TextStyle(
                    color: hintTextColor ?? Colors.grey.withOpacity(0.5),
                    fontSize: fontSize,
                  ),
                  contentPadding: contentPadding,
                  hintText: hintText,
                ),
              ),
            )
          : TextField(
              textAlign: textAlign ?? TextAlign.start,
              obscureText: obscureText,
              autofocus: autofocus,
              obscuringCharacter: obscuringCharacter,
              onChanged: onChanged,
              expands: expands,
              maxLines: maxLines,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
              keyboardType: keyboardType,
              onTap: onTap,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintStyle: TextStyle(
                  color: hintTextColor ?? Colors.grey.withOpacity(0.5),
                  fontSize: fontSize,
                ),
                contentPadding: contentPadding,
                hintText: hintText,
              ),
            ),
    );
  }
}
