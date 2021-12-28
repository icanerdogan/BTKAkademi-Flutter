mixin StudentValidationMixin{ // Dart dilinde Mixin

  bool isGradeValid(String value){
    var grade = int.parse(value);
    if(grade <= 0 || grade > 100){
      return false;
    }
    return true;
  }

  bool isNameValid(String name) {
    if(name.length<2 || name.length > 50){
      return false;
    }
    return true;
  }
}