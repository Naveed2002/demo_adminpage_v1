import 'package:flutter/material.dart';

/// responsive

class Responsive {
  /// Maximum width for mobile screen
  static const double mobileMaxWidth = 600;

  /// Maximum width for tablet screen
  static const double tabletMaxWidth = 1200;

  /// Returns true if the screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }

  /// Returns true if the screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  /// Returns true if the screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMaxWidth;
  }

  /// cross axis count for GridView based on screen size
  static int getCrossAxisCount(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 4,
  }) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Returns the appropriate spacing based on screen size
  static double getSpacing(
    BuildContext context, {
    double mobile = 16.0,
    double tablet = 20.0,
  }) {
    return isTablet(context) ? tablet : mobile;
  }

  /// Returns the appropriate padding based on screen size
  static double getPadding(
    BuildContext context, {
    double mobile = 16.0,
    double tablet = 20.0,
    double desktop = 24.0,
  }) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Returns the appropriate child aspect ratio based on screen size
  static double getChildAspectRatio(
    BuildContext context, {
    double mobile = 4,
    double tablet = 2.5,
    double desktop = 3,
  }) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// gradient decoration based on the theme

  static BoxDecoration getGradientDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.grey[900]!, Colors.black],
      ),
    );
  }
}
