import 'package:movies/data/model/response/auth_user_dto.dart';
import 'package:movies/domain/entities/response/auth/auth_user.dart';

extension AuthUserMapper on AuthUserDto {
  AuthUser toAuthUser() {
    return AuthUser(id: id, email: email, name: name, phone: phone);
  }
}
