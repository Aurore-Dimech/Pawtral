import 'package:flutter/material.dart';

class InheritedDataProvider extends InheritedWidget {
  const InheritedDataProvider({required Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) {
    return false;
  }

  static InheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>()!;
}
