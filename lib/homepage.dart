import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nodepad/cubit/cubit.dart';
import 'package:nodepad/cubit/state.dart';


class Home extends StatelessWidget {
  var has = 'hassan';
  var titleController = TextEditingController();
  var bottomSheetKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..create(),
      child: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text('Nodepad'),
            ),
            body: ListView.builder(
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: ((direction) {
                    cubit.deleteData(cubit.titles[index]['id']);
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: HexColor('333739'),
                    ),
                    child: Text(
                      cubit.titles[index]['title'],
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                );
              }),
              itemCount: cubit.titles.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.changeIcon();

                scaffoldKey.currentState!
                    .showBottomSheet((context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: bottomSheetKey,
                                child: TextFormField(
                                  maxLines: 5,
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (vaule) {
                                    if (vaule!.isEmpty) {
                                      return ' Task not valid to be  Empty';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                if (bottomSheetKey.currentState!.validate()) {
                                  cubit.insert(title: titleController.text);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.orange,
                                  ),
                                  width: double.infinity,
                                  height: 50,
                                  child: Text(
                                    'save',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )),
                            ),
                          ),
                        ],
                      );
                    })
                    .closed
                    .then((value) {
                      cubit.changeIcon();
                    });
              },
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
