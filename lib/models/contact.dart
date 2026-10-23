class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory Contact.fromMap(String id, Map<dynamic, dynamic> map) {
    return Contact(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}