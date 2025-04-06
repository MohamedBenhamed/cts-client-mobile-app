import 'package:estore_client/features/auth/login/presentation/screens/login_screen.dart';
import 'package:estore_client/features/auth/reqistration/domain/usecases/add_customer_usecase.dart';
import 'package:estore_client/features/auth/reqistration/presentation/controller/customer_bloc.dart';
import 'package:estore_client/features/auth/reqistration/presentation/controller/customer_event.dart';
import 'package:estore_client/features/auth/reqistration/presentation/controller/customer_states.dart';
import 'package:estore_client/features/auth/reqistration/presentation/widgets/CustomTextFormField.dart';
import 'package:estore_client/features/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/core/di/service_locator.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:estore_client/features/navigationMain/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void _addCustomer(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AddCustomerBloc>().add(
      AddNewCustomer(
        firstNameController.text,
        lastNameController.text,
        passwordController.text,
        phoneNumberController.text,
        '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCustomerBloc(AddNewCustomerUseCase((getIt()))),
      child: BlocConsumer<AddCustomerBloc, AddCustomerState>(
        listener: (context, state) {
          if (state is AddCustomerFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AddCustomerSuccess) {
            Future.delayed(Duration(seconds: 1), () {
              context.read<AuthCubit>().emit(true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavigationMainScreen()),
              );
            });
          }
        },
        builder: (context, state) {
          if (state is AddCustomerLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(S.of(context).Registration),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize:
                          MainAxisSize
                              .min, // Makes column take only necessary space
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Centers the content vertically
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomTextFormField(
                            controller: firstNameController,
                            label: S.of(context).FirstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).ValidateFirstNameMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomTextFormField(
                            controller: lastNameController,
                            label: S.of(context).LastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).ValidateLastNameMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomTextFormField(
                            controller: phoneNumberController,
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
                            label: S.of(context).Password,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).ValidatePasswordMsg;
                              } else if (value.trim().length < 6) {
                                return S
                                    .of(context)
                                    .ValidatePasswordWeaknessMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomTextFormField(
                            controller: passwordConfirmationController,
                            label: S.of(context).PasswordConfirmation,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S
                                    .of(context)
                                    .ValidatePasswordConfirmationMsg;
                              } else if (value != passwordController.text) {
                                return S
                                    .of(context)
                                    .ValidatePasswordConfirmationMatchingMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        BlocConsumer<AddCustomerBloc, AddCustomerState>(
                          listener: (context, state) {
                            if (state is AddCustomerSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  content: Text(
                                    state.message,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else if (state is AddCustomerFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    state.error,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AddCustomerLoading) {
                              return CircularProgressIndicator();
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.teal,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        _addCustomer(context);
                                      }
                                    },
                                    child: Text(
                                      S.of(context).Register,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Divider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).YouAlreadyHaveAnAcount),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        S.of(context).Login,
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
                                            builder:
                                                (context) =>
                                                    NavigationMainScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        S.of(context).ContinueWithoutSignup,
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
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
