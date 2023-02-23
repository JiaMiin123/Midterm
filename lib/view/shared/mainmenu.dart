import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midterm_homestayraya/serverconfig.dart';
import 'package:midterm_homestayraya/view/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user.dart';
import '../screens/mainscreen.dart';
import '../screens/registrationscreen.dart';
import '../screens/sellerscreen.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  const MainMenuWidget({super.key, required this.user});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(widget.user.email.toString()),
            accountName: Text(widget.user.name.toString()),
            currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  imageUrl:
                      "${ServerConfig.server}/assets/profileimages/${widget.user.id}.png",
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported,
                    size: 128,
                  ),
                )),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person_rounded),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (content) => ProfileScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Add New Homestay'),
            leading: const Icon(Icons.home_work_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => SellerScreen(user: widget.user)));
            },
          ),
          const Expanded(
              child: SizedBox(
            height: 30,
          )),
          const Expanded(
              child: SizedBox(
            height: 90,
          )),
          const Divider(
            height: 25,
            thickness: 2,
          ),
          ListTile(
            title: const Text('Sign In'),
            leading: const Icon(Icons.login_rounded),
            onTap: () {
              if (widget.user.id == "0") {
                return _haveaccount();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              user: widget.user,
                            )));
                Fluttertoast.showToast(
                    msg: "Please log out your account first.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 14.0);
              }
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout_rounded),
            onTap: _logoutDialog,
          ),
          const ListTile(
            title: Text('Help and Feedback'),
            leading: Icon(Icons.help),
          ),
        ],
      ),
    );
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Sign Out?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', '');
                await prefs.setString('pass', '');
                await prefs.setBool('remember', true);
                User userunregistered = User(
                  id: "0",
                  email: "Guest123@email.com",
                  name: "Guest",
                  // address: "na",
                  phone: "0123456789",
                  // regdate: "0",
                  // credit: '0'
                );
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>
                            MainScreen(user: userunregistered)));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _haveaccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Sign In",
            style: TextStyle(),
          ),
          content: const Text("Do you have an account?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
                onPressed: _yesButton,
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                )),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const RegistrationScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  void _yesButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginScreen()));
    Fluttertoast.showToast(
        msg: "You may log in to your account here",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);
  }
}
