import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/utils/validators.dart';
import 'package:movies/features/ui/auth/register_screen/view/widget/avatar_carousel.dart';
import 'package:movies/widgets/change_language_item.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_size.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confPasswordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passIsObscure = ValueNotifier(true);

  final ValueNotifier<bool> confPassIsObscure = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    phoneController.dispose();
    passIsObscure.dispose();
    confPassIsObscure.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text('Register'.tr(), style: AppStyles.robotoRegular16Yellow),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              spacing: context.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * 0.02),
                  child: Column(
                    children: [
                      AvatarCarousel(),
                      Text(
                        'Avatar'.tr(),
                        style: AppStyles.robotoRegular16White,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: nameController,
                  validator: (value) => Validators.required(value),
                  prefixIcon: SvgPicture.asset(
                    AppAssets.nameIcon,
                    fit: BoxFit.none,
                  ),
                  hintText: "Name".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: emailController,
                  validator: (value) => Validators.email(value),
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/email-icon.svg",
                    fit: BoxFit.none,
                  ),
                  hintText: "Email".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                ValueListenableBuilder(
                  valueListenable: passIsObscure,
                  builder: (context, value, child) => CustomTextFormField(
                    keyboardType: TextInputType.text,
                    errorStyle: TextStyle(
                      color: AppColors.redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) => Validators.password(value),
                    controller: passwordController,
                    hintStyle: AppStyles.robotoRegular16White,
                    hintText: "Password".tr(),
                    prefixIcon: SvgPicture.asset(
                      AppAssets.passwordIcon,
                      fit: BoxFit.none,
                    ),
                    obscureText: value,
                    filled: true,
                    fillColor: AppColors.darkGrayColor,
                    suffixIcon: IconButton(
                      isSelected: !value,
                      selectedIcon: Icon(
                        Icons.visibility_rounded,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        passIsObscure.value = !passIsObscure.value;
                      },
                      icon: Icon(
                        Icons.visibility_off_rounded,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: confPassIsObscure,
                  builder: (context, value, child) => CustomTextFormField(
                    keyboardType: TextInputType.text,
                    errorStyle: TextStyle(
                      color: AppColors.redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) => Validators.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                    controller: confPasswordController,
                    hintText: "Confirm Password".tr(),
                    hintStyle: AppStyles.robotoRegular16White,
                    prefixIcon: SvgPicture.asset(
                      AppAssets.passwordIcon,
                      fit: BoxFit.none,
                    ),
                    obscureText: value,
                    filled: true,
                    fillColor: AppColors.darkGrayColor,
                    suffixIcon: IconButton(
                      isSelected: !value,
                      selectedIcon: Icon(
                        Icons.visibility_rounded,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        confPassIsObscure.value = !confPassIsObscure.value;
                      },
                      icon: Icon(
                        Icons.visibility_off_rounded,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: phoneController,
                  validator: (value) => Validators.phone(value),
                  prefixIcon: SvgPicture.asset(
                    AppAssets.phoneIcon,
                    fit: BoxFit.none,
                  ),
                  hintText: "Phone Number".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.02,
                  ),
                  child: Column(
                    spacing: context.height * 0.02,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          // todo: register with email and password
                        },
                        backgroundColor: AppColors.yellowColor,
                        child: Text(
                          'Create Account'.tr(),
                          style: AppStyles.robotoRegular20Black,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already_have_account".tr(),
                            style: AppStyles.robotoRegular14White,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.registerRouteName,
                              );
                            },
                            child: Text(
                              "login".tr(),
                              style: AppStyles.robotoRegular14Yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ChangeLanguageItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
