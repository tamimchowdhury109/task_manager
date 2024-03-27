import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class UserProfileAvatar extends StatelessWidget {

  const UserProfileAvatar({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? photoData = AuthController.userData?.photo;

    if (photoData != null && photoData.isNotEmpty) {
      try {
        Uint8List decodedBytes = base64Decode(photoData);
        return CircleAvatar(
          backgroundImage: MemoryImage(decodedBytes),
        );
      } catch (e) {
        print('Error decoding base64 string: $e');
      }
    }
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/ic_error_profile_picture.jpg'),
    );
  }
}