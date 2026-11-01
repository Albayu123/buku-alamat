import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/contact.dart';
import '../widgets/contact_avatar.dart';

class ContactFormPage extends StatefulWidget {
  final Contact? contact; // null = tambah, tidak null = edit

  const ContactFormPage({super.key, this.contact});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('contacts');

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  bool _isLoading = false;
  String _previewName = '';

  bool get _isEditMode => widget.contact != null;

  @override
  void initState() {
    super.initState();
    _previewName = widget.contact?.name ?? '';
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _addressController = TextEditingController(text: widget.contact?.address ?? '');

    _nameController.addListener(() {
      if (mounted) {
        setState(() {
          _previewName = _nameController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final contact = Contact(
      id: widget.contact?.id ?? '',
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
    );

    try {
      if (_isEditMode) {
        await _dbRef.child(widget.contact!.id).update(contact.toMap());
      } else {
        await _dbRef.push().set(contact.toMap());
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(child: Text('Gagal menyimpan kontak: $e')),
              ],
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit Kontak' : 'Tambah Kontak Baru',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // Avatar Preview Banner
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ContactAvatar(
                      name: _previewName.isEmpty ? 'Kontak' : _previewName,
                      size: 84,
                      fontSize: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _previewName.trim().isEmpty ? 'Nama Kontak' : _previewName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isEditMode ? 'Perbarui informasi kontak' : 'Isi formulir di bawah',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Form Section Container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INFORMASI KONTAK',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nama Field
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap *',
                        hintText: 'Contoh: Budi Santoso',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        suffixIcon: _nameController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _nameController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama lengkap wajib diisi';
                        }
                        if (value.trim().length < 2) {
                          return 'Nama minimal 2 karakter';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Telepon Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon *',
                        hintText: 'Contoh: 081234567890',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        suffixIcon: _phoneController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _phoneController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nomor telepon wajib diisi';
                        }
                        final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');
                        if (cleaned.length < 6) {
                          return 'Nomor telepon tidak valid';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Alamat Email',
                        hintText: 'Contoh: budi@gmail.com (opsional)',
                        prefixIcon: const Icon(Icons.email_outlined),
                        suffixIcon: _emailController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _emailController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          final emailRegExp = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegExp.hasMatch(value.trim())) {
                            return 'Format email tidak valid (contoh@domain.com)';
                          }
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Alamat Field
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Alamat Tinggal',
                        hintText: 'Contoh: Jl. Merdeka No. 45, Jakarta (opsional)',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        alignLabelWithHint: true,
                        suffixIcon: _addressController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _addressController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Action Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveContact,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isEditMode ? Icons.check_circle_outline_rounded : Icons.save_rounded,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isEditMode ? 'Simpan Perubahan' : 'Simpan Kontak',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
