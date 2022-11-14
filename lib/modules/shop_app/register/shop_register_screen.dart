import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/shop_layout.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/products/products.dart';
import 'package:udemy_flutterr/modules/shop_app/register/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var  formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emialController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegitserCubit(),

      child: BlocConsumer<ShopRegitserCubit,ShoprRegisterStates>(
        listener: (context,state)
        {
          if(state is ShopRegisterSuccessState)
            {
                if(state.loginModel.status)
                {
                  print(state.loginModel.message);
                  print(state.loginModel.data?.token);
                  CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                      .then((value)
                  {
                    token = state.loginModel.data!.token;
                    navigateAndFinish(context, ShopLayout());
                  });
                  showToast(
                    text: state.loginModel.message,
                    state: ToastStates.SUCCESS,
                  );

                }else
                {
                  print(state.loginModel.message);
                  showToast(
                      text: state.loginModel.message,
                      state: ToastStates.ERROR);
                }

            }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Register',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text('Register now to browse our hot offers',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,  //copyWith بعدل بيها علي الاصل بتاعه
                              )
                          ),
                          SizedBox(
                            height: 30,),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "Name must not be empty";
                                }
                              },
                              labelText: 'UserName',
                              prefix: Icons.person),

                          SizedBox(
                            height: 30,),

                          defaultFormField(
                              controller: emialController,
                              type: TextInputType.emailAddress,
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "Email must not be Empty";
                                }
                              },
                              labelText: 'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 30,),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopRegitserCubit.get(context).suffix,
                              /*onSubmit: (value)
                                  {
                                    if(formkey.currentState!.validate())
                                    {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emialController.text,
                                          password: passwordController.text);
                                    }
                                  },*/
                              isPassword: ShopRegitserCubit.get(context).isPassword,
                              suffixPressed: ()
                              {
                                ShopRegitserCubit.get(context).changePasswordVisibility();
                              },
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "Password is too short";
                                }

                              },
                              labelText: 'Password',
                              prefix: Icons.lock_outline),
                          SizedBox(
                            height: 30,),

                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "Phone must not be Empty";
                                }
                              },
                              labelText: 'Phone Number',
                              prefix: Icons.phone),
                          SizedBox(
                            height: 15,),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => Container(
                              height: 50,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  if(formkey.currentState!.validate())
                                  {
                                    ShopRegitserCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emialController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,

                                    );
                                  }

                                },
                                child:Text('Register',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) ,

                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.0),
                                  color: Colors.blue),

                            ),

                            fallback: (context) => Center(child:CircularProgressIndicator(),),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
