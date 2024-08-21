import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/add_todo/controller/add_controller.dart';
import 'package:todo_app/utils/extension/custom_extentions.dart';

class AddTodoScreen extends StatefulWidget {
  AddTodoScreen({this.routeData});
  final Map<dynamic, dynamic>? routeData;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timne) {
      var provider = Provider.of<AddController>(context, listen: false);
      if (widget.routeData != null &&
          widget.routeData?.containsKey("isEdit") == true) {
        context.read<AddController>().setParam(widget.routeData!["data"]);
      } else {
        provider.resetFields();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('12'.tr(),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AddController>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  '13'.tr(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: value.titleController,
                  decoration: InputDecoration(
                    hintText: '14'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '15'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  controller: value.descriptionController,
                  decoration: InputDecoration(
                    hintText: '16'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '17'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: value.selectedDate != null
                        ? DateFormat.yMd().format(value.selectedDate!)
                        : '18'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      // barrierColor: Colors.teal,

                      context: context,
                      initialDate: value.selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null &&
                        pickedDate != value.selectedDate) {
                      value.setDueDate = pickedDate;
                    }
                  },
                ),
                50.sbh,
                Center(
                  // width: size.width,
                  child: value.loader
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : MaterialButton(
                          onPressed: () {
                            if (widget.routeData != null &&
                                widget.routeData?.containsKey("isEdit") ==
                                    true) {
                              value.updateTodo(todo: widget.routeData!["data"]);
                            } else {
                              value.createTodo();
                            }
                          },
                          color: Colors.white, // Set the button color to teal
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          textColor:
                              Colors.black, // Set the text color to white
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                          child: Text(
                            widget.routeData != null &&
                                    widget.routeData?.containsKey("isEdit") ==
                                        true
                                ? "19".tr()
                                : '20'.tr(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ],
            );
          }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.save,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.teal,
      // ),
    );
  }
}
