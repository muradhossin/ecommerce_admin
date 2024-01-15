import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/view/auth/services/auth_service.dart';
import 'package:ecommerce_admin/view/dashboard/launcher_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _errMsg = '';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            TextFormField(
              onFieldSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
              autofillHints: const [AutofillHints.email],
              enableSuggestions: true,
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
                  borderSide: BorderSide(color: context.theme.primaryColor.withOpacity(.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
                  borderSide: BorderSide(color: context.theme.primaryColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
                ),
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
                filled: true,
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'This field must not be empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Login as Admin'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _errMsg,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _authenticate() async{
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      try{
        final status = await AuthService.loginAdmin(email, password);
        EasyLoading.dismiss();
        if(status){
          if(mounted){
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        } else{
          await AuthService.logout();
          setState(() {
            _errMsg = 'This email account is not marked as Admin. Please use a valid email address';
          });
        }

      } on FirebaseAuthException catch(error){
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}
