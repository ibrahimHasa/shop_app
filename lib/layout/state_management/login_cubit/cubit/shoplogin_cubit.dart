import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:souq/models/login_model.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

part 'shoplogin_state.dart';

class ShoploginCubit extends Cubit<ShoploginStates> {
  ShoploginCubit() : super(ShoploginInitialState());
  static ShoploginCubit get(context) => BlocProvider.of(context);
  // ////////////////////////////////////
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShoploginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      // print(loginModel!.message);
      print(loginModel!.data!.name);
      print(loginModel!.data!.token);
      emit(ShoploginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShoploginErrorState(error.toString()));
    });
  }

  // ///////////////////////////////////////
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void passwordVisibilityIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibiltyOfIconState());
  }
}
