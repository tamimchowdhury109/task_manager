import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/profile_picture_widget.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));

      },
      child: Row(
        children: [
          const UserProfileAvatar(),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? 'Name',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  AuthController.userData?.email ?? 'Abc@mail.com',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.login_outlined)),
        ],
      ),
    ),
  );
}


