import 'package:flutter/material.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

  String _conversion(DateTime date, String? text, TextStyle? style) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${text ?? ''} ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

class DateConverter extends StatelessWidget {
  final DateTime date;
  final String? text;
  final TextStyle? style;

  const DateConverter({super.key, required this.date, this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
        _conversion(date, text, style),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: style ?? TextStyle(
          fontSize: 13,
          color: AppColors.textColor.withValues(alpha: 0.6),
        ),
      );
  }
}