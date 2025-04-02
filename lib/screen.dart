
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflitecrud/model.dart';
import 'controller.dart';

class HomeScreen extends StatelessWidget {
  final DatabaseController controller = Get.put(DatabaseController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD SQflite')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.insertTest(),
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () => controller.updateTest(),
                  child: Text('Update'),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.testList.length,
                  itemBuilder: (context, index) {
                    final test = controller.testList[index];
                    return ListTile(
                      title: Text(test.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => controller.setSelectedTest(test),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.deleteTest(test.id!),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
