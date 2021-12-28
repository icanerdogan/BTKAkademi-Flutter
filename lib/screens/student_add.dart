import 'package:flutter/material.dart';
import 'package:temelwidget/models/student.dart';
import 'package:temelwidget/validation/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students = [];
  StudentAdd(List<Student> students){
    this.students = students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students); // Alt çizgi zorunlu değil ancak bu şekilde yazılır!
  }
}
// with : ile sınıfın fonksiyonlarını kullanabiliriz!
class _StudentAddState extends State with StudentValidationMixin{
  List<Student> students = [];

  _StudentAddState(List<Student> students){
    this.students = students;
  }

  var student = Student.withoutInfo();
  //FORMLARI KOLAY YÖNETEBİLMEK İÇİN KEY VERİYORUZ!
  var formKey = GlobalKey<FormState>();
  // Burası bizim Widget ağacımızı çizeceğimiz yerdir!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top:10.0, left: 10.0, right: 10.0),
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Ex: İbrahim Can"),
      validator: (firstName){
        if(isNameValid(firstName!.toString())) return null;
        else return 'Enter a valid name';
      },
      onSaved: (String? value){
        if(value != null){
          student.firstName = value.toString();
        }
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Ex: Erdoğan"),
      validator: (lastName){
        if(isNameValid(lastName!.toString())) return null;
        else return 'Enter a valid name';
      },
      onSaved: (String? value){
        if(value != null){
          student.lastName = value.toString();
        }
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Alınan Not", hintText: "Ex: 65"),
      validator: (grade) {
        if (isGradeValid(grade!.toString())) return null;
        else return 'Enter a valid grade';
      },
      onSaved: (String? value){
        if(value != null){
          student.grade = int.parse(value.toString());
        }
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
        onPressed: (){
          //Tüm Doğrulamalardan geçerse
          if(formKey.currentState!.validate()){
            // Form içindeki onSaved fonksiyonlarını çalıştırıyoruz!
            formKey.currentState!.save();
            students.add(student);
            saveStudent();
            // Otomatik Olarak Ana sayfaya geçiş!
            Navigator.pop(context);
          }
        },
        child: Text("Kaydet"),
    );
  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade.toString());
  }
}
