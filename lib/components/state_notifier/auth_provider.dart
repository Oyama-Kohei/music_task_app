import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider.autoDispose((ref) => AuthController(ref, read));

class AuthController{
  AuthController(this.read);
  Reader read;
  FirebaseAuth _auth = FirebaseAuth.instance;

}