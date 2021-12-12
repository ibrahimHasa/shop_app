import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:souq/models/login_model.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

part 'shopregister_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  // ////////////////////////////////////
  ShopLoginModel? RegisterModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      // print(value.data);
      RegisterModel = ShopLoginModel.fromJson(value.data);
      print(RegisterModel!.status);
      // print(RegisterModel!.message);
      print(RegisterModel!.data!.name);
      print(RegisterModel!.data!.token);
      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  // ///////////////////////////////////////
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void passwordVisibilityIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibiltyOfIconState());
  }
}
