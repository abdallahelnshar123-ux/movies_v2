import 'package:injectable/injectable.dart';
import 'package:movies/core/cache/local_storage.dart';
import '../../../../model/response/my_user_dto.dart';
import '../user_local_data_source.dart';

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource{
  @override
  MyUserDto? getUser() {
    return LocalStorage.instance.getUser();
  }

  @override
  Future<void> saveUser({required MyUserDto user})async {
  await LocalStorage.instance.saveUser(user);
  }
}