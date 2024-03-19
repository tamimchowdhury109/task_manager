import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: (){
        Navigator.push(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 12,),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tamim Chowdhury',style: TextStyle(
                  fontSize: 16,
                ),),
                Text('tamimchowdhury109@gmail.com',style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),
              ],
            ),
          ),
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
          }, icon: const Icon(Icons.login_outlined)),
        ],
      ),
    ),
  );
}