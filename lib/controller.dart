import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitecrud/model.dart';

class DatabaseController extends GetxController {
  late Database _database;
  var testList = <Test>[].obs;
  final TextEditingController nameController = TextEditingController();
  var selectedTest = Rxn<Test>();

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'demo.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
    fetchTests();
  }

  Future<void> insertTest() async {
    await _database.insert(
      'Test',
      {'name': nameController.text},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    nameController.clear();
    fetchTests();
  }

  Future<void> updateTest() async {
    if (selectedTest.value != null) {
      await _database.update(
        'Test',
        {'id': selectedTest.value!.id, 'name': nameController.text},
        where: 'id = ?',
        whereArgs: [selectedTest.value!.id],
      );
      selectedTest.value = null;
      nameController.clear();
      fetchTests();
    }
  }

  Future<void> fetchTests() async {
    final List<Map<String, dynamic>> maps = await _database.query('Test');
    testList.value = maps.map((e) => Test.fromMap(e)).toList();
  }

  void setSelectedTest(Test test) {
    selectedTest.value = test;
    nameController.text = test.name;
  }

  Future<void> deleteTest(int id) async {
    await _database.delete('Test', where: 'id = ?', whereArgs: [id]);
    fetchTests();
  }
}