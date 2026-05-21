import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';
import 'package:movies/domain/failure/failure.dart';

import '../repository/user/user_repository.dart';

@injectable
class UpdateUserUseCase {
  final UserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> updateUser({required MyUser user}) async {
    return await _userRepository.updateUser(user: user);
  }
}
