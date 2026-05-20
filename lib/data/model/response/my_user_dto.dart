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

// class AuthProviders {
//   static const google = 'google';
//   static const emailPassword = 'emailPassword';
//   static const phone = 'phone';
//   static const facebook = 'facebook';
//   static const playGames = 'playGames';
//   static const gameCenter = 'gameCenter';
//   static const apple = 'apple';
//   static const github = 'github';
//   static const microsoft = 'microsoft';
//   static const twitter = 'twitter';
//   static const yahoo = 'yahoo';
// }
