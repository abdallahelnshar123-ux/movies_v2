import 'package:injectable/injectable.dart';

import '../../../../model/response/my_user_dto.dart';
import '../../../../services/firestore_service.dart';
import '../user_remote_data_source.dart';


@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirestoreService _firestoreService;

  UserRemoteDataSourceImpl(this._firestoreService);

  @override
  Future<MyUserDto?> getUser(String uId) {
    return _firestoreService.getUserFromFireStore(uId);
  }

  @override
  Future<void> createUser(MyUserDto user) {
    return _firestoreService.addUserToFireStore(user);
  }
}