import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

class ErrorView extends StatelessWidget {
  final Exception? error;
  const ErrorView({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red),
            SizedBox(height: 24),
            Text(
              "404 - Page not found",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              error?.toString() ?? "An unexpected error occurred",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go("/"),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  return AppColors.primaryColor;
                }),
              ),
              child: Text("Back to Homepage", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
