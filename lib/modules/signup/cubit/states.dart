abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLodingState extends RegisterStates {}

class RegisterSuccessesState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class UserCreateSuccessesState extends RegisterStates {}

class UserCreateErrorState extends RegisterStates {
  final String error;

  UserCreateErrorState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterStates {}
