class Student{
  int id = 0;
  String firstName = "";
  String lastName = "";
  int grade = 0;
  String _status = "";


  Student.withId(this.id, this.firstName, this.lastName, this.grade);
  Student.withoutInfo(){}

  String get getFirstName{
    return "OGR - " + firstName;
  }

  set setFirstName(String value){
    firstName = value;
  }

  String get getStatus{
    String message = "";

    if (grade >= 50) {
      message = "Geçtin";
    } else {
      message = "Kaldın";
    }
    return message;
  }
}