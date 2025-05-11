import 'package:examen/modelos/user.dart';

class UserService {
  // Instancia única (singleton)
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  // Lista de usuarios registrados localmente
  final List<User> _registeredUsers = [];

  // Usuario actualmente logueado
  User? _currentUser;

  // 🔹 Registro de usuario
  String? register(String email, String password) {
    final userExists = _registeredUsers.any((user) => user.email == email);
    if (userExists) {
      return 'El email ya está registrado';
    }

    _registeredUsers.add(User(email: email, password: password));
    return null;
  }

  // 🔹 Login de usuario
  String? login(String email, String password) {
    final user = _registeredUsers.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(email: '', password: ''),
    );

    if (user.email.isEmpty) {
      return 'Usuario o contraseña incorrectos';
    }

    _currentUser = user;
    return null;
  }

  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  void addProductToCurrentUser(String product) {
    if (_currentUser != null) {
      _currentUser = User(
        email: _currentUser!.email,
        password: _currentUser!.password,
        products: [..._currentUser!.products, product],
      );
    }
  }
}
