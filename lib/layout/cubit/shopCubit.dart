import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/ShopStates.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changes_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> fav = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel!.data!.banners[0].image);

      homeModel!.data!.products.forEach((element) {
        fav.addAll({element.id!: element.inFavorites!});
      });

      //print(fav.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productID) {
    fav[productID] = !fav[productID]!;
    emit(ShopChangeFavDataState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productID}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);

      if (!changeFavoritesModel!.status!) {
        fav[productID] = !fav[productID]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavDataState(changeFavoritesModel!));
    }).catchError((e) {
      fav[productID] = !fav[productID]!;

      emit(ShopErrorChangeFavDataState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavDataState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
     // print(value.data.toString());
      emit(ShopSuccessGetFavDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorGetFavDataState());
    });
  }


    ShopLoginModel? shopLoginModel;

  void getUserData() {
    emit(ShopLoadingProfileDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopLoginModel = ShopLoginModel.fromjson(value.data);
      print(shopLoginModel!.data!.name.toString());
      emit(ShopSuccessProfileDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorProfileDataState());
    });
  }

  void updateUserData(
  {
    required String name,
    required String email,
    required String phone,
  }
  ) {
    emit(ShopUpadteUserLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name' :name,
        'phone' :phone,
        'email' :email
      },
     token: token
     ).then((value) {
      shopLoginModel = ShopLoginModel.fromjson(value.data);
      print(shopLoginModel!.data!.name.toString());
      emit(ShopUpadteUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopUpadteUserErrorState());
    });
  }
}
