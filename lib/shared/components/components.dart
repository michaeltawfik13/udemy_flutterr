
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/shared/cubit/cubit.dart';
import 'package:udemy_flutterr/shared/icon_broken.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

import '../../layout/News App/cubit/news_cubit.dart';
import '../../modules/web_view/web_view_screen.dart';


Widget defaultButton({
  //common use .... can change in the application
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      height: 40,
      width: width, // double.infinity
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );

Widget defaultTextButton({    // bye me

  bool isUpperCase = true,
  Color color = Colors.blue,
  double radius = 0.0,
  required Function function,
  required String text,
  required double fontSize,
}) =>
    Container(
      height: 40,
      child: TextButton(
          onPressed:function(), child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold,fontSize: fontSize),
      ),),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   Function(String)? onSubmit,
   Function(String)? onChange,
   Function(String)? onTap,
  required Function validate,
  required String labelText,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,

}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,

        obscureText: isPassword,
        onFieldSubmitted: (String value) {
          print(value);
        },
        onChanged: (String value) {
          print(value);
        },
        validator: (value) {
          return validate(value);
        },
        onTap: ()  {

        },
        decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: suffix != null
                ? IconButton(
                onPressed: (){suffixPressed!();},
                icon: Icon(suffix))
                : null,
            prefixIcon: Icon(prefix),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            )));

PreferredSizeWidget defaultAppBar({
   required BuildContext context,
   String? title,
   List<Widget>? actions,
}) =>  AppBar(
  leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(IconBroken.Arrow___Left_2
      ),
  ),
  title: Text(title!),
  titleSpacing: 5,
  actions: actions,
);

// Widget defaultTextButton({
//   required Function function,
//   required String text,
// }) =>
//     TextButton(
//       onPressed: function, child: Text(text),);

Widget searchField(searchController,context) => TextFormField(
  controller: searchController,
  keyboardType: TextInputType.text,
  onChanged: (String value) {
    NewsCubit.get(context).getSearch(value);
  },

  validator: (value) {
    return "Field must not be empty";
  },
  onTap: ()  {

  },
);

Widget buildTaskItem(Map model , context) =>  Dismissible(
  key:Key(model['id'].toString()),
  child:   Padding (
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 35,
  
          child: Text('${model['time']}'),
  
        ),
  
        SizedBox(width: 15,),
  
        Expanded(
  
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),

              Text('${model['date']}',style: TextStyle(fontSize: 15,color: Colors.grey)),
  
            ],
  
          ),
  
        ),
  
        SizedBox(width: 15,),
  
        IconButton(onPressed: ()
  
        {
  
          AppCubit.get(context).updateData(status: 'Done', id: model['id']);
  
        },
  
            icon: Icon(
  
              CupertinoIcons.checkmark_square,
  
            color: Colors.green,)),
  
        IconButton(onPressed: ()
        {
          AppCubit.get(context).updateData(
              status: 'Archived', id: model['id']);
  
        },
            icon: Icon(CupertinoIcons.archivebox,
            color: Colors.black38,)),
  
      ],
  
    ),
  
  ),
  onDismissed: (direction)
  {
     AppCubit.get(context).deleteData( id: model['id'],);
  },
);



Widget tasksBuilder ({
  required List<Map> tasks,
}) => ConditionalBuilder(
condition: tasks.length > 0,
builder: (context) =>  ListView.separated(
shrinkWrap: true,
itemBuilder: (context, index) =>  buildTaskItem(tasks[index],context),
separatorBuilder:((context, index) =>  myDivider()),
itemCount: tasks.length),
fallback: (context)=> Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.loop_sharp),
Text('No Tasks yet, Add Some Tasks,please'),
],
),
),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(

    height: 1,

    width: double.infinity,

    color: Colors.grey[300],

  ),
);

Widget buildArticleItem(article,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        Container(

          width: 120,

          height:120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),





          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.headline6,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',style: TextStyle(

                  fontSize: 15,

                  color: Colors.grey,

                ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder(list,context) =>  ConditionalBuilder(

    condition: list.length>0,
    builder: (context) => ListView.separated
      (
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index],context),
      separatorBuilder:(context, index) => myDivider(),
      itemCount:list.length,
    ),
    fallback: (context) => Center(child: CircularProgressIndicator()) );

void navigateTo(context,widget) =>  Navigator.push(context,
MaterialPageRoute(
builder: (context) => widget,
),
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil
  (context,
    MaterialPageRoute(
        builder: (context) => widget), (route) => false);

void showToast({
  required String text,
  required ToastStates state,
}) =>  Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color =  Colors.red;
      break;
    case ToastStates.WARNING:
      color =  Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct( model,context,{bool isOldPrice = true}) => Padding(

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
            if(model.discount != 0 && isOldPrice)
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
                  if(model.discount != 0 && isOldPrice)
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