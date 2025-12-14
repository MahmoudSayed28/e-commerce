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

final class CartItemAdded extends CartState {
  final CartEntityList cart;

  const CartItemAdded(this.cart);

  @override
  List<Object?> get props => [cart];
}

final class CartItemRemoved extends CartState {
  final CartEntityList cart;

  const CartItemRemoved(this.cart);

  @override
  List<Object?> get props => [cart];
}
