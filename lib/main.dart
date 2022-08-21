import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyAppp(),
  ));
}


class MyAppp extends StatelessWidget {
  const MyAppp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(
          width: double.infinity,
          height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: <Color>[
              Colors.blueGrey,
              Colors.white,
              Colors.grey,
            ],
          ),
        ),
        child:Column(
        children: [

          SafeArea(
          child:Container(

            child: Lottie.network('https://assets1.lottiefiles.com/private_files/lf30_Si1jIk.json'),

          ),
          ),
          Divider(),

          RaisedButton(
            padding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 250,
              height: 50,
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blue,
                    Colors.white,
                  ],
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
          ),
          SizedBox(height:25),
          RaisedButton(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 250,
              height: 50,
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blue,
                    Colors.white,
                  ],
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
    ),
    );
  }
}
/*==============================*/

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SafeArea(
        child:Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.white12,
                Colors.grey,
              ],
            ),
          ),
        child: Column(
          children: [
            SizedBox(height:150),
            SignInButtonBuilder(
              text: 'Get going with Email',
              icon: Icons.email,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                );
              },
              backgroundColor: Colors.blueGrey[700]!,
              width: 220.0,
            ),
            Divider(),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () {

              },
            ),
            Divider(),
            SignInButton(
              Buttons.FacebookNew,
              onPressed: () {

              },
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Go back!'),
            ),
          ],

        ),
        ),
      ),
      ),
    );
  }
}
/*=============================================================================*/
class User {
  Data? data;

  User({this.data});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? displayName;
  String? email;
  String? password;
  String? conformPassword;
  int? iV;

  Data(
      {this.sId,
        this.displayName,
        this.email,
        this.password,
        this.conformPassword,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    email = json['email'];
    password = json['password'];
    conformPassword = json['ConformPassword'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['ConformPassword'] = this.conformPassword;
    data['__v'] = this.iV;
    return data;
  }
}




class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);
  static const String _title = 'PdfPro';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const ThirdRouteWidget(),
      ),
    );
  }
}

class ThirdRouteWidget extends StatefulWidget {
  const ThirdRouteWidget({Key? key}) : super(key: key);
  @override
  State<ThirdRouteWidget> createState() => _ThirdRouteWidgetState();
}

class _ThirdRouteWidgetState extends State<ThirdRouteWidget> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String _email ="";
  Future<String?> postt() async {

    try {
      //String con = email as String;
      String url="https://arcane-plateau-36387.herokuapp.com/"+email.text;
      print(url);
      final response = await http.get(Uri.parse(url));
      String responseData = utf8.decode(response.bodyBytes);
      print(json.decode(responseData));
      User user = User.fromJson(json.decode(responseData));
      String? name =user.data?.email ;
      print(name);
      setState(() => _email = name!);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(email.text);
                    print(password.text);
                     postt();
                   if (_email == email.text) {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const MyHomePage()),
                     );
                   }
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}

/*========================================================================*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'PdfPro';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>   {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void postt() async {

    try {
      var map = new Map<String, dynamic>();
      map['displayName'] = name.text;
      map['email'] = email.text;
      map['password'] = password.text;
      map['conformpassword'] = conformpassword.text;

       final response = await http.post(
        Uri.parse('https://arcane-plateau-36387.herokuapp.com/blog'),
        body: map,
      );

    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
        child:ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    controller: name;
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    controller: email;
                    return 'Please enter your email';
                  }
                  return null;
                },

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    controller: password;
                    return 'Please enter your name';
                  }
                  return null;
                },
                obscureText: true,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    controller: conformpassword;
                    return 'Please reenter your password';
                  }
                  return null;
                },
                controller: conformpassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Conform Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('SignUp'),
                  onPressed: () {
                    print(name.text);
                    print(email.text);
                    print(password.text);
                    print(conformpassword.text);
                    postt();
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {

                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        )
    )
    );





  }
}

/*======================================================================================*/

/*===================================================================================================*/
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Option')),
      body:RaisedButton(
        padding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 250,
          height: 50,
          child: Center(
            child: Text(
              'Img To Pdf',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.blue,
                Colors.white,
              ],
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const kumar()),
          );
        },
      ),
        drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Karthik Kumar"),
              accountEmail: Text("gopikumarreddy.38@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "G",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts), title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}



class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Merge Pdf', icon: Icons.merge),
  const Choice(title: 'Compress Pdf', icon: Icons.compress),
  const Choice(title: 'Map', icon: Icons.add),

];

class SelectCard extends StatelessWidget {
  const SelectCard({ Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {


    return Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0)),
              Text(choice.title),
            ]
        ),
        )
    );
  }
}
/*=====================================================================================*/
class kumar extends StatefulWidget {
  const kumar({Key? key}) : super(key: key);

  @override
  State<kumar> createState() => _kumarState();
}

class _kumarState extends State<kumar> {
  final picker =ImagePicker();
  final pdf = pw.Document();
  var image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('img to pdf'),
        actions:[
          IconButton(onPressed: (){
            createPDF();
            savePDF();
          }, icon: Icon(Icons.picture_as_pdf))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:getImageFromGallery,
      ),
      body: image != null?Container(
        height:400,
        width:double.infinity,
        margin: EdgeInsets.all(0),
        child:Image.file(image,fit:BoxFit.cover,),

      ):Container(

      ),

    );


  }
  getImageFromGallery() async{

      final pickedFile = await picker.getImage(source: ImageSource.gallery);
       setState(() {
         if (pickedFile!= null){
           image = File(pickedFile.path);
         }
         else{
           print('no image is selected');
         }
       });
  }
  createPDF() async{
    final imag = pw.MemoryImage(image.readAsBytesSync());
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(imag),
      ); // Center
    }));
  }

 savePDF() async{
  try {
    final dir =await getApplicationDocumentsDirectory();
    final file = File(dir.path);
    await file.writeAsBytes(await pdf.save());

  }catch(e) {
  }
  }
}


