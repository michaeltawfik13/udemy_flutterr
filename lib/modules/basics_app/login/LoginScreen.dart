import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(

                      labelText: 'Email',
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      prefix: Icons.email,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Valid Email';
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    labelText: 'Password',
                    prefix: Icons.lock,
                    suffix: isPassword? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Valid Password';
                      }
                    },
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    //isPassword: isPassword,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Forget Password?'),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(' Progress Data')),
                          );
                        }
                      },
                      child: Text('Register')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
