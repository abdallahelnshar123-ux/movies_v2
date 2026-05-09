import 'package:movies/data/model/response/my_user_dto.dart';

abstract class UserRemoteDataSource {
  Future<MyUserDto?> getUser(String uId);

  Future<void> createUser(MyUserDto user);
}
