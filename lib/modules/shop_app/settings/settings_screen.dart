import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/cubit.dart';
import 'package:udemy_flutterr/layout/Shop%20App/cubit/states.dart';
import 'package:udemy_flutterr/models/shopApp/login_model.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          var model = ShopCubit.get(context).userModel;

          nameController.text = model!.data!.name;
          emailController.text = model.data!.email;
          phoneController.text = model.data!.phone;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) =>Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateDataState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                            return "Name must not be empty ";
                        },
                        labelText: 'Name',
                        prefix: Icons.person),

                    SizedBox(height: 20,),

                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                            return "Email must not be empty ";
                        },
                        labelText: 'EmailAddress',
                        prefix: Icons.email),

                    SizedBox(height: 20,),

                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate:(String value)
                        {
                          if(value.isEmpty)
                            return "Phone must not be empty ";
                        },
                        labelText: 'Phone',
                        prefix: Icons.phone),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            color: defaultColor,
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }

                            },

                            child: Text('Update',style:
                            TextStyle(
                                color:Colors.white ,fontSize: 15),) ,),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            color: defaultColor,
                              onPressed: ()
                            {
                              signOut(context);
                            },
                            child: Text('Log Out',style:
                            TextStyle(
                                color:Colors.white ,fontSize: 15),) ,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),

          );
        },
    );



  }
}
