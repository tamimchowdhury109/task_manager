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

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getAllCancelledTaskCountByStatusInProgress = false;
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis(){
    _getAllCancelledTaskList();
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
            visible: !_getAllCancelledTaskCountByStatusInProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _cancelledTaskListWrapper.taskList![index],
                    deleteTask: (){},
                    refreshList: (){
                      _getAllCancelledTaskList();
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
  Future<void> _getAllCancelledTaskList() async {
    _getAllCancelledTaskCountByStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSuccess) {
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllCancelledTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllCancelledTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get cancelled task has been failed');
      }
    }
  }
}
