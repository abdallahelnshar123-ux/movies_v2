import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/delete_account_use_case.dart';
import 'package:movies/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:movies/domain/use_cases/register_with_email_and_password_use_case.dart';
import 'package:movies/domain/use_cases/signin_with_gogole_use_cases.dart';
import 'package:movies/domain/use_cases/update_account_details_use_case.dart';

import '../../../../domain/entities/response/user/my_user.dart';
import '../../../../domain/use_cases/logout_use_case.dart';
import '../../home_screen/tabs/profile_tab/cubit/history_view_model.dart';
import '../../home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart';
import '../auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCases _signInWithGoogleUseCases;
  final RegisterWithEmailAndPasswordUseCase
  _registerWithEmailAndPasswordUseCases;
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final UpdateAccountDetailsUseCase _updateAccountDetailsUseCase;

  AuthCubit(
    this._signInWithGoogleUseCases,
    this._registerWithEmailAndPasswordUseCases,
    this._loginWithEmailAndPasswordUseCase,
    this._logoutUseCase,
    this._deleteAccountUseCase,
    this._updateAccountDetailsUseCase,
  ) : super(AuthInitial());

  MyUser? currentUser;
  int _selectedAvatarIndex = 0;

  set changeSelectedIndex(int newIndex) {
    _selectedAvatarIndex = newIndex;
  }

  int get selectedAvatarIndex {
    return _selectedAvatarIndex;
  }

  void logout(BuildContext context) async {
    emit(AuthLogoutLoading());
    await context.read<WatchListCubit>().clearWatchList();
    if (!context.mounted) return;
    await context.read<HistoryCubit>().clearHistory();
    var result = await _logoutUseCase.invoke();
    result.fold((failure) => emit(AuthLogoutError(failure.message.tr())), (_) {
      emit(AuthUnauthenticated());
    });
  }

  Future<void> deleteUserAccount({
    required BuildContext context,
    required String password,
  }) async {
    emit(AccountDeleteLoading());

    var result = await _deleteAccountUseCase.deleteAccount(
      password: password,
      provider: currentUser?.provider ?? '',
    );
    result.fold((failure) => emit(AccountDeleteError(failure.message.tr())), (
      unit,
    ) {
      emit(AccountDeleteSuccess());
      logout(context);
    });
  }

  Future<void> updateAccountDetails({required MyUser user}) async {
    emit(AccountDetailsUpdateLoading());
    var result = await _updateAccountDetailsUseCase.updateAccountDetails(
      user: user,
    );
    result.fold((failure) => emit(AccountDetailsUpdateError(failure.message)), (
      unit,
    ) {
      currentUser = user;
      emit(AccountDetailsUpdateSuccess());
    });
  }

  ///   auth with google
  Future<void> continueWithGoogle() async {
    try {
      emit(AuthContinueWithGoogleLoading());
      final result = await _signInWithGoogleUseCases.invoke();

      result.fold((failure) => emit(AuthLoginError(failure.message.tr())), (
        user,
      ) {
        currentUser = user;
        emit(AuthAuthenticated(user));
      });
    } catch (e) {
      emit(AuthContinueWithGoogleError('Unexpected Error'));
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthLoginLoading());
      final result = await _loginWithEmailAndPasswordUseCase.invoke(
        email: email,
        password: password,
      );
      result.fold((failure) => emit(AuthLoginError(failure.message.tr())), (
        user,
      ) {
        currentUser = user;
        emit(AuthAuthenticated(user));
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

      result.fold((failure) => emit(AuthRegisterError(failure.message.tr())), (
        user,
      ) {
        currentUser = user;
        emit(AuthAuthenticated(user));
      });
    } catch (e) {
      emit(AuthRegisterError('Unexpected Error'));
    }
  }
}
