import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/show_snakbar.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/core/utils/widgets/custom_text_feild.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:fruits_app/features/auth/presentation/views/register_view.dart';
import 'package:fruits_app/features/auth/presentation/widgets/login_methods_text.dart';
import 'package:fruits_app/features/auth/presentation/widgets/or_divider.dart';
import 'package:fruits_app/features/auth/presentation/widgets/password_text_field.dart';
import 'package:fruits_app/features/auth/presentation/widgets/social_login_button.dart';
import 'package:fruits_app/generated/l10n.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isLoading = false;
  String? email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          isLoading = false;
          showCustomSnakBar(context, state.errorMessage);
        } else if (state is AuthSuccess) {
          isLoading = false;
          showCustomSnakBar(context, state.userEntity.email);
        } else {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustemTextFormField(
                        hintText: S.of(context).email,
                        onChanged: (val) => email = val,
                      ),
                    ),
                    PasswordTextFormFiels(
                      hintText: S.of(context).password,
                      onChanged: (val) => password = val,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            S.of(context).forgotPassword,
                            style: AppTextStyles.semiBold13(
                              AppColors.lightPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomElevetedButton(
                      text: S.of(context).login,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          await blocProvider.login(
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text1: S.of(context).haveNoAccount,
                      text2: S.of(context).createAccount,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RegisterView.id,
                        );
                      },
                    ),
                    const OrDivider(),
                    SocialLoginButton(
                      title: S.of(context).googleLogin,
                      image: Assets.assetsImagesGoogleIcon,
                      onPressed: () async {
                        await blocProvider.loginWithGoogle();
                      },
                    ),
                    SocialLoginButton(
                      title: S.of(context).appleLogin,
                      image: Assets.assetsImagesApplIcon,
                      onPressed: () async {},
                    ),
                    SocialLoginButton(
                      title: S.of(context).facebookLogin,
                      image: Assets.assetsImagesFacebookIcon,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
