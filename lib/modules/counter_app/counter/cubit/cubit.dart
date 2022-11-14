import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/modules/counter_app/counter/cubit/states.dart';





class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit(): super(CounterInitialState());

  // we use an object to be more easy to use it
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void Minus()
  {
    counter --;
    emit(CounterMinusState(counter)); // change the state
  }

  void Plus()
  {
    counter++;
    emit(CounterPlusState(counter)); // change state
  }

}