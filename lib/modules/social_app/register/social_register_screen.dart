import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutterr/layout/Shop%20App/shop_layout.dart';
import 'package:udemy_flutterr/layout/Social%20App/social_layout.dart';
import 'package:udemy_flutterr/modules/social_app/login/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/social_app/register/cubit/cubit.dart';
import 'package:udemy_flutterr/modules/social_app/register/cubit/states.dart';
import 'package:udemy_flutterr/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {

  var  formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegitserCubit(),
      child: BlocConsumer<SocialRegitserCubit,SocialRegisterStates>(
        listener: (context,state)
        {
          if(state is SocialCreateUserSuccessState)
            {
              navigateAndFinish(context, SocialLayout());
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
                          Text('Register now to Communicate with Friends',
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
                              controller: emailController,
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
                              suffix: SocialRegitserCubit.get(context).suffix,
                              /*onSubmit: (value)
                                  {
                                    if(formkey.currentState!.validate())
                                    {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emialController.text,
                                          password: passwordController.text);
                                    }
                                  },*/
                              isPassword: SocialRegitserCubit.get(context).isPassword,
                              suffixPressed: ()
                              {
                                SocialRegitserCubit.get(context).changePasswordVisibility();
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
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => Container(
                              height: 50,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  if(formkey.currentState!.validate())
                                {
                                  SocialRegitserCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      isEmailVerified: false);

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
