class MyUser {
  final String name;
  final String email;
  final String id;
  final String phone;
  final String provider;
  final int avatarIndex;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarIndex,
    required this.provider,
  });

  MyUser copyWith({String? name, String? phone, int? avatarIndex}) {
    return MyUser(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      email: email,
      provider: provider,
    );
  }
}
