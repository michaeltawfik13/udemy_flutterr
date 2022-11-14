import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutterr/layout/Social%20App/social_layout.dart';
import 'package:udemy_flutterr/models/socialApp/social_model.dart';
import 'package:udemy_flutterr/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutterr/modules/social_app/login/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/social_app/login/cubit/states.dart';
import 'package:udemy_flutterr/modules/social_app/register/social_register_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {


  var formkey =GlobalKey<FormState>();
  var emialController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (BuildContext context, state)
        {
             if(state is SocialLoginErrorState)
              {
                showToast(text: state.error, state: ToastStates.ERROR);
              }
             if(state is SocialLoginSuccessState)
             {
               CacheHelper.saveData(
                   key: 'uId',
                   value: state.uId,
               ).then((value)
               {
                 navigateAndFinish(context, SocialLayout());
               });

             }

        },
        builder: (BuildContext context, Object? state) {
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
                      Text('LOGIN now to Communicate with Friends',
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
                          suffix: SocialLoginCubit.get(context).suffix,
                          /*onSubmit: (value)
                                {
                                  if(formkey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emialController.text,
                                        password: passwordController.text);
                                  }
                                },*/
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
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
                        condition: true,//state is! ShopLoginLoadingState,
                        builder: (context) => Container(
                          height: 50,
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: ()
                            {
                              if(formkey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
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
                            navigateAndFinish(context, SocialRegisterScreen());
                          },
                          child: Text('Register')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );},

      ),
    );
  }
}
