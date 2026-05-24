import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/validators.dart';
import 'package:movies/features/ui/auth/auth_state.dart';
import 'package:movies/features/ui/auth/cubit/auth_view_model.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/screen_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is ResetPasswordError ||
          current is ResetPasswordSuccess ||
          current is ResetPasswordLoading,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: state.message,
            title: "error",
            posActionText: 'ok',
          );
        }
        if (state is ResetPasswordSuccess) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message:
                "A password reset link has been sent to your email."
                "\n Please check your inbox or spam.",
            title: "Email Sent",
            posActionText: 'ok',
            posAction: () => Navigator.pop(context),
          );
        }
        if (state is ResetPasswordLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("reset_password".tr())),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: context.height * 0.04,
                children: [
                  Image.asset(AppAssets.forgetPasswordImage),
                  CustomTextFormField(
                    validator: (value) {
                      return Validators.email(value);
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "email".tr(),
                    hintStyle: AppStyles.robotoRegular16White(context),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: AppColors.whiteColor,
                    ),
                    filled: true,
                    fillColor: AppColors.darkGrayColor,
                  ),
                  CustomElevatedButton(
                    backgroundColor: AppColors.yellowColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context.read<AuthCubit>().resetPassword(
                          email: emailController.text.trim(),
                        );
                      }
                    },
                    child: Text(
                      'send_reset_password_link'.tr(),
                      style: AppStyles.robotoRegular16DarkGray(context),
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
}
