import 'package:flutter/material.dart';
import 'package:units/AppColors.dart';


class TextPresets{
  static final headingStyle = new TextStyle(
      inherit: false,
      color: AppColors.accentLight,
      fontSize: 28.0,
      letterSpacing: 0.6,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300
  );
  static final h2Style = new TextStyle(
      inherit: false,
      color: AppColors.accentLight,
      fontSize: 24.0,
      letterSpacing: 0.6,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300
  );
  static final bodyStyle = new TextStyle(
      inherit: false,
      color: AppColors.accentLight,
      fontSize: 15.0,
      letterSpacing: 0.1,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400
  );

  static final scrollStyle = new TextStyle(
      color: AppColors.secondary,
      fontSize: 24.0,
      letterSpacing: 0.6,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300
  );
}
