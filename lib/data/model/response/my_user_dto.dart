class MyUserDto {
  final String name;
  final String email;
  final String id;
  final String phone;
  final String provider;
  final int avatarIndex;

  const MyUserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarIndex,
    required this.provider,
  });

  MyUserDto.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id']?.toString() ?? '',
        name: data['name']?.toString() ?? '',
        email: data['email']?.toString() ?? '',
        phone: data['phone']?.toString() ?? '',
        avatarIndex: (data['avatarIndex'] as num?)?.toInt() ?? 0,
        provider: data['provider']?.toString() ?? '',
      );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarIndex': avatarIndex,
      'provider': provider,
    };
  }
}
