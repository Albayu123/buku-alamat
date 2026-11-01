import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/contact.dart';
import '../utils/contact_utils.dart';
import 'contact_avatar.dart';

class ContactDetailSheet extends StatelessWidget {
  final Contact contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContactDetailSheet({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required Contact contact,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContactDetailSheet(
        contact: contact,
        onEdit: onEdit,
        onDelete: onDelete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Profile Header
            ContactAvatar(name: contact.name, size: 76, fontSize: 28),
            const SizedBox(height: 14),
            Text(
              contact.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (contact.phone.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                contact.phone,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Quick Actions Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.phone_rounded,
                  label: 'Telepon',
                  color: const Color(0xFF2563EB),
                  onTap: () => ContactUtils.callPhone(context, contact.phone),
                ),
                const SizedBox(width: 14),
                _buildActionButton(
                  context,
                  icon: Icons.chat_rounded,
                  label: 'WhatsApp',
                  color: const Color(0xFF10B981),
                  onTap: () => ContactUtils.sendWhatsApp(context, contact.phone),
                ),
                const SizedBox(width: 14),
                _buildActionButton(
                  context,
                  icon: Icons.message_rounded,
                  label: 'SMS',
                  color: const Color(0xFF8B5CF6),
                  onTap: () => ContactUtils.sendSms(context, contact.phone),
                ),
                if (contact.email.isNotEmpty) ...[
                  const SizedBox(width: 14),
                  _buildActionButton(
                    context,
                    icon: Icons.email_rounded,
                    label: 'Email',
                    color: const Color(0xFFF97316),
                    onTap: () => ContactUtils.sendEmail(context, contact.email),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Detail Cards
            _buildInfoTile(
              context,
              icon: Icons.phone_outlined,
              title: 'Nomor Telepon',
              value: contact.phone.isNotEmpty ? contact.phone : '-',
              trailingIcon: Icons.copy_rounded,
              onTapTrailing: contact.phone.isNotEmpty
                  ? () => ContactUtils.copyToClipboard(context, contact.phone, label: 'Nomor telepon')
                  : null,
            ),
            const SizedBox(height: 10),
            _buildInfoTile(
              context,
              icon: Icons.email_outlined,
              title: 'Alamat Email',
              value: contact.email.isNotEmpty ? contact.email : '-',
              trailingIcon: contact.email.isNotEmpty ? Icons.copy_rounded : null,
              onTapTrailing: contact.email.isNotEmpty
                  ? () => ContactUtils.copyToClipboard(context, contact.email, label: 'Email')
                  : null,
            ),
            const SizedBox(height: 10),
            _buildInfoTile(
              context,
              icon: Icons.home_outlined,
              title: 'Alamat Tinggal',
              value: contact.address.isNotEmpty ? contact.address : '-',
              trailingIcon: contact.address.isNotEmpty ? Icons.copy_rounded : null,
              onTapTrailing: contact.address.isNotEmpty
                  ? () => ContactUtils.copyToClipboard(context, contact.address, label: 'Alamat')
                  : null,
            ),

            const SizedBox(height: 24),

            // Bottom Edit & Delete CTA
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onEdit();
                    },
                    icon: Icon(Icons.edit_outlined, size: 18, color: theme.colorScheme.primary),
                    label: Text(
                      'Edit Kontak',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50.withValues(alpha: isDark ? 0.2 : 1.0),
                      foregroundColor: Colors.red.shade600,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: isDark ? Colors.red.shade300 : Colors.red.shade600,
                    ),
                    label: Text(
                      'Hapus',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.red.shade300 : Colors.red.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.2 : 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    IconData? trailingIcon,
    VoidCallback? onTapTrailing,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null && onTapTrailing != null)
            IconButton(
              icon: Icon(trailingIcon, size: 18),
              color: theme.colorScheme.primary,
              tooltip: 'Salin',
              onPressed: onTapTrailing,
            ),
        ],
      ),
    );
  }
}
