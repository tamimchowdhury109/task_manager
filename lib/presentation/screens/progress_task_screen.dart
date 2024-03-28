import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/data/models/task_list_wrapper.dart';
import 'package:task_manager/presentation/screens/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getAllProgressTaskCountByStatusInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis(){
    _getAllCompletedTaskList();
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
          child: Visibility(
            visible: !_getAllProgressTaskCountByStatusInProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _progressTaskListWrapper.taskList![index],
                    deleteTask: (){},
                    refreshList: (){
                      _getAllCompletedTaskList();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getAllCompletedTaskList() async {
    _getAllProgressTaskCountByStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllProgressTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllProgressTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get progress task has been failed');
      }
    }
  }
}
