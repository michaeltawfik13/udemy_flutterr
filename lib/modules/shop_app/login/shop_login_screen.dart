
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:udemy_flutterr/layout/Shop%20App/shop_layout.dart';
import 'package:udemy_flutterr/layout/Social%20App/social_layout.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

   var  formkey = GlobalKey<FormState>();
   var emialController = TextEditingController();
   var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, state)
        {
          if(state is ShopLoginSuccessState)
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
        builder: (context, state)
        {
          return Scaffold(


            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text('LOGIN now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,  //copyWith بعدل بيها علي الاصل بتاعه
                            )
                        ),
                        SizedBox(
                          height: 30,),
                        defaultFormField(
                            controller: emialController,
                            type: TextInputType.emailAddress,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return "Username must not be Empty";
                              }
                            },
                            labelText: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 30,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            /*onSubmit: (value)
                            {
                              if(formkey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emialController.text,
                                    password: passwordController.text);
                              }
                            },*/
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: ()
                            {
                              ShopLoginCubit.get(context).changePasswordVisibility();
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
                          height: 15,),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => Container(
                              height: 50,
                              width: double.infinity,
                              child: MaterialButton(
                                  onPressed: ()
                                  {
                                    if(formkey.currentState!.validate())
                                      {
                                        ShopLoginCubit.get(context).userLogin(
                                            email: emialController.text,
                                            password: passwordController.text);

                                      }

                                  },
                                child:Text('Login',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) ,

                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0.0),
                              color: Colors.blue),

                            ),

                        fallback: (context) =>
                          Center(child:CircularProgressIndicator(),),
                        ),
                        SizedBox(
                          height: 15,),
                        Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: ()
                            {
                              navigateAndFinish(context, ShopRegisterScreen());
                            },
                            child: Text('Register')),
                      ],
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
