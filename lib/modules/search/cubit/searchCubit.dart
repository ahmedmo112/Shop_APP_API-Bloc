import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/searchStatus.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void serch(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      print(model.toString());
      emit(SearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SearchErrorState());
    });
  }
}
