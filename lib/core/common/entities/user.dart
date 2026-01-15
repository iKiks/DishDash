class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
  });
}
