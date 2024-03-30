import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/screens/data/models/count_by_status_wrapper.dart';
import 'package:task_manager/presentation/screens/data/models/task_count_by_status_data.dart';
import 'package:task_manager/presentation/screens/data/models/task_list_wrapper.dart';
import 'package:task_manager/presentation/screens/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/data/utils/urls.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress = false;
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: RefreshIndicator(
          onRefresh: () async {
            _getDataFromApis();
          },
          child: Column(
            children: [
              GetBuilder<CountTaskByStatusController>(
                builder: (countTaskByStatusController) {
                  return Visibility(
                    visible: countTaskByStatusController.inProgress == false,
                    replacement: const LinearProgressIndicator(),
                    child: taskCounterSection(countTaskByStatusController.countByStatusWrapper.listOfTaskByStatusData ?? []),
                  );
                },
              ),
              Expanded(
                child: Visibility(
                  visible: !_getNewTaskListInProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Visibility(
                    visible: _newTaskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: const EmptyListWidget(),
                    child: ListView.builder(
                      itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskItem: _newTaskListWrapper.taskList![index],
                          refreshList: () {
                            _getDataFromApis();
                          }, deleteTask: () {
                            _getDataFromApis();
                        },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (result != null && result == true){
            _getDataFromApis();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget taskCounterSection(List<TaskCountByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        itemCount: listOfTaskCountByStatus.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TaskCounterCard(
              title: listOfTaskCountByStatus[index].sId ??
                  '',
              amount:
              listOfTaskCountByStatus[index].sum ??
                      0);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 1,
          );
        },
      ),
    );
  }


  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _getNewTaskListInProgress = false;
      setState(() {});
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get new task has been failed');
      }
    }
  }
}
