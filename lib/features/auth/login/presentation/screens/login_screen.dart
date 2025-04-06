import 'package:estore_client/features/auth/login/presentation/controllers/auth_bloc.dart';
import 'package:estore_client/features/auth/login/presentation/controllers/auth_event.dart';
import 'package:estore_client/features/auth/login/presentation/controllers/auth_state.dart';
import 'package:estore_client/features/auth/reqistration/presentation/screens/registration_screen.dart';
import 'package:estore_client/features/auth/reqistration/presentation/widgets/CustomTextFormField.dart';
import 'package:estore_client/features/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:estore_client/features/homeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estore_client/features/auth/login/domain/entites/auth_customer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final authCustomer = AuthCustomer(
      phoneNumber: phoneController.text,
      password: passwordController.text,
    );
    context.read<AuthBloc>().add(AuthLoginEvent(authCustomer));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is Authenticated) {
            Future.delayed(Duration(seconds: 1), () {
              context.read<AuthCubit>().emit(true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(S.of(context).Login),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomTextFormField(
                          controller: phoneController,
                          label: S.of(context).PhoneNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).ValidatePhoneMsg;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomTextFormField(
                          controller: passwordController,
                          obscureText: true,
                          label: S.of(context).Password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).ValidatePasswordMsg;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.teal,
                            ),
                          ),
                          onPressed: () => _login(context),
                          child: Text(
                            S.of(context).Login,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).YouDontHaveAnAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).SignUp,
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).ContinueWithoutLogin,
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
