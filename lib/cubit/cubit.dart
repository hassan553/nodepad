import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodepad/cubit/state.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitailState());
  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  void create() async {
    database = await openDatabase(
      'node.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute('create table nodes (title text,id integer primary key )')
            .then((value) {
          print('create database successfully ');
          emit(CreateData());
        }).catchError(
          (onError) {
            print(onError.toString());
          },
        );
      },
      onOpen: (database) {
        getData(database);
        emit(GetData());
      },
    );
  }

  List<Map> titles = [];
  void insert({title}) async {
    database.transaction((txn) async {
      return await txn.rawInsert('insert into nodes (title) values ("$title")');
    }).then((value) {
      print('insert successfully ');
      getData(database);
      emit(InsertData());
      emit(GetData());
    }).catchError((onError) {
      print('erro in insert ');
    });
  }

  void getData(database) async {
    await database.rawQuery('select * from nodes').then((value) {
      print('i get data successfully ');
      titles = value;
      emit(GetData());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  void deleteData(id) {
    database.rawDelete('delete from nodes where id =? ', ['$id']).then((value) {
      print('delete successfully');
      getData(database);
      emit(DeleteData());
      emit(GetData());
    }).catchError((onError) {
      print('error in delete ');
    });
  }

  bool iconChange = true;
  void changeIcon() {
    iconChange = !iconChange;
    emit(ChangeIcon());
  }
}
