import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/models/shopApp/search_model.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_states.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutterr/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: Search,
        token: token,
         data:
    {
      'text':text,
    }).then((value)
    {
      model = SearchModel.fromJson(value?.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {

      print(error.toString());
      emit(SearchErrorState());
    });
  }
}