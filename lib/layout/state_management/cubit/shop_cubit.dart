import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:souq/models/categories_model.dart';
import 'package:souq/models/change_favorites_model.dart';
import 'package:souq/models/favourites_model.dart';
import 'package:souq/models/home_model.dart';
import 'package:souq/models/login_model.dart';
import 'package:souq/modules/categories/categories_screen.dart';
import 'package:souq/modules/favourites/favourites.dart';
import 'package:souq/modules/products/products_screen.dart';
import 'package:souq/modules/settings/settings_screen.dart';
import 'package:souq/shared/constants/constants.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/local/cache_helper.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  // ////////////////////
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  //////////////////////////////////
  ///

  HomeModel? homeModel;
  //  FAVOURITES //
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(HomeModel.fromJson(value.data).data.products[0].name);
      // print(HomeModel.fromJson(value.data).status);
      //
      homeModel!.data.products.forEach((element) {
        favourites.addAll({element.id: element.in_favorites});
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }

  // /////////////////////////////////
  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    });
  }

  // /////////////////////////////////
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(dynamic productId) {
    favourites[productId] = !(favourites[productId] ?? false);
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAFOURITES,
      data: {
        'product_id': productId,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJason(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status) {
        favourites[productId] = !(favourites[productId] ?? false);
      } else {
        getFavourites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favourites[productId] = !(favourites[productId] ?? false);
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  // /////////////////////////////////
  FavouritesModel? favouritesModel;
  void getFavourites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAFOURITES, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error));
    });
  }

  // /////////////////////////////////
  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error));
    });
  }

  // /////////////////////////////////
  void updateUserData({
    required String name ,
    required String email ,
    required String phone ,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState(error));
    });
  }
  // /////////////////////////////////
}
