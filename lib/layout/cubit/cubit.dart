import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(LayoutBottomNavState());
  }

  void getUserData() {
    emit(UserDataLoadingState());

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
