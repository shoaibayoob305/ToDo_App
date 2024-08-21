import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/home/controller/home_controller.dart';
import 'package:todo_app/screens/home/widgets/task_card.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/utils/widgets/custom_loaders.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((time) {
      context.read<HomeController>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('6'.tr(),
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.add,color: Colors.white,),
            //   onPressed: () {
            // Navigator.pushNamed(context, RoutesNames.addTodo);
            //     // Action to add a new task
            //   },
            // ),
            Consumer<HomeController>(
              builder: (context,value,child) {
                return Switch(
                  value: value.togleTranslation,
                  onChanged: (val) {
                  value.setTogleTranlation=val;
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                );
              }
            ),

          ],
        ),
        body: Consumer<HomeController>(builder: (context, value, child) {
          return value.loader
              ? CustomLoader()
              : RefreshIndicator(
                onRefresh: () async{
                  value.init();
                  return await  Future.value(true);
                },
                child: Container(
                  height:size.height ,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.tealAccent, Colors.teal],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.todoList.length,
                        itemBuilder: (context, index) {
                          var data = value.todoList[index];
                          return TaskCard(
                            todo: data,
                            index: index,
                          );
                        })),
              );
        }),
        floatingActionButton: FloatingActionButton(
          key: const Key('create todo'),
          onPressed: () {
            // Add a new task
            Navigator.pushNamed(context, RoutesNames.addTodo);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
