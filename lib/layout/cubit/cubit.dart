import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'News Feeds',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(SocialBottomNavState());
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error));
    });

    // DioHelper.getData(
    //   url: PROFILE,
    //   token: token,
    // ).then((value) {
    //   userData = LoginModel.fromJson(value.data);
    //   print(
    //     userData!.data.name.toString(),
    //   );

    //   emit(UserDataSuccessState());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(UserDataErrorState());
    // });
  }

  void updateUserData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UserUpdateDataLoadingState());

    // DioHelper.putData(
    //   url: UPDATE,
    //   data: {
    //     'email': email,
    //     'name': name,
    //     'phone': phone,
    //   },
    //   token: token,
    // ).then((value) {
    //   userData = LoginModel.fromJson(value.data);
    //   print(userData!.data.name.toString());

    //   emit(UserUpdateDataSuccessState());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(UserUpdateDataErrorState());
    // });
  }
}
