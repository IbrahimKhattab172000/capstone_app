import 'package:capstone_app/constants/constants.dart';
import 'package:capstone_app/providers/chats_provider.dart';
import 'package:capstone_app/providers/models_provider.dart';
import 'package:capstone_app/screens/chat_screen.dart';
import 'package:capstone_app/screens/check_screen.dart';
import 'package:capstone_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        home: const MyHomePage(),
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          fontFamily: 'TitilliumWeb',
          appBarTheme: AppBarTheme(
            color: appBarColor,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    Check(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capstone app',
          style: TextStyle(color: white),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appBarColor,
        selectedItemColor: white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle, color: white),
            label: 'Check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble, color: white),
            label: 'AI chat',
          ),
        ],
      ),
    );
  }
}
