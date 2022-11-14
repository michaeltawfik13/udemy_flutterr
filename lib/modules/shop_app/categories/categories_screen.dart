import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/shopApp/categories_model.dart';
import 'package:udemy_flutterr/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,index) {},
      builder: (context,index)
      {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder:  (context,index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length
        );
      } ,
    );
  }

  Widget buildCatItem(DataModel model)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
  children: [
  Image(
  image: NetworkImage(model.image),
  width: 100,
  height: 100,
  fit: BoxFit.cover,
  ),
  SizedBox(width: 20,),
  Text(model.name,
  style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold
  ),),
  Spacer(),
  Icon(
  Icons.arrow_forward_ios,
  ),
  ],
  ),
  );
}