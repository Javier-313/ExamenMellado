import 'package:flutter/material.dart';
import 'package:examen/helpers/validators.dart';
import 'package:examen/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserService _userService = UserService(); // Servicio local de usuarios

  void _register() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      String? result = _userService.register(email, password);

      if (result == null) {
        // Registro exitoso -> Volver a Login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso.')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Error en registro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  void _goBackToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 16),

              // Campo de Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 24),

              // Botón Registrarse
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrarse'),
              ),
              SizedBox(height: 16),

              // Botón para volver a Login
              TextButton(
                onPressed: _goBackToLogin,
                child: Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
