import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';


import '../../../shared/cubit/cubit.dart';


class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state)  {},
      builder:  (context, state)  {

       var tasks = AppCubit.get(context).newtasks;

        return  tasksBuilder(tasks: tasks);

      },


    );
  }
}
