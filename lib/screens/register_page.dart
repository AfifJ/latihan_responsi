import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/user.dart';
import 'package:latihan_responsi/screens/login_page.dart';
import 'package:latihan_responsi/services/database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future<void> _register() async {
      if (_formKey.currentState!.validate()) {
        try {
          final isExists = await DatabaseHelper.instance
              .checkUsernameExists(_usernameController.text);
          if (isExists) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Username ini sudah terdaftar, silahkan gunakan username lain")));
            return;
          }

          final newUser = User(
              username: _usernameController.text,
              password: _passwordController.text);

          await DatabaseHelper.instance.registerUser(newUser);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Registrasi berhasil')));

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Register",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(label: Text("Username")),
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
                decoration: InputDecoration(label: Text("Password")),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(label: Text("Konfirmasi password")),
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password tidak boleh kosong';
                  }

                  if (value != _passwordController.text) {
                    return 'Konfirmasi password dan password tidak sesuai';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: MaterialButton(
                  onPressed: _register,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Register"),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
