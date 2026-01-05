import 'package:flutter/material.dart';

import '../../config/app_theme.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGreen.withValues(alpha: 0.15)
              : Colors.white,
          border: Border.all(
            color: isActive ? AppTheme.primaryGreen : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primaryGreen : Colors.grey.shade700,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),

            const SizedBox(width: 4),

            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: isActive ? AppTheme.primaryGreen : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
