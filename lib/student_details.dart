import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'student.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Student> studentList = [];

  // late final table = firebaseFirestore.collection("student");
  //
  // Future<void> getStudentData() async {
  //   final QuerySnapshot data = await table.get();
  //   studentList.clear();
  //   for (QueryDocumentSnapshot element in data.docs) {
  //     Student student = Student(
  //         name: element.get("Name"),
  //         roll: int.tryParse(element.get("Roll").toString()) ?? 0,
  //         id: element.id);
  //     studentList.add(student);
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    // getStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection("student").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error${snapshot.error}"),
              );
            }

            if (snapshot.hasData) {
              studentList.clear();
              for (QueryDocumentSnapshot element in snapshot.data!.docs) {
                Student student = Student(
                    name: element.get("Name"),
                    roll: int.tryParse(element.get("Roll").toString()) ?? 0,
                    id: element.id);
                studentList.add(student);
              }
              return ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(studentList[index].name.toString()),
                      subtitle: Text(studentList[index].id),
                      leading: CircleAvatar(
                        child: Text(studentList[index].roll.toString()),
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                updateBottomSheet(index);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                firebaseFirestore
                                    .collection("student")
                                    .doc(studentList[index].id)
                                    .delete();
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else {
              return const SizedBox();
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addBottomSheet() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
              ),
              TextFormField(
                controller: rollController,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await firebaseFirestore.collection("student").add({
                    "Name": nameController.text.trim(),
                    "Roll": rollController.text.trim(),
                  });
                  Navigator.pop(context);
                },
                child: const Text('Submit'))
          ],
        );
      },
    );
  }

  updateBottomSheet(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
              ),
              TextFormField(
                controller: rollController,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  firebaseFirestore
                      .collection("student")
                      .doc(studentList[index].id)
                      .update({
                    "Name": nameController.text.trim(),
                    "Roll": rollController.text.trim(),
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }
}


