import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/data/models/task_item.dart';
import 'package:task_manager/presentation/screens/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/data/utils/urls.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem, required this.onDelete,required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback onDelete;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _updateTaskStatusInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.taskItem.description ?? ' '),
            Text('Date: ${widget.taskItem.createdDate}'),
            Row(
              children: [
                Chip(
                  label: Text(widget.taskItem.status ?? ''),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (){
                    _showUpdateStatusDialog(widget.taskItem.sId!);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.delete),
                ),
              ],
            )
          ],
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
              const ListTile(
                title: Text("New"),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                title: const Text("Complete"),
                onTap: () {
                  Navigator.pop(context);
                  _updateTaskById(id, 'Complete');
                },
              ),
              ListTile(
                title: const Text("Progress"),
                onTap: () {
                  Navigator.pop(context);
                  _updateTaskById(id, 'Progress');
                },
              ),
              ListTile(
                title: const Text("Cancelled"),
                onTap: () {
                  Navigator.pop(context);
                  _updateTaskById(id, 'Cancelled');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
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
}
