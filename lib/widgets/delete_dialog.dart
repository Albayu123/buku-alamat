import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteContactDialog extends StatelessWidget {
  final String contactName;

  const DeleteContactDialog({super.key, required this.contactName});

  static Future<bool?> show(BuildContext context, {required String contactName}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteContactDialog(contactName: contactName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.red.shade50.withValues(alpha: isDark ? 0.15 : 1.0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: isDark ? Colors.red.shade300 : Colors.red.shade600,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Hapus Kontak?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kontak "$contactName" akan dihapus secara permanen dari buku alamat Anda.',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: theme.textTheme.bodyMedium?.color,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Batal',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Hapus',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
