import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/service_locator.dart';
import 'package:fruits_app/core/utils/widgets/custom_appbar.dart';
import 'package:fruits_app/features/auth/domain/useCases/auth_use_case.dart';
import 'package:fruits_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fruits_app/features/auth/presentation/widgets/register_view_body.dart';
import 'package:fruits_app/generated/l10n.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const id = 'RegisterView';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => AuthCubit(getIt.get<AuthUseCase>()),
        child: SafeArea(
          child: Scaffold(
            appBar: customAppBar(S.of(context).newAccount),
            body: const RegisterViewBody(),
          ),
        ),
      ),
    );
  }
}
