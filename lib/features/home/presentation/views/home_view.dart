import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:fruits_app/core/helper/service_locator.dart';
import 'package:fruits_app/core/repos/product_repo.dart';
import 'package:fruits_app/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ProductCubit(getIt.get<ProductRepo>()),
        child: const Scaffold(body: HomeViewBody()),
      ),
    );
  }
}
