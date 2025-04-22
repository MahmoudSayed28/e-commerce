import 'package:flutter/widgets.dart';
import 'package:fruits_app/features/home/presentation/widgets/custom_home_appbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(slivers: [CustomHomeAppbar()]);
  }
}
