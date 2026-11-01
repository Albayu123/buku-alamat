import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ContactUtils {
  /// Mendapatkan 1 atau 2 huruf inisial dari nama
  static String getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';

    final parts = trimmed.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  /// Menghasilkan pasangan gradient warna deterministik berdasarkan hash nama
  static List<Color> getAvatarGradient(String name) {
    if (name.isEmpty) return AppTheme.avatarGradients[0];
    final hash = name.codeUnits.fold(0, (prev, curr) => prev + curr);
    final index = hash % AppTheme.avatarGradients.length;
    return AppTheme.avatarGradients[index];
  }

  /// Membersihkan nomor telepon untuk integrasi WhatsApp/Dialer
  static String sanitizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
  }

  /// Membuka panggilan telepon
  static Future<void> callPhone(BuildContext context, String phone) async {
    final cleaned = sanitizePhone(phone);
    if (cleaned.isEmpty) return;

    final uri = Uri.parse('tel:$cleaned');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor telepon');
      }
    } catch (_) {
      if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor telepon');
      }
    }
  }

  /// Mengirim SMS
  static Future<void> sendSms(BuildContext context, String phone) async {
    final cleaned = sanitizePhone(phone);
    if (cleaned.isEmpty) return;

    final uri = Uri.parse('sms:$cleaned');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor telepon');
      }
    } catch (_) {
      if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor telepon');
      }
    }
  }

  /// Mengirim WhatsApp
  static Future<void> sendWhatsApp(BuildContext context, String phone) async {
    String cleaned = sanitizePhone(phone);
    if (cleaned.startsWith('0')) {
      cleaned = '62${cleaned.substring(1)}';
    } else if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
    }

    final uri = Uri.parse('https://wa.me/$cleaned');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor WhatsApp');
      }
    } catch (_) {
      if (context.mounted) {
        await copyToClipboard(context, phone, label: 'Nomor WhatsApp');
      }
    }
  }

  /// Mengirim Email
  static Future<void> sendEmail(BuildContext context, String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return;

    final uri = Uri.parse('mailto:$trimmed');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (context.mounted) {
        await copyToClipboard(context, trimmed, label: 'Alamat email');
      }
    } catch (_) {
      if (context.mounted) {
        await copyToClipboard(context, trimmed, label: 'Alamat email');
      }
    }
  }

  /// Menyalin teks ke clipboard dengan notifikasi toast
  static Future<void> copyToClipboard(
    BuildContext context,
    String text, {
    String label = 'Teks',
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text('$label berhasil disalin ke clipboard')),
            ],
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
