import 'package:flutter/material.dart';
import 'package:temelwidget/models/student.dart';
import 'package:temelwidget/validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student selectedStudent = new Student.withoutInfo();
  StudentEdit(Student selectedStudents){
    this.selectedStudent = selectedStudent;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudent); // Alt çizgi zorunlu değil ancak bu şekilde yazılır!
  }
}
// with : ile sınıfın fonksiyonlarını kullanabiliriz!
class _StudentAddState extends State with StudentValidationMixin{
  Student selectedStudent = new Student.withoutInfo();

  _StudentAddState(selectedStudent){
    this.selectedStudent = selectedStudent;
  }

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
      initialValue: selectedStudent.firstName.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Ex: İbrahim Can"),
      validator: (firstName){
        if(isNameValid(firstName!.toString())) return null;
        else return 'Enter a valid name';
      },
      onSaved: (String? value){
        if(value != null){
          selectedStudent.firstName = value.toString();
        }
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Ex: Erdoğan"),
      validator: (lastName){
        if(isNameValid(lastName!.toString())) return null;
        else return 'Enter a valid name';
      },
      onSaved: (String? value){
        if(value != null){
          selectedStudent.lastName = value.toString();
        }
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Alınan Not", hintText: "Ex: 65"),
      validator: (grade) {
        if (isGradeValid(grade!.toString())) return null;
        else return 'Enter a valid grade';
      },
      onSaved: (String? value){
        if(value != null){
          selectedStudent.grade = int.parse(value.toString());
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
          saveStudent();
          // Otomatik Olarak Ana sayfaya geçiş!
          Navigator.pop(context);
        }
      },
      child: Text("Kaydet"),
    );
  }

  void saveStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade.toString());
  }
}
