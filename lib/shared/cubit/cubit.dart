import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutterr/modules/todo_app/archived_tasks/archived_tasks.dart';
import 'package:udemy_flutterr/modules/todo_app/done_tasks/done_tasks.dart';
import 'package:udemy_flutterr/modules/todo_app/new_taks/new_tasks.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';
import 'package:udemy_flutterr/shared/network/local/cache_helper.dart';
import 'package:udemy_flutterr/modules/todo_app/done_tasks/done_tasks.dart';
import 'package:udemy_flutterr/shared/cubit/states.dart';

import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Map> tasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = ['Tasks', 'Done Tasks', 'Arhived Tasks'];

  void ChangeIndex(int index) {
    currentindex = index;
    emit(AppChangedBottomNabBarState());
  }

  // Database
  late Database database;

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('Database created');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((onError) {
        print('Error When creating table ${onError.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","active")')
          .then((value) {
        print('$value successfuly inserted');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
        print('Database Opened');
        emit(AppCreateDatabaseState());
      }).catchError((error) {
        print('Error when you add a new record to database${error.toString()}');
      });

      return null;
    });
  }

  //Future<List<Map>> getDataFromDatabase(database) async
  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];

    emit(AppGetDatabaseLoadingState());

    // Get the records
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      // print(tasks);
      // print(tasks);

      value.forEach((element) {
        if (element['status'] == 'active') {
          newtasks.add(element);
        } else if (element['status'] == 'Done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool BottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    BottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangedBottomsheetState());
  }

  bool isDark = false;
  void ChangeAppMode({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ChangeModeState());
    });
  }
}
