import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<CommandModel>> loadCommands() async {
  final String raw =
  await rootBundle.loadString('assets/commands.json');
  final List<dynamic> decoded = jsonDecode(raw);
  return decoded.map((e) => CommandModel.fromJson(e)).toList();
}

class CommandModel {
  final String commandName;
  final String description;
  final String terminalCode;

  CommandModel({
    required this.commandName,
    required this.description,
    required this.terminalCode,
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) => CommandModel(
    commandName: json['commandName'],
    description: json['description'],
    terminalCode: json['terminalCode'],
  );
}