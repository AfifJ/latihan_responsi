import 'package:flutter/material.dart';
import 'package:latihan_responsi/screens/home_page.dart';
import 'package:latihan_responsi/screens/register_page.dart';
import 'package:latihan_responsi/services/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    Future<void> _login() async {
      try {
        bool isExists = await DatabaseHelper.instance
            .checkUsernameExists(_usernameController.text);

        if (!isExists) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Username ini belum terdaftar")));
          return;
        }

        await DatabaseHelper.instance
            .loginUser(_usernameController.text, _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Berhasil login dengan " + _usernameController.text)));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Gagal login, username atau password salah")));
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Username')),
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(label: Text('Password')),
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    onPressed: _login,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? '),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterPage();
                          }));
                        },
                        child: Text("Register"))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
