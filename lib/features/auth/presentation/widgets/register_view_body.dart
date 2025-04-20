import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/show_snakbar.dart';

import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/core/utils/widgets/custom_text_feild.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';
import 'package:fruits_app/features/auth/presentation/widgets/login_methods_text.dart';
import 'package:fruits_app/features/auth/presentation/widgets/password_text_field.dart';
import 'package:fruits_app/features/auth/presentation/widgets/terms_checkbox.dart';
import 'package:fruits_app/generated/l10n.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late String email, password, name;
  bool isLoading = false;
  bool isTermsAccepted = false;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustemTextFormField(
                        hintText: S.of(context).fullName,
                        onChanged: (val) => name = val,
                      ),
                    ),
                    CustemTextFormField(
                      hintText: S.of(context).email,
                      onChanged: (val) => email = val,
                    ),

                    PasswordTextFormFiels(
                      hintText: S.of(context).password,
                      onChanged: (val) => password = val,
                    ),
                    TermsCheckbox(
                      onChanged: (value) => isTermsAccepted = value,
                    ),
                    CustomElevetedButton(
                      text: S.of(context).createAccount,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isTermsAccepted) {
                            formKey.currentState!.save();
                            BlocProvider.of<AuthCubit>(context).register(
                              email: email,
                              password: password,
                              name: name,
                            );
                          } else {
                            showCustomSnakBar(
                              context,
                              S.of(context).acceptTerms,
                            );
                          }
                        }
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: CustomText(
                        text1: S.of(context).haveAccount,
                        text2: S.of(context).login,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginView.id);
                        },
                      ),
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
