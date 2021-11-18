import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/signup/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userDataRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(RegisterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessesState());
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      navigateAndFinish(context, LoginScreen());
    });
  }
}
