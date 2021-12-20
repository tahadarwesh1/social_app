import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is AddNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            backgroundColor: defaultColor,
            style: TabStyle.flip,
            items: [
              TabItem(
                
                icon: Icon(IconBroken.Home),
                title: 'Home',
              ),
              TabItem(
                icon: Icon(IconBroken.Chat),
                title: 'Chat',
              ),
              TabItem(
                icon: Icon(IconBroken.Paper_Upload),
                title: 'Post',
              ),
              TabItem(
                icon: Icon(IconBroken.User),
                title: 'Users',
              ),
              TabItem(
                icon: Icon(IconBroken.Setting),
                title: 'Settings',
              ),
            ],
            initialActiveIndex: cubit.currentIndex,
            
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
