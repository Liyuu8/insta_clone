import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// style
import 'package:insta_clone/style.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';

// components
import 'package:insta_clone/view/common/components/circle_photo.dart';
import 'package:insta_clone/view/common/components/dialog/confirm_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _photoUrl = '';
  bool _isImageFromFile = false;
  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _bioEditController = TextEditingController();

  @override
  void initState() {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    _photoUrl = profileUser.photoUrl;
    _isImageFromFile = false;

    _nameEditController.text = profileUser.inAppUserName;
    _bioEditController.text = profileUser.bio;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).editProfile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => showConfirmDialog(
              context: context,
              title: S.of(context).editProfile,
              content: S.of(context).editProfileConfirm,
              onConfirmed: (isConfirmed) =>
                  isConfirmed ? _updateProfile(context) : null,
            ),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) => model.isProcessing
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      Center(
                        child: CirclePhoto(
                          photoUrl: _photoUrl,
                          radius: 60.0,
                          isImageFromFile: _isImageFromFile,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Center(
                        child: InkWell(
                          onTap: () => _pickNewProfileImage(),
                          child: Text(
                            S.of(context).changeProfilePhoto,
                            style: changeProfileImageTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('Name', style: editProfileTitleTextStyle),
                      TextField(
                        controller: _nameEditController,
                      ),
                      SizedBox(height: 16.0),
                      Text('Bio', style: editProfileTitleTextStyle),
                      TextField(
                        controller: _bioEditController,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _pickNewProfileImage() async {
    _isImageFromFile = false;
    final profileViewModel = context.read<ProfileViewModel>();
    _photoUrl = await profileViewModel.pickProfileImage();

    setState(() {
      _isImageFromFile = true;
    });
  }

  Future<void> _updateProfile(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.updateProfile(
      _nameEditController.text,
      _bioEditController.text,
      _photoUrl,
      _isImageFromFile,
    );
    Navigator.pop(context);
  }
}
