part of 'shopregister_cubit.dart';

@immutable
abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

// /////////////////////////////////////////
class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

// ///////////////////////////////////
class ShopRegisterChangePasswordVisibiltyOfIconState extends ShopRegisterStates {}

// /////////////////////////////////
// /////////////////////////////////////
// ////////////////////////
