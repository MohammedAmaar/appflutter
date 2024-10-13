
import 'package:flutter/material.dart';
import 'package:appflutter/Menu.dart';
import 'package:appflutter/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_provider.dart';
import 'chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard/video.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
class MenuItem{
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
});
}
class Dashboard{
  final String title;
  final IconData icon;
  final Color bgcolor;
  final VoidCallback onTap;
  Dashboard({
    required this.title,
    required this.icon,
    required this.bgcolor,
    required this.onTap,
  });
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = "";
  String email ='';
  @override
  void initState(){
    super.initState();
    _loadUsername();
  }
  Future<void> _loadUsername() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? '';
      email = prefs.getString("Email") ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    final List<Dashboard> dashboardData = [
      Dashboard(title: "Courses", icon: Icons.class_, bgcolor: Colors.red, onTap: (){print("course");}),
      Dashboard(title: "Books", icon: Icons.book, bgcolor: Colors.yellow, onTap: (){print("books");}),
      Dashboard(title: "Videos", icon: Icons.play_arrow, bgcolor: Colors.pink, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Videos()));}),
      Dashboard(title: "Home Works", icon: Icons.home_work, bgcolor: Colors.green, onTap: (){print("home work");}),
      Dashboard(title: "Chat", icon: Icons.message, bgcolor: Colors.blue, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
      }),
      Dashboard(title: "Settings", icon: Icons.settings, bgcolor: Colors.black, onTap: (){print("setting");}),

    ];
    final List<MenuItem> menu_data = [
      MenuItem(title: "Setting", icon: Icons.settings, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
      }),
      MenuItem(title: "Account", icon: Icons.account_circle, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
      }),
      MenuItem(title: "Help", icon: Icons.help, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
      }),
      MenuItem(title: "Log Out", icon: Icons.logout, onTap: (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LoginPage()),
              (Route<dynamic> route) => false,
        );
      })

    ];

    return Scaffold(
      appBar: AppBar(

        title: const Text("Home"),
        centerTitle: true,
        actions: [
          // IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){},),
          IconButton(icon: Icon(Icons.search),onPressed: (){},),
          // IconButton(icon: Icon(Icons.menu_book),onPressed: (){},),
        ],
        elevation: 0,
        backgroundColor: Colors.red,
        shadowColor: Colors.black,



      ),

      body: ListView(

        children: [
          Container(
          decoration: const BoxDecoration(

            color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ),
          ),
          child: Padding(
            padding:  const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: Text(_username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,

              ),
              ),
              subtitle: const Text("Welcome Back!",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
              ),),
              trailing: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://th.bing.com/th/id/OIP.FBGLi77e5GKIhHM2p_AAwQAAAA?rs=1&pid=ImgDetMain"
                ),
              ),
            ),
          ),
        ),

          GridView.count(crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: const EdgeInsets.all(20),
          children: [
            ...dashboardData.map((data) => InkWell(
              onTap: data.onTap,
              child: Container(
                decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(offset: Offset(0,5),
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 5
                    )]


                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: data.bgcolor,shape: BoxShape.circle),
                        child: Icon(data.icon,color: Colors.white,)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      data.title,
                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),).toList()


          ],)

        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.close,color: Colors.white,))
                ],
              ),
            ),
            ...menu_data.map((data1) => InkWell(
              onTap: data1.onTap,
              child:  ListTile(
                 leading: Icon(data1.icon),
                 title: Text(data1.title),

               ),
            )).toList()

          ],
        ),
      ),
    );
  }
}


