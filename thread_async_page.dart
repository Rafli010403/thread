import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk compute

class ThreadAsyncPage extends StatefulWidget {
  const ThreadAsyncPage({super.key});

  @override
  State<ThreadAsyncPage> createState() => _ThreadAsyncPageState();
}

class _ThreadAsyncPageState extends State<ThreadAsyncPage> {
  String result = "Belum diproses";

  Future<void> runAsyncTask() async {
    setState(() {
      result = "Sedang memproses...";
    });

    // Menjalankan fungsi berat di background (thread terpisah)
    String output = await compute(heavyTask, 5); // contoh input: 5 detik

    setState(() {
      result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thread & AsyncTask")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: runAsyncTask,
              child: const Text("Jalankan Tugas Berat (AsyncTask)"),
            )
          ],
        ),
      ),
    );
  }
}

// Fungsi berat yang dijalankan di isolate (thread terpisah)
String heavyTask(int seconds) {
  final start = DateTime.now();
  final end = start.add(Duration(seconds: seconds));
  while (DateTime.now().isBefore(end)) {
    // Simulasi perhitungan berat
  }
  return "Selesai dalam $seconds detik (dijalankan di thread background)";
}
