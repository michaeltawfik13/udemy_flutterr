import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/News%20App/cubit/news_cubit.dart';
import 'package:udemy_flutterr/layout/News%20App/cubit/news_states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  /* ConditionalBuilder(
          condition: ,
          builder: builder,
          fallback: (context) => Center(child: CircularProgressIndicator()) ),*/
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,states) {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list,context);
       }  ,
    );
  }
}
