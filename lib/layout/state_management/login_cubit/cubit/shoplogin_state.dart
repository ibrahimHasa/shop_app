part of 'shoplogin_cubit.dart';

@immutable
abstract class ShoploginStates {}

class ShoploginInitialState extends ShoploginStates {}

// /////////////////////////////////////////
class ShoploginLoadingState extends ShoploginStates {}

class ShoploginSuccessState extends ShoploginStates {
  final ShopLoginModel loginModel;

  ShoploginSuccessState(this.loginModel);
}

class ShoploginErrorState extends ShoploginStates {
  final String error;

  ShoploginErrorState(this.error);
}

// ///////////////////////////////////
class ShopChangePasswordVisibiltyOfIconState extends ShoploginStates {}

// /////////////////////////////////
// /////////////////////////////////////
// ////////////////////////
