enum AccountTypeEnum{
  administrador('administrador'),
  industria('industria'),
  coordinator('coordinator'),
  viewer('viewer');


  const AccountTypeEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  AccountTypeEnum toAccountTypeEnum(){
    switch(this){
      case 'administrador':
        return AccountTypeEnum.administrador;
      case 'industria':
        return AccountTypeEnum.industria;
      case 'coordinator':
        return AccountTypeEnum.coordinator;
      case 'viewer':
        return AccountTypeEnum.viewer;
      default:
        return AccountTypeEnum.coordinator;
    }
  }
}