import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nevis_cli/src/features/features_main/data/model/CommandModel.dart';

import '../../data/command_bus.dart' as bus;
import 'CommandListItemWidget.dart';

class ListCommandsWidget extends StatefulWidget {
  const ListCommandsWidget({super.key});

  @override
  State<ListCommandsWidget> createState() => _ListCommandsWidgetState();
}

class _ListCommandsWidgetState extends State<ListCommandsWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CommandModel>>(
      future: loadCommands(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final commands = snapshot.data!;

        // فقط ListView کافی است
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), // ویندوز/دسکتاپ
          itemCount: commands.length,
          itemBuilder: (_, i) => CommandListItemWidget(
            commandName: commands[i].commandName,
            description: commands[i].description,
            onTap: (){
              bus.commandBus.value = commands[i].terminalCode;
            },
          ),
        );
      },
    );
  }
}
