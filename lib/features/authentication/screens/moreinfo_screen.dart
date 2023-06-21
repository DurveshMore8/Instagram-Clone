import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_instagram_clone/common/alert_dialog.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/pick_image.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/authentication/services/update_more_info.dart';
import 'package:new_instagram_clone/features/authentication/widgets/auth_button.dart';
import 'package:new_instagram_clone/features/authentication/widgets/bio_textfield.dart';
import 'package:new_instagram_clone/features/authentication/widgets/options_slider.dart';
import 'package:new_instagram_clone/features/mainscreen/screens/main_screen.dart';

class MoreinfoScreen extends StatefulWidget {
  const MoreinfoScreen({super.key});

  @override
  State<MoreinfoScreen> createState() => _MoreinfoScreenState();
}

class _MoreinfoScreenState extends State<MoreinfoScreen> {
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _profile;
  List<IconData> icons = [
    Icons.camera_alt_outlined,
    Icons.file_upload_outlined,
    Icons.close,
  ];
  List<String> titles = [
    'Open Camera',
    'Upload from Device',
    'Cancel',
  ];

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
  }

  void updateInfo() {
    updateMoreInfo(_profile, _bioController.text).then((res) {
      if (res == 'success') {
        pushReplacement(context, const MainScreen());
      } else {
        showAlertDialog(
          context,
          res,
          'Try Again',
          'Go To Account',
          () => pop(context),
          () => pushReplacement(context, const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: const SvgIcons(
          path: 'assets/images/text_icon.svg',
          parameters: 30,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
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
                                });
                                pop(context);
                              });
                            },
                            (context) {
                              pickImage(ImageSource.gallery).then((image) {
                                setState(() {
                                  _profile = image;
                                });
                                pop(context);
                              });
                            },
                            (context) => pop(context),
                          ],
                        );
                      },
                    );
                  },
                  child: _profile == null
                      ? const CircleAvatar(
                          radius: 75,
                          backgroundImage:
                              AssetImage('assets/images/defaultProfile.jpg'),
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundImage: MemoryImage(_profile!),
                        ),
                ),
                const SizedBox(height: 20),
                BioTextfield(
                  controller: _bioController,
                  hintText: 'Bio',
                ),
                const SizedBox(height: 50),
                AuthButton(
                  text: 'Proceed',
                  function: updateInfo,
                  disable: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
