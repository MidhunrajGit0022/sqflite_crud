class Test {
  int? id;
  String name;


  Test({this.id, required this.name,});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
        id: map['id'], name: map['name']);
  }
}
