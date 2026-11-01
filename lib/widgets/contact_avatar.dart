import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/contact_utils.dart';

class ContactAvatar extends StatelessWidget {
  final String name;
  final double size;
  final double? fontSize;
  final bool showShadow;

  const ContactAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.fontSize,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = ContactUtils.getAvatarGradient(name);
    final initials = ContactUtils.getInitials(name);
    final calculatedFontSize = fontSize ?? (size * 0.4);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: gradient[0].withValues(alpha: 0.35),
                  blurRadius: size * 0.2,
                  offset: Offset(0, size * 0.08),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: calculatedFontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
