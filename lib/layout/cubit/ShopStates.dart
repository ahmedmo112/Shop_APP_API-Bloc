import 'package:shop_app/models/changes_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavDataState extends ShopStates {}

class ShopSuccessChangeFavDataState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavDataState(this.model);
}

class ShopErrorChangeFavDataState extends ShopStates {}

class ShopLoadingGetFavDataState extends ShopStates {}

class ShopSuccessGetFavDataState extends ShopStates {}

class ShopErrorGetFavDataState extends ShopStates {}

class ShopLoadingProfileDataState extends ShopStates {}

class ShopSuccessProfileDataState extends ShopStates {
  
}

class ShopErrorProfileDataState extends ShopStates {}

class ShopUpadteUserLoadingState extends ShopStates {}

class ShopUpadteUserSuccessState extends ShopStates {
  
}

class ShopUpadteUserErrorState extends ShopStates {
  
}