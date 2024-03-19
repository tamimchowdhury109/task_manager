import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title will be here',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
            Text('Description will be here'),
            Text('Date: 20-03-24'),
            Row(
              children: [
                Chip(label: Text('New'),),
                const Spacer(),
                IconButton(onPressed: (){},
                  icon: Icon(Icons.edit),),
                IconButton(onPressed: (){},
                  icon: Icon(Icons.delete),),
              ],
            )
          ],
        ),
      ),
    );
  }
}