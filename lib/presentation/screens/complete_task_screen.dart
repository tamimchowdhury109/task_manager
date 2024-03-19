import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
          child: Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskCard();
                }),
          ),),
    );
  }
}


