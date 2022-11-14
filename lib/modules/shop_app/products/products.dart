import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/shopApp/categories_model.dart';
import 'package:udemy_flutterr/models/shopApp/home_model.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state)
        {
          if(state is ShopSuccessChangeFavoritesDataState)
            {
               if(!state.model.status)
                 {
                   showToast(text: state.model.message, state: ToastStates.ERROR);
                 }
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).categoriesModel! , context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider( items: model.data.banners.map(
                  (e) => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                .toList(),
                options: CarouselOptions(
                  height: 150,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                  SizedBox(height: 20,),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                       physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
                        separatorBuilder: (context,index) => SizedBox(width: 10,),
                        itemCount: categoriesModel.data.data.length),
                  ),
                  SizedBox(height: 20,),
                  Text('Products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
            Container(
               color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                   mainAxisSpacing: 1,
                   crossAxisSpacing: 1,
                   childAspectRatio: 1 / 1.72,  // width / length
              children:
                List.generate(
                  model.data.products.length,
                        (index) => buildGridProduct(model.data.products[index] , context)),
              ),
            ),
          ],
        ),
  );

Widget buildCategoryItem(DataModel model) =>  Stack(
  alignment: Alignment.bottomCenter,
  children: [
    Image(
      image: NetworkImage(model.image,
      ),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black.withOpacity(0.7),
      height: 25,
      width: 100,
      alignment: Alignment.bottomCenter,
      child: Text(model.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,

        ),
      ),
    ),

  ],);


Widget buildGridProduct(ProductModel model, context) =>
      
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                          image: NetworkImage('${model.image}'),
                          width: double.infinity,
                          height:  200,
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
                  Padding(
                padding: const EdgeInsets.all(12.0),
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
                    Row(
                      children: [
                        Text('${model.price.round()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(width: 5,),
                        if(model.discount != 0)
                        Text('${model.oldPrice.round()}',
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
                            ShopCubit.get(context).changeFavorites(model.id);
                            print(model.id);
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
        );
      
}
