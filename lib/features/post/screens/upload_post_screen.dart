import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/pick_image.dart';
import 'package:new_instagram_clone/features/authentication/widgets/options_slider.dart';
import 'package:new_instagram_clone/features/mainscreen/screens/main_screen.dart';
import 'package:new_instagram_clone/features/post/services/upload_post.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  Uint8List _profile = Uint8List.fromList([]);
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void uploadPost() {
    UploadPost().uploadPost(_profile, _bioController.text).then((res) {
      if (res == 'success') {
        pushReplacement(
          context,
          const MainScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => pop(context),
          child: const Icon(
            Icons.close,
            size: 40,
          ),
        ),
        title: const Text(
          'New post',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: _profile.isEmpty
          ? Center(
              child: TextButton(
                onPressed: () {
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
                        icons: const [
                          Icons.camera_alt_outlined,
                          Icons.image_outlined,
                        ],
                        titles: const ['Camera', 'Gallery'],
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
                        ],
                      );
                    },
                  );
                },
                child: const Text('Upload Post'),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Image.memory(
                      _profile,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(height: 100),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _bioController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          label: Text('Bio'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      onTap: uploadPost,
                      child: Container(
                        color: blueColor,
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text('Upload Post'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
