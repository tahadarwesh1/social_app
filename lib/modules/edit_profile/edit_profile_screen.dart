import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!.toTitleCase();
        bioController.text = (userModel.bio)!;
        phoneController.text = (userModel.phone)!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                title: 'Update',
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                  // SocialCubit.get(context).uploadProfileImage(
                  //     name: nameController.text,
                  //     phone: phoneController.text,
                  //     bio: bioController.text);
                  // SocialCubit.get(context).uploadCoverImage(
                  //     name: nameController.text,
                  //     phone: phoneController.text,
                  //     bio: bioController.text);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UserUpdateDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UserUpdateDataLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 52.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                title: 'upload profile',
                                onPressed: () {
                                  SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                              ),
                              if (state is GetUserDataLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is GetUserDataLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  title: 'upload cover',
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                ),
                                if (state is GetUserDataLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is GetUserDataLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 10.0,
                    ),
                  defaultTextField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    label: 'Name',
                    prefixIcon: IconBroken.User,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    label: 'Phone',
                    prefixIcon: IconBroken.Call,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextField(
                    keyboardType: TextInputType.text,
                    controller: bioController,
                    label: 'Bio',
                    hintText: 'Write your bio',
                    prefixIcon: IconBroken.Info_Circle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
