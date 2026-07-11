import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool filled;
  final void Function()? onTap;

  const TopBarButton({super.key, 
    required this.icon,
    required this.label,
    required this.filled, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: filled
              ? const Color(0xFFE8572A)
              : Colors.black.withOpacity(0.45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
