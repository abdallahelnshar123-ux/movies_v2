import 'package:injectable/injectable.dart';
import 'package:movies/core/cache/local_storage.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';
import '../../../../model/response/my_user_dto.dart';
import '../user_local_data_source.dart';

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalStorage _localStorage;

  UserLocalDataSourceImpl(this._localStorage);

  @override
  MyUserDto? getUser() {
    try {
      return _localStorage.getUser();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> saveUser({required MyUserDto user}) async {
    try {
      await _localStorage.saveUser(user);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
