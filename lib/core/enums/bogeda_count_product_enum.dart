enum BogedaCountProductEnum{
  A('A'),
  B('B');


  const BogedaCountProductEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertBogedaCountProductEnum on String{
  BogedaCountProductEnum toBogedaCountProductEnum(){
    switch(this){
      case 'A':
        return BogedaCountProductEnum.A;
      case 'B':
        return BogedaCountProductEnum.B;
      default:
        return BogedaCountProductEnum.A;
    }
  }
}