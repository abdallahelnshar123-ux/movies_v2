import 'package:movies/data/model/response/my_user_dto.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';

extension UserMapper on MyUserDto {
  MyUser toUser() {
    return MyUser(
      id: id,
      email: email,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
      provider: provider,
    );
  }
}
