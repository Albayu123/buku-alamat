import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/contact.dart';
import '../theme/theme_controller.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_detail_sheet.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/empty_state.dart';
import 'contact_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('contacts');
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _deleteContact(String id, String name) async {
    final confirm = await DeleteContactDialog.show(context, contactName: name);

    if (confirm == true) {
      try {
        await _dbRef.child(id).remove();
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Kontak "$name" berhasil dihapus')),
                ],
              ),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus: $e')),
          );
        }
      }
    }
  }

  void _openForm({Contact? contact}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ContactFormPage(contact: contact),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF059669),
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  contact == null
                      ? 'Kontak baru berhasil ditambahkan'
                      : 'Kontak "${contact.name}" berhasil diperbarui',
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _openContactDetails(Contact contact) {
    ContactDetailSheet.show(
      context,
      contact: contact,
      onEdit: () => _openForm(contact: contact),
      onDelete: () => _deleteContact(contact.id, contact.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                elevation: innerBoxIsScrolled ? 2 : 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buku Alamat',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Kelola kontak & relasi Anda',
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    tooltip: isDark ? 'Mode Terang' : 'Mode Gelap',
                    onPressed: () {
                      ThemeController.instance.toggleTheme(context);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(68),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.openSans(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Cari nama, nomor, atau email...',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: theme.colorScheme.primary,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        setState(() => _searchQuery = value.toLowerCase().trim());
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: StreamBuilder<DatabaseEvent>(
            stream: _dbRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Memuat daftar kontak...',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 64,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Koneksi Gagal',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Terjadi kesalahan saat memuat data: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return EmptyStateWidget.noContacts(
                  onAddPressed: () => _openForm(),
                );
              }

              final rawValue = snapshot.data!.snapshot.value;
              if (rawValue is! Map) {
                return const Center(child: Text('Format data tidak valid.'));
              }

              final data = Map<dynamic, dynamic>.from(rawValue);
              final contacts = data.entries
                  .where((e) => e.value is Map)
                  .map(
                    (e) => Contact.fromMap(
                      e.key.toString(),
                      Map<dynamic, dynamic>.from(e.value as Map),
                    ),
                  )
                  .where((c) {
                    if (_searchQuery.isEmpty) return true;
                    return c.name.toLowerCase().contains(_searchQuery) ||
                        c.phone.toLowerCase().contains(_searchQuery) ||
                        c.email.toLowerCase().contains(_searchQuery) ||
                        c.address.toLowerCase().contains(_searchQuery);
                  })
                  .toList();

              // Urutkan berdasarkan nama (A-Z)
              contacts.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              );

              if (contacts.isEmpty) {
                if (_searchQuery.isNotEmpty) {
                  return EmptyStateWidget.searchNotFound(
                    query: _searchQuery,
                    onClearSearch: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  );
                }
                return EmptyStateWidget.noContacts(
                  onAddPressed: () => _openForm(),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 90),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ContactCard(
                    key: ValueKey(contact.id),
                    contact: contact,
                    onTap: () => _openContactDetails(contact),
                    onEdit: () => _openForm(contact: contact),
                    onDelete: () => _deleteContact(contact.id, contact.name),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.person_add_rounded, size: 20),
        label: Text(
          'Tambah Kontak',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
