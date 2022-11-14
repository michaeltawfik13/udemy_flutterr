import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/shared/cubit/cubit.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/states.dart';



class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context, state)  {},
      builder:  (context, state)  {

        var tasks = AppCubit.get(context).archivedtasks;

        return  tasksBuilder(tasks: tasks);
      },


    );
  }
}
