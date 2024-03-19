import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    title: Row(
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
        IconButton(onPressed: (){}, icon: const Icon(Icons.login_outlined)),
      ],
    ),
  );
}