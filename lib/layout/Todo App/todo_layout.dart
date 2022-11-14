import 'dart:developer';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/src/material/time.dart';
import 'package:udemy_flutterr/shared/components/constants.dart';
import 'package:udemy_flutterr/shared/cubit/cubit.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/components.dart';

// 1- Create Database
// 2- create tables
// 3- open database
// 4- insert to Database
// 5- get from Database
// 6- update database
// 7- delete database


class HomeLayout extends StatelessWidget {



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // we put this command on shared=>constants
  // List<Map> tasks = [];


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      lazy: false,

      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state)
        {
          if(state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context, Object? state)
        {
         AppCubit cubit = AppCubit.get(context);

          return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentindex],
              ),
            ),
            body: ConditionalBuilder(
              condition:   state is! AppGetDatabaseLoadingState, //  true,   //tasks.length > 0,
              builder: (context) => cubit.screens[cubit.currentindex] ,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),

            //tasks.length == 0 ? Center(child: CircularProgressIndicator()) : screens[currentindex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.BottomSheetShown)
                {
                  if(formKey.currentState!.validate())
                  {

                    cubit.insertToDatabase(title: titlecontroller.text, time: timecontroller.text, date: datecontroller.text);
                    // insertToDatabase(
                    //     time: '$timecontroller',
                    //     title: '$titlecontroller',
                    //     date: '$datecontroller').then((value)
                    // {
                    //   getDataFromDatabase(database).then((value)
                    //   {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   BottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks = value;
                    //     //   print(tasks);
                    //     // });
                    //   });
                    //
                    // });

                  }

                }else
                {
                  // setState(() {
                  //   fabIcon = Icons.add;
                  //
                  // });

                  scaffoldKey.currentState!.showBottomSheet((context) =>
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              //Task Field
                              defaultFormField(
                                  controller: titlecontroller,
                                  type: TextInputType.text,
                                  validate: (String value){
                                    if(value.isEmpty)
                                    {
                                      return 'You Should Enter a Text';
                                    }
                                  },
                                  labelText: 'Task Title',
                                  prefix: Icons.title),

                              Container(

                                //Time Field
                                child: TextFormField(

                                  controller: timecontroller,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {

                                    showTimePicker(
                                        context: context, initialTime: TimeOfDay
                                        .now()).then((value)
                                    {
                                      timecontroller.text = value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  validator: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'Must not be Empty';
                                    }
                                  },

                                ),
                              ),


                              SizedBox(height: 15,),

                              Container(

                                //Date Field
                                child: TextFormField(

                                  controller: datecontroller,
                                  keyboardType: TextInputType.datetime,
                                  onTap: ()
                                  {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-06-03'),).then((value)
                                    {
                                      print(DateFormat.yMMMd().format(value!));
                                    });
                                  },
                                  validator: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'Date Must not be Empty';
                                    }
                                  },

                                ),
                              ),

                              //Task Field



                              /*   defaultFormField(
                                    controller: datecontroller,
                                    type: TextInputType.datetime,
                                    onTap: ()
                                    {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2022-5-3')).then((value)
                                      {

                                      });
                                    },
                                    validate: (String value){
                                      if(value.isEmpty)
                                      {
                                        return 'You Should Enter a Date';
                                      }
                                    },
                                    labelText: 'Date ',
                                    prefix: Icons.date_range),*/
                              //-----------------------------------------------





                            ],
                          ),
                        ),
                      ),

                    elevation: 15,
                  ).closed.then((value)
                  {
                    cubit.ChangeBottomSheetState(isShow: false, icon: Icons.edit);
                    // BottomSheetShown = false;
                    // // setState(() {
                    // //   fabIcon = Icons.edit;
                    // // });
                  });
                  //BottomSheetShown = true;
                cubit.ChangeBottomSheetState(isShow: true, icon: Icons.add);
                }


                //insertToDatabase();
              },
              /* async {
              try{
                var name = await getName();
                print(name);

                //throw(' Some Error ..........');
              }catch(error){
               print('Error${error.toString()}');
              }*/
              // then = badal await || badal try w catch
              /* getName().then((value) {
                print(value);
                print('Mina');
                //throw('i did an error!!!!');
              }
              ).catchError((error) {
                print('Error is ${error.toString()}');
              });
            },*/

              child:

              Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentindex,
              onTap: (index) {
                // setState(() {
                  cubit.ChangeIndex(index);
                // });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.admin_panel_settings_sharp), label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },

      ),
    );
  }

  //Instance of 'Future<String>'

  Future<String> getName() async
  {
    return 'Michael Tawfik';
  }








}



