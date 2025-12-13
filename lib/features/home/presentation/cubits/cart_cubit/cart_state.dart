part of 'cart_cubit.dart';

@immutable
sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartUpdated extends CartState {
  final CartEntityList cart;

  const CartUpdated(this.cart);

  @override
  List<Object?> get props => [cart];
}
