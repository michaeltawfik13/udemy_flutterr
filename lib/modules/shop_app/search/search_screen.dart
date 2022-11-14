import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/search/cubit/search_states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        SearchCubit.get(context).search(value);
                      },
                      validator: (value) {
                        return "Field must not be empty";
                      },
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!.data!.data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .model!.data!.data!.length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/* defaultFormField(
                       controller: searchController,
                       type: TextInputType.text,
                       validate: ()
                       {
                         if(formKey.currentState!.validate())
                           {
                             return "type a text to search for a product";
                           }
                         return null;
                       },
                       onSubmit: (String text)
                       {
                         SearchCubit.get(context).search(text);
                       },
                       labelText: 'Search',
                       prefix: Icons.search),
*/
