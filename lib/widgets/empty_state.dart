import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.buttonLabel,
    this.onButtonPressed,
  });

  factory EmptyStateWidget.noContacts({required VoidCallback onAddPressed}) {
    return EmptyStateWidget(
      icon: Icons.person_add_alt_1_rounded,
      title: 'Buku Alamat Kosong',
      description:
          'Mulai simpan daftar rekan, teman, dan keluarga Anda dengan mudah di satu tempat.',
      buttonLabel: 'Tambah Kontak Pertama',
      onButtonPressed: onAddPressed,
    );
  }

  factory EmptyStateWidget.searchNotFound({
    required String query,
    required VoidCallback onClearSearch,
  }) {
    return EmptyStateWidget(
      icon: Icons.search_off_rounded,
      title: 'Tidak Ada Hasil',
      description:
          'Tidak ditemukan kontak yang cocok dengan "$query". Coba periksa ejaan atau bersihkan filter pencarian.',
      buttonLabel: 'Reset Pencarian',
      onButtonPressed: onClearSearch,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(
                  alpha: isDark ? 0.15 : 0.08,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 44,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 14,
                height: 1.5,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            if (buttonLabel != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onButtonPressed,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(buttonLabel!),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
