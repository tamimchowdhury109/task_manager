import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/screens/data/models/count_by_status_wrapper.dart';
import 'package:task_manager/presentation/screens/data/models/task_list_wrapper.dart';
import 'package:task_manager/presentation/screens/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/data/utils/urls.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
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
  bool _getAllTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllTaskCountByStatus();
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
              Visibility(
                visible: !_getAllTaskCountByStatusInProgress,
                replacement: const LinearProgressIndicator(),
                child: taskCounterSection,
              ),
              Expanded(
                child: Visibility(
                  visible: !_getNewTaskListInProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: _newTaskListWrapper.taskList![index],
                        onDelete: () {
                          _deleteTaskById(_newTaskListWrapper.taskList![index].sId!);
                        },
                        refreshList: () {
                          _getDataFromApis();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }


  Widget get taskCounterSection {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TaskCounterCard(
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                  '',
              amount:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ??
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


  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status has been failed');
      }
    }
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

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    if (response.isSuccess) {
      _deleteTaskInProgress = false;
      _getDataFromApis();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task has been failed');
      }
    }
  }

}
