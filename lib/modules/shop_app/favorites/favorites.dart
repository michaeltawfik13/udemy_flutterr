import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/shopApp/favorites_model.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state)
        {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesDataState,
            builder:(context) =>ListView.separated
              (
                itemBuilder:(context,index) =>  buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
                separatorBuilder:(context,index) => myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        } );
  }

  Widget buildFavItem(Product model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                fit: BoxFit.cover,
                width: 120,
                height:  120,
                //fit: BoxFit.cover,
              ),
              if(model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      height: 1.2
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text('${model.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(model.discount != 0)
                      Text('${model.oldPrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration:TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id!);
                        // print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                        child: Icon(Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );

}


