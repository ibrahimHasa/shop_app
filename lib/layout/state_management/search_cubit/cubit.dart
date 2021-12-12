// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:souq/layout/state_management/search_cubit/states.dart';
// import 'package:souq/models/search_model.dart';
// import 'package:souq/shared/network/remote/dio_helper.dart';

// class SearchCubit extends Cubit<SearchStates> {
//   SearchCubit() : super(SearchInitialState());

//    SearchCubit() get(context) => BlocProvider.of(context);
//   SearchModel? model;
//   void search(String text){
// DioHelper.putData(url: SEARCH, data: {
//   'text':text,
// });
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/state_management/search_cubit/states.dart';
import 'package:souq/models/login_model.dart';
import 'package:souq/models/search_model.dart';
import 'package:souq/shared/constants/constants.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  // ////////////////////////////////////
  SearchModel? model;
  void search(text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      token: token,
      url: SEARCH,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
