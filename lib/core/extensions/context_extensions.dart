import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;


  double get lowValue => height * 0.03;
  double get mediumValue => height * 0.06;
  double get highValue => height * 0.09;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension ModalRouteExtension on BuildContext {
  ModalRoute get modalRoute => ModalRoute.of(this);

  RouteSettings get routeSettings => modalRoute.settings;
  Object get arguments => routeSettings.arguments;
}
