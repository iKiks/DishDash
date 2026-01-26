import 'package:dishdash/core/common/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phoneNumber,
    super.dateOfBirth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawDob = json['dateOfBirth'] ?? json['date_of_birth'];
    final phone = (json['phoneNumber'] ?? json['phone_number'])?.toString();

    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: phone,
      dateOfBirth: _parseDateOfBirth(rawDob),
    );
  }

  Map<String, dynamic> toJson() {
    final phone = phoneNumber;
    final dob = dateOfBirth;

    return {
      'id': id,
      'name': name,
      'email': email,
      if (phone != null && phone.isNotEmpty) 'phoneNumber': phone,
      if (dob != null) 'dateOfBirth': dob.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      dateOfBirth: user.dateOfBirth,
    );
  }

  static DateTime? _parseDateOfBirth(dynamic value) {
    // Accept ISO strings, epoch milliseconds, or DateTime objects from APIs.
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }

    return null;
  }
}
