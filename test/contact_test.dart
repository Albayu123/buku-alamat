import 'package:flutter_test/flutter_test.dart';
import 'package:buku_alamat/models/contact.dart';
import 'package:buku_alamat/utils/contact_utils.dart';

void main() {
  group('Contact Model & Utils Tests', () {
    test('Contact serialization and deserialization', () {
      final map = {
        'name': 'John Doe',
        'phone': '08123456789',
        'email': 'john@example.com',
        'address': 'Jl. Sudirman 10',
      };

      final contact = Contact.fromMap('id123', map);
      expect(contact.id, 'id123');
      expect(contact.name, 'John Doe');
      expect(contact.phone, '08123456789');
      expect(contact.email, 'john@example.com');
      expect(contact.address, 'Jl. Sudirman 10');

      final serialized = contact.toMap();
      expect(serialized['name'], 'John Doe');
      expect(serialized['phone'], '08123456789');
    });

    test('Initials generation', () {
      expect(ContactUtils.getInitials(''), '?');
      expect(ContactUtils.getInitials('John'), 'JO');
      expect(ContactUtils.getInitials('John Doe'), 'JD');
      expect(ContactUtils.getInitials('Alief Syahrul Ramadan'), 'AS');
    });

    test('Phone sanitization', () {
      expect(ContactUtils.sanitizePhone('+62 812-3456-7890'), '+6281234567890');
      expect(ContactUtils.sanitizePhone('(021) 555-1234'), '0215551234');
    });

    test('Avatar gradient is deterministic and non-empty', () {
      final grad1 = ContactUtils.getAvatarGradient('Budi Santoso');
      final grad2 = ContactUtils.getAvatarGradient('Budi Santoso');
      expect(grad1, equals(grad2));
      expect(grad1.length, 2);
    });
  });
}
