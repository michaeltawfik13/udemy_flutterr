import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/News%20App/cubit/news_states.dart';

import '../../../layout/News App/cubit/news_cubit.dart';
import '../../../shared/components/components.dart';

class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>
      (
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).science;

        return articleBuilder(list,context);
      },
    );
  }
}