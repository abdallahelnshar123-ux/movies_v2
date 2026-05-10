import '../../../model/response/my_user_dto.dart';

abstract class UserLocalDataSource {
  MyUserDto? getUser();
  Future<void> saveUser({required MyUserDto user});


}