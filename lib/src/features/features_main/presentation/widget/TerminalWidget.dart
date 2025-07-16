import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xterm/ui.dart';
import 'package:xterm/xterm.dart';

import '../../data/command_bus.dart' as bus;

class TerminalWidget extends StatefulWidget {
  const TerminalWidget({super.key});

  @override
  State<TerminalWidget> createState() => _TerminalWidgetState();
}

class _TerminalWidgetState extends State<TerminalWidget> {
  final GlobalKey<_TerminalWidgetState> terminalKey = GlobalKey();
  final commandNotifier = ValueNotifier<String>('');
  final Terminal _terminal = Terminal(maxLines: 10000);
  late final Process _process;

  /// بارگذاری آدرس و اجرای دستور
  Future<void> _runInTerminal() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('saved_address') ?? Directory.current.path;
    print(path);
    // اگر روی ویندوز هستید، از powershell یا cmd استفاده کنید
    final shell = Platform.isWindows ? 'powershell' : 'bash';
    _process = await Process.start(
      shell,
      [],
      workingDirectory: path,
      runInShell: true,
    );

    // خروجی را به ترمینال بریزید
    _process.stdout.listen((data) => _terminal.write(utf8.decode(data)));
    _process.stderr.listen((data) => _terminal.write(utf8.decode(data)));

    // اگر کاربر در ترمینال چیزی نوشت، به stdin پردازش بدهید
    _terminal.onOutput = (data) {
      _process.stdin.writeln(data);
    };

    // پیام خوش‌آمد
    _terminal.write('Shell started in: $path\n\$ ');
  }

  void _onNewCommand() {
    final cmd = bus.commandBus.value;
    if (cmd.isNotEmpty) {
      try {
        _process.stdin.writeln(cmd);
      } catch (_) {}
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runInTerminal());
    bus.commandBus.addListener(_onNewCommand);
  }

  @override
  void dispose() {
    bus.commandBus.removeListener(_onNewCommand);
    _process.kill(); // حتماً ببندید
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TerminalView(
      key: (terminalKey),
      _terminal,
      autofocus: true,
      readOnly: false,
      textStyle: TerminalStyle(fontSize: 13),
      backgroundOpacity: 1,
    );
  }
}
