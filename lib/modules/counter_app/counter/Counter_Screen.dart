import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {

  int counter =1;

  /*
  1- constructor
  2- initestate
  3- build
   */



  @override
  Widget build(BuildContext context) {

       // object from CounterCubit()
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(  // haysha4l bloc ya3ny haybtedy y listen 3aleh

        listener: (context, state) =>
        {
          if(state is CounterMinusState)
            print('Minus State ${state.counter}'),
          if(state is CounterPlusState)
            print('Plus State ${state.counter}'),


        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),

            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: ()
                    {
                      CounterCubit.get(context).Minus();

                    },
                    child: Text('Minus',
                      style: TextStyle(fontSize: 25) ,),),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15
                    ),
                    child: Text('${CounterCubit.get(context).counter}',
                      style:
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
                  ),
                  TextButton(
                    onPressed: ()
                    {
                      CounterCubit.get(context).Plus();

                    },
                    child: Text('PLus',style: TextStyle(fontSize: 25,),),),

                ],
              ),
            ),

          );
        },
      ),


      );

  }
  }