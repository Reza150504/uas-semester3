import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tdbdceqvedilsecstwgv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkYmRjZXF2ZWRpbHNlY3N0d2d2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUyNzk4MzgsImV4cCI6MjAyMDg1NTgzOH0.ycbYA5jhyU1EUvy1eFoso4UCKRsxHGDu21VjhY9V8QA',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pendaftaran',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('pendaftaran').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final pendaftaran = snapshot.data!;
          return ListView.builder(
            itemCount: pendaftaran.length,
            itemBuilder: ((context, index) {
              final pendaftaran = pendaftaran[index];
              return ListTile(
                title: Text(pendaftaran['name']),
                subtitle:
                    Text(pendaftaran['Asal Sekolah'] - pendaftaran['Alamat']),
              );
            }),
          );
        },
      ),
    );
  }
}
