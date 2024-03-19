import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
=======
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
>>>>>>> origin/master
import 'package:task_manager/presentation/widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
          child: Column(
        children: [
          taskCounterSection,
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskCard();
                }),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        backgroundColor: AppColors.themeColor,
<<<<<<< HEAD
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
        },
=======
        onPressed: (){},
>>>>>>> origin/master
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const TaskCounterCard(amount: 12, title: 'New');
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}


