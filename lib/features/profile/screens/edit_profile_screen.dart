import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/pick_image.dart';
import 'package:new_instagram_clone/features/authentication/widgets/options_slider.dart';
import 'package:new_instagram_clone/features/profile/screens/edit_profile_screens/bio_screen.dart';
import 'package:new_instagram_clone/features/profile/screens/edit_profile_screens/gender_screen.dart';
import 'package:new_instagram_clone/features/profile/screens/edit_profile_screens/name_screen.dart';
import 'package:new_instagram_clone/features/profile/screens/edit_profile_screens/username_screen.dart';
import 'package:new_instagram_clone/features/profile/services/editprofile_services.dart';
import 'package:new_instagram_clone/features/profile/widgets/edit_textfield.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pronounController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  Map<String, dynamic> valuesToUpdate = {};
  late UserModel user;
  Uint8List? _profile;
  bool imageRemoved = false;

  List<IconData> icons = [
    Icons.camera_alt_outlined,
    Icons.file_upload_outlined,
    Icons.delete_outlined,
  ];
  List<String> titles = [
    'Open Camera',
    'Upload from Device',
    'Remove Current Picture',
  ];

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).getUser;
    _nameController.text = user.name;
    _usernameController.text = user.username;
    _bioController.text = user.bio;
    _genderController.text = user.gender;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _pronounController.dispose();
    _bioController.dispose();
    _genderController.dispose();
  }

  void editImage() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return OptionsSlider(
          icons: icons,
          titles: titles,
          functions: [
            (context) {
              pickImage(ImageSource.camera).then((image) {
                setState(() {
                  _profile = image;
                  imageRemoved = false;
                });
                pop(context);
              });
            },
            (context) {
              pickImage(ImageSource.gallery).then((image) {
                setState(() {
                  _profile = image;
                  imageRemoved = false;
                });
                pop(context);
              });
            },
            (context) {
              setState(() {
                _profile = null;
                imageRemoved = true;
                pop(context);
              });
            },
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 10,
            top: 25,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Text(
                  'Edit profile',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  EditprofileServices()
                      .updateDetails(
                    valuesToUpdate,
                    _profile,
                    imageRemoved,
                  )
                      .then((res) {
                    if (res == 'success') {
                      Provider.of<UserProvider>(context, listen: false)
                          .refreshUser()
                          .then((value) => pop(context));
                    }
                  });
                },
                icon: Icon(
                  Icons.check,
                  color: blueColor,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: editImage,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profile != null
                          ? MemoryImage(_profile!)
                          : imageRemoved || user.profilePic.isEmpty
                              ? const AssetImage(
                                      'assets/images/defaultProfile.jpg')
                                  as ImageProvider<Object>?
                              : NetworkImage(user.profilePic),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Edit picture or avatar',
                      style: TextStyle(color: blueColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              EditTextfield(
                controller: _nameController,
                hintText: 'Name',
                readOnly: true,
                function: () => pushReturnValue(
                  context,
                  NameScreen(name: _nameController.text),
                ).then((name) {
                  _nameController.text = name;
                  if (user.name == name) {
                    if (valuesToUpdate.containsKey('name')) {
                      valuesToUpdate.remove('name');
                    }
                  } else {
                    if (valuesToUpdate.containsKey('name')) {
                      valuesToUpdate.update('name', (value) => name);
                    } else {
                      valuesToUpdate.addAll({'name': name});
                    }
                  }
                }),
              ),
              EditTextfield(
                controller: _usernameController,
                hintText: 'Username',
                readOnly: true,
                function: () => pushReturnValue(
                  context,
                  UsernameScreen(username: _usernameController.text),
                ).then((username) {
                  _usernameController.text = username;
                  if (user.username == username) {
                    if (valuesToUpdate.containsKey('username')) {
                      valuesToUpdate.remove('username');
                    }
                  } else {
                    if (valuesToUpdate.containsKey('username')) {
                      valuesToUpdate.update('username', (value) => username);
                    } else {
                      valuesToUpdate.addAll({'username': username});
                    }
                  }
                }),
              ),
              EditTextfield(
                controller: _pronounController,
                hintText: 'Pronoun',
                readOnly: true,
                function: () {},
              ),
              EditTextfield(
                controller: _bioController,
                hintText: 'Bio',
                readOnly: true,
                function: () => pushReturnValue(
                  context,
                  BioScreen(bio: _bioController.text),
                ).then((bio) {
                  _bioController.text = bio;
                  if (user.bio == bio) {
                    if (valuesToUpdate.containsKey('bio')) {
                      valuesToUpdate.remove('bio');
                    }
                  } else {
                    if (valuesToUpdate.containsKey('bio')) {
                      valuesToUpdate.update('bio', (value) => bio);
                    } else {
                      valuesToUpdate.addAll({'bio': bio});
                    }
                  }
                }),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Add link',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              EditTextfield(
                controller: _genderController,
                hintText: 'Gender',
                readOnly: true,
                function: () => pushReturnValue(
                  context,
                  GenderScreen(gender: _genderController.text),
                ).then((gender) {
                  _genderController.text = gender;
                  if (user.gender == gender) {
                    if (valuesToUpdate.containsKey('gender')) {
                      valuesToUpdate.remove('gender');
                    }
                  } else {
                    if (valuesToUpdate.containsKey('gender')) {
                      valuesToUpdate.update('gender', (value) => gender);
                    } else {
                      valuesToUpdate.addAll({'gender': gender});
                    }
                  }
                }),
                icon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
