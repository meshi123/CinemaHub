import 'package:cinema_hub/views/audi_logs_view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auditorium Log"),
      ),
      body: const AudiLogsView(),
    );
  }
}
