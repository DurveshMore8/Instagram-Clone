import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/pick_image.dart';
import 'package:new_instagram_clone/features/authentication/widgets/options_slider.dart';
import 'package:new_instagram_clone/features/mainscreen/screens/main_screen.dart';
import 'package:new_instagram_clone/features/post/services/upload_post.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  Uint8List _profile = Uint8List.fromList([]);
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void uploadPost() {
    UploadPost().uploadPost(_profile, _captionController.text).then((res) {
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
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

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
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'New post',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            _profile.isEmpty
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: uploadPost,
                      child: const Text(
                        'Share',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
          ],
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
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: user.profilePic.isEmpty
                        ? const AssetImage('assets/images/defaultProfile')
                            as ImageProvider
                        : NetworkImage(user.profilePic),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: _captionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'Write a caption...',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.memory(_profile),
                  )
                ],
              ),
            ),
      // SingleChildScrollView(
      //     child: Container(
      //       padding: const EdgeInsets.only(top: 30),
      //       child: Column(
      //         children: [
      //           Image.memory(
      //             _profile,
      //             width: MediaQuery.of(context).size.width,
      //           ),
      //           const SizedBox(height: 100),
      //           Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 20),
      //             child: TextField(
      //               controller: _captionController,
      //               maxLines: null,
      //               keyboardType: TextInputType.multiline,
      //               decoration: const InputDecoration(
      //                 label: Text('Caption'),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
    );
  }
}
