import 'package:flutter/material.dart';
import 'package:r_integration/features/rwasm/ui/screens/rwasm.dart';
import 'package:r_integration/features/rwasm/ui/screens/rwasm_local.dart';
import 'features/rwasm/server/rwasm_local_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startLocalServer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // add button to navigate to RIntegrationPage
  void _navigateToRIntegrationPage() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const RIntegrationPage();
      },
    ));
  }

  void _navigateToRIntegrationLocalPage() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const RIntegrationLocalPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // button for navigating to RIntegrationPage
            ElevatedButton(
              onPressed: _navigateToRIntegrationPage,
              child: const Text('Navigate to R-wasm Integration Page'),
            ),
            ElevatedButton(
              onPressed: _navigateToRIntegrationLocalPage,
              child: const Text('Navigate to Local Integration Page'),
            ),
          ],
        ),
      ),
      // Removed the floating action button
    );
  }
}
