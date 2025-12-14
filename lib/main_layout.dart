import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/home/presentation/views/cart_view.dart';
import 'package:fruits_app/features/home/presentation/views/home_view.dart';
import 'package:fruits_app/features/home/presentation/views/products_view.dart';
import 'package:fruits_app/features/home/presentation/views/profile_view.dart';
import 'package:fruits_app/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static const String id = 'MainLayout';

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> views = const [
    HomeView(),
    ProductsView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          //  onPageChanged: (index) => setState(() => _selectedIndex = index),
          children: views,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
