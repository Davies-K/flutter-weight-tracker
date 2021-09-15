import 'package:plendify/Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:plendify/values/values.dart';
import 'package:plendify/widgets/primary_block_button.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Handling signup and signin
  bool signUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login",
            style:
                AppTextStyles.titleStyle.copyWith(color: AppColors.whiteColor)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Sign In Anonymously
            PrimaryBlockButton(
              onButtonTap: () {
                context.read<AuthenticationProvider>().signInAnonymously();
              },
              title: 'Continue Anonymously',
            )
            //Sign in / Sign up button
          ],
        ),
      ),
    );
  }
}
