import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';


class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state)  {},
      builder:  (context, state)  {

        var tasks = AppCubit.get(context).donetasks;

        return  tasksBuilder(tasks: tasks);
      },


    );
  }
}
