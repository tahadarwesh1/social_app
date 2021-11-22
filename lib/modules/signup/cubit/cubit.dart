import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
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
      print(value.user!.email);
      print(value.user!.uid);
      createUserData(
          email: email, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void createUserData({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel? userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isVirified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          userModel.toMap(),
        )
        .then((value) {
      emit(UserCreateSuccessesState());
    }).catchError((error) {
      print(error.toString());
      UserCreateErrorState(error.toString());
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
