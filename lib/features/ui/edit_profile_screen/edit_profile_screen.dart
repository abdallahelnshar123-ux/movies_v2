import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/validators.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/screen_size.dart';
import '../../../domain/entities/response/auth/auth_providers.dart';
import '../../../domain/entities/response/user/my_user.dart';
import '../auth/auth_state.dart';
import '../auth/cubit/auth_view_model.dart';
import 'Widget/avatars_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final MyUser currentUser = context.read<AuthCubit>().currentUser!;
  late final TextEditingController nameController = TextEditingController(
    text: currentUser.name,
  );
  late final TextEditingController phoneController = TextEditingController(
    text: currentUser.phone,
  );
  final _formKey = GlobalKey<FormState>();
  late final ValueNotifier<int> avatarIndex = ValueNotifier(
    currentUser.avatarIndex,
  );

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AccountDetailsUpdateSuccess ||
          current is AccountDetailsUpdateError ||
          current is AccountDetailsUpdateLoading ||
          current is AccountDeleteError ||
          current is AccountDeleteLoading ||
          current is AccountDeleteSuccess,
      listener: (context, state) {
        if (state is AccountDetailsUpdateSuccess) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'success',
            message: 'Profile updated successfully!',
            posActionText: 'Ok',
            posAction: () {
              Navigator.pop(context);
            },
          );
        }
        if (state is AccountDetailsUpdateError) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error!!!',
            message: state.message,
            posActionText: 'Ok',
          );
        }
        if (state is AccountDetailsUpdateLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is AccountDeleteSuccess) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'success',
            message: 'Account deleted successfully!',
            posActionText: 'Ok',
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.loginRouteName,
                (route) => false,
              );
            },
          );
        }
        if (state is AccountDeleteError) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error!!!',
            message: state.message,
            posActionText: 'Ok',
          );
        }
        if (state is AccountDeleteLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: AppStyles.robotoRegular16Yellow(context),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(context.width * 0.015),
          child: Column(
            spacing: 15,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                backgroundColor: AppColors.redColor,
                onPressed: () async {
                  if (currentUser.provider == AuthProviders.emailPassword) {
                    String? password = await DialogUtils.showPasswordDialog(
                      context: context,
                      message: 'Please Enter Password to delete account',
                      title: 'confirmation !',
                    );

                    if (password != null && password.isNotEmpty) {
                      if (!context.mounted) return;
                      context.read<AuthCubit>().deleteAccount(
                        context: context,
                        password: password,
                      );
                    }
                  } else {
                    DialogUtils.showMessage(
                      context: context,
                      message: 'Are you sure you want to delete the account ?',
                      title: 'confirmation !',
                      posAction: () {
                        context.read<AuthCubit>().deleteAccount(
                          context: context,
                          password: "",
                        );
                      },
                      posActionText: 'yes',
                      negActionText: 'no',
                    );
                  }
                },
                child: Text(
                  'delete_account'.tr(),
                  style: AppStyles.robotoRegular16White(context),
                ),
              ),
              CustomElevatedButton(
                backgroundColor: AppColors.yellowColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DialogUtils.showMessage(
                      context: context,
                      title: 'Update Data',
                      message: 'Are you sure you want to update data?',
                      posActionText: 'yes',
                      negActionText: 'Cancel',
                      posAction: () {
                        context.read<AuthCubit>().updateAccountDetails(
                          user: currentUser.copyWith(
                            avatarIndex: avatarIndex.value,
                            name: nameController.text,
                            phone: phoneController.text,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'update_account'.tr(),
                  style: AppStyles.robotoRegular16DarkGray(context),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.015),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
                  GestureDetector(
                    onTap: () {
                      showAvatarBottomSheet();
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: avatarIndex,
                      builder: (BuildContext context, value, Widget? child) {
                        return Container(
                          width: context.width * 0.3,
                          height: context.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                value == -1
                                    ? AppAssets.fallbackUserImage
                                    : AppConstants.avatarList[value],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.height * 0.01),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.person, color: AppColors.whiteColor),
                    controller: nameController,
                    hintText: "Enter Your Name",
                    hintStyle: AppStyles.robotoRegular16White(
                      context,
                    ).copyWith(fontSize: 16, fontWeight: FontWeight.w800),
                    validator: (value) => Validators.required(value),
                    fillColor: AppColors.darkGrayColor,
                    filled: true,
                    keyboardType: TextInputType.name,
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.phone, color: AppColors.whiteColor),
                    controller: phoneController,
                    hintText: "Enter Your Phone Number",
                    hintStyle: AppStyles.robotoRegular16White(
                      context,
                    ).copyWith(fontSize: 16, fontWeight: FontWeight.w800),
                    validator: (value) => Validators.phone(value),
                    fillColor: AppColors.darkGrayColor,
                    filled: true,
                    keyboardType: TextInputType.phone,
                  ),
                  Visibility(
                    visible:
                        currentUser.provider == AuthProviders.emailPassword,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.resetPasswordRouteName);
                          },
                          child: Text(
                            "Reset Password",
                            style: AppStyles.robotoRegular16White(context)
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.whiteColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      builder: (context) => SelectAvatarBottomSheet(
        newAvatarIndex: (index) {
          avatarIndex.value = index;
        },
        currentAvatarIndex: avatarIndex.value,
      ),
    );
  }
}
