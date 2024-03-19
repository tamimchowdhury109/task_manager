import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                        "Your Email Address",
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                    const SizedBox(height: 10),
                    const Text(
                        "A 6 digit verification pin will send to your email address",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerificationScreen()));
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black54,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            onPressed: (){},
                            child: const Text("have account?")),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                            },
                            child: const Text("Sign in")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
