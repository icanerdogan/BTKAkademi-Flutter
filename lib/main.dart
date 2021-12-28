import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:temelwidget/screens/student_add.dart';
import 'package:temelwidget/screens/student_edit.dart';
import 'models/student.dart';

//Flutter için herşey widgetlardan oluşur!
void main() {
  // Material App : Bize tamamen material standartlarında çalışan bir app kurar. Mutlaka bununla başlarız!
  runApp(MaterialApp(home: MyApp()));
}

// Kendi widgetımızı oluşturmak için
//Stateless Widgetlarda ekran bir kere çizilir ve değişmez
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "İbrahim Can Erdoğan";

  Student selectedStudent = Student.withId(0, "", "", 0);

  List<Student> students = [
    Student.withId(1, "İbrahim Can", "Erdoğan", 50),
    Student.withId(2, "Atilla", "R", 85),
    Student.withId(3, "Ali", "Avcı", 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: buildBody(context),
    );
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert =
        AlertDialog(title: Text("İşlem Sonucu: "), content: Text(mesaj));
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        //ListView
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/62.jpg"),
                    ),
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan Aldığı Not: " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStateIcon(students[index].grade),
                    onTap: () {
                      // Sadece değişen kısmı değiştiriyor.
                      setState(() {
                        selectedStudent = students[index];
                      });
                      showToastMessage(context, students, index);
                    },
                  );
                })),
        Text("Seçili Öğrenci: " + selectedStudent.firstName.toString()),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5.0),
                    Text("Ekle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd(students)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.update),
                    SizedBox(width: 5.0),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentEdit(selectedStudent)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 5.0),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  // Bir kere dokunulduğunda
                  setState(() {
                    // Ekrana yeniden çizdirmek için setState içine yaz!
                    students.remove(selectedStudent);
                  });
                  var mesaj = "Silindi : " + selectedStudent.firstName.toString() ;
                  mesajGoster(context, mesaj);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStateIcon(int grade) {
    if (grade > 50) {
      return Icon(Icons.done);
    } else {
      return Icon(Icons.cancel);
    }
  }

  showToastMessage(BuildContext context, List<Student> students, int index) {
    Fluttertoast.showToast(
        msg: "İsim: " +
            students[index].firstName.toString() +
            "\n" +
            "Soyisim: " +
            students[index].lastName.toString() +
            "\n" +
            "Not: " +
            students[index].grade.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
