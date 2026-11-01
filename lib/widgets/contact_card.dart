import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/contact.dart';
import '../utils/contact_utils.dart';
import 'contact_avatar.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Avatar
                ContactAvatar(name: contact.name, size: 50),
                const SizedBox(width: 14),

                // Name & Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              contact.phone.isNotEmpty ? contact.phone : 'Tanpa nomor',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (contact.email.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 14,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                contact.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Quick Call Button
                if (contact.phone.isNotEmpty)
                  IconButton(
                    onPressed: () => ContactUtils.callPhone(context, contact.phone),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.08),
                      foregroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.all(10),
                    ),
                    icon: const Icon(Icons.phone_rounded, size: 18),
                    tooltip: 'Hubungi',
                  ),

                // More Menu Button
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: theme.textTheme.bodyMedium?.color,
                    size: 20,
                  ),
                  tooltip: 'Menu lainnya',
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Edit',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Hapus',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
