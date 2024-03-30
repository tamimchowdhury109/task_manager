import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/presentation/screens/data/models/task_item.dart';
import 'package:task_manager/presentation/screens/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/status_color_widget.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
    required this.deleteTask,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;
  final VoidCallback deleteTask;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Card(
        shadowColor: Colors.black26,
        elevation: 5,
        surfaceTintColor: const Color(0xfffaf8f6),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.taskItem.title ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      const ImageIcon(
                        size: 18,
                          AssetImage('assets/images/icon/ic_date.png'),color: Colors.black54,),
                      const SizedBox(width: 2),
                      Text(
                        '${widget.taskItem.createdDate}',
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.taskItem.description ?? ' ',textAlign: TextAlign.justify,),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color:
                          StatusBackgroundColors.getColor(widget.taskItem.status),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.taskItem.status ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      _showUpdateStatusDialog(widget.taskItem.sId!);
                    },
                    // icon: const Icon(Icons.edit),
                    icon: const ImageIcon(
                        AssetImage('assets/images/icon/ic_edit.png')),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteTaskById(widget.taskItem.sId!);
                    },
                    icon: const ImageIcon(
                        size: 22, AssetImage('assets/images/icon/ic_delete.png')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("New"),
                trailing:
                    _isCurrentStatus('New') ? const Icon(Icons.check) : null,
                onTap: () {
                  if (_isCurrentStatus('New')) {
                    return;
                  }
                  _updateTaskById(id, 'New');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Complete"),
                trailing: _isCurrentStatus('Complete')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Complete')) {
                    return;
                  }
                  _updateTaskById(id, 'Complete');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Progress"),
                trailing: _isCurrentStatus('Progress')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Progress')) {
                    return;
                  }
                  _updateTaskById(id, 'Progress');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Cancelled"),
                trailing: _isCurrentStatus('Cancelled')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Cancelled')) {
                    return;
                  }
                  _updateTaskById(id, 'Cancelled');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isCurrentStatus(String status) {
    return widget.taskItem.status! == status;
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    if (response.isSuccess) {
      _updateTaskStatusInProgress = false;
      setState(() {});
      widget.refreshList();
    } else {
      _updateTaskStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Update task status has been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    if (response.isSuccess) {
      _deleteTaskInProgress = false;
      widget.refreshList();
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
