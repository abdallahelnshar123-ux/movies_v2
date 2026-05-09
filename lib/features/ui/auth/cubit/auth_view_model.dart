import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/register_with_email_and_password_use_case.dart';
import 'package:movies/domain/use_cases/signin_with_gogole_use_cases.dart';

import '../../../../domain/entities/response/user/my_user.dart';
import '../auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCases _signInWithGoogleUseCases;
  final RegisterWithEmailAndPasswordUseCase
  _registerWithEmailAndPasswordUseCases;

  AuthCubit(
    this._signInWithGoogleUseCases,
    this._registerWithEmailAndPasswordUseCases,
  ) : super(AuthInitial());

  MyUser? currentUser;
  int _selectedAvatarIndex = 0;

  set changeSelectedIndex(int newIndex) {
    _selectedAvatarIndex = newIndex;
  }

  int get selectedAvatarIndex {
    return _selectedAvatarIndex;
  }

  // Future<void> loginWithEmailAndPassword(String email, String password) async {
  //   try {
  //     emit(AuthLoginLoading());
  //
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     debugPrint(credential.user?.uid ?? 'no user');
  //
  //     final userData = await FirebaseUtils.readUserFromFireStore(
  //       credential.user?.uid ?? '',
  //     );
  //
  //     if (userData == null) {
  //       emit(AuthLoginError('Email not found'));
  //       return;
  //     }
  //
  //     debugPrint(userData.toString());
  //
  //     final user = MyUser(
  //       id: userData.id,
  //       name: userData.name,
  //       email: userData.email,
  //       avatarIndex: userData.avatarIndex,
  //       phone: userData.phone,
  //       provider: userData.provider,
  //     );
  //
  //     currentUser = user;
  //
  //     emit(AuthAuthenticated());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //
  //     if (e is FirebaseAuthException) {
  //       if (e.message ==
  //           'The supplied auth credential is incorrect, malformed or has expired.') {
  //         emit(AuthLoginError('Email or password is incorrect ! '));
  //       }
  //     } else {
  //       emit(AuthLoginError('Something went wrong'));
  //     }
  //   }
  // }
  //
  // void logout() {
  //   currentUser = null;
  //   emit(AuthUnauthenticated());
  // }
  //
  // Future<void> deleteUserAccountWithEmailPassword(String password) async {
  //   try {
  //     emit(AuthDeleteLoading());
  //
  //     final user = FirebaseAuth.instance.currentUser;
  //
  //     final credential = EmailAuthProvider.credential(
  //       email: user!.email!,
  //       password: password,
  //     );
  //
  //     await user.reauthenticateWithCredential(credential);
  //     await FirebaseUtils.deleteUserFromFirestore(user.uid);
  //     await user.delete();
  //     currentUser = null;
  //
  //     emit(AuthDeleteSuccess());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'wrong-password') {
  //       emit(AuthDeleteError("Wrong password"));
  //     } else if (e.code == 'requires-recent-login') {
  //       emit(AuthDeleteError("Please login again"));
  //     } else {
  //       emit(AuthDeleteError(e.message ?? "Delete failed"));
  //     }
  //   } catch (e) {
  //     emit(AuthDeleteError("Something went wrong"));
  //   }
  // }
  //
  // Future<void> updateUserData({
  //   required String name,
  //   required String phone,
  //   required int avatarIndex,
  // }) async {
  //   try {
  //     emit(AuthUpdateLoading());
  //     if (currentUser == null) {
  //       emit(AuthUpdateError("User not logged in"));
  //       return;
  //     }
  //
  //     final updatedUser = MyUser(
  //       id: currentUser!.id,
  //       email: currentUser!.email,
  //       name: name,
  //       phone: phone,
  //       avatarIndex: avatarIndex,
  //       provider: currentUser!.provider,
  //     );
  //
  //     await FirebaseUtils.updateUserDataToFirestore(updatedUser);
  //
  //     currentUser = updatedUser;
  //
  //     emit(AuthUpdateSuccess());
  //   } catch (e) {
  //     emit(AuthUpdateError(e.toString()));
  //   }
  // }
  //
  // ///   auth with google
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoginLoading());
      final result = await _signInWithGoogleUseCases.invoke();

      result.fold((failure) => emit(AuthLoginError(failure.message)), (user) {
        currentUser = user;
        emit(AuthAuthenticated());
      });
    } catch (e) {
      emit(AuthLoginError('Unexpected Error'));
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    try {
      emit(AuthRegisterLoading());
      final result = await _registerWithEmailAndPasswordUseCases.invoke(
        name: name,
        phone: phone,
        avatarIndex: avatarIndex,
        password: password,
        email: email,
      );

      result.fold((failure) => emit(AuthRegisterError(failure.message)), (
        user,
      ) {
        currentUser = user;
        emit(AuthAuthenticated());
      });
    } catch (e) {
      emit(AuthRegisterError('Unexpected Error'));
    }
  }
}
