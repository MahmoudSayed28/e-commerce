
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/service_locator.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/domain/repos/add_oreder_repo.dart';
import 'package:fruits_app/features/checkout/domain/repos/paymob_repo.dart';
import 'package:fruits_app/features/checkout/presentation/cubits/add_order/add_order_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/cubits/payment/payment_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_view_body.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.cartItems});
  static const String id = 'CheckoutView';
  final CartEntityList cartItems;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? userId;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AddOrderCubit(addOrderRepo: getIt.get<AddOrderRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).shipping,
            style: AppTextStyles.bold19(null),
          ),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create:
              (context) => OrderEntity(
                cartItemList: widget.cartItems,
                uId: userId ?? "",
              ),
          child: BlocProvider(
            create: (context) => PaymentCubit(
              getIt.get<PaymobRepo>(),
            ),
            child: const CheckoutViewBody(),
          ),
        ),
      ),
    );
  }
}
