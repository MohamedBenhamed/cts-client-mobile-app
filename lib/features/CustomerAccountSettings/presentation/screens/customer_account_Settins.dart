import 'package:estore_client/features/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_bloc.dart';
import 'package:estore_client/features/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_events.dart';
import 'package:estore_client/features/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_states.dart';
import 'package:estore_client/features/appSettings/presentation/screens/appSettings.dart';
import 'package:estore_client/features/auth/login/presentation/screens/login_screen.dart';
import 'package:estore_client/features/auth/reqistration/presentation/widgets/CustomTextFormField.dart';
import 'package:estore_client/features/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerAccountSettins extends StatelessWidget {
  const CustomerAccountSettins({super.key});

  @override
  Widget build(BuildContext context) {
    // Triggering the fetch when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerBloc>().add(FetchCustomerInfo());
    });

    return Scaffold(
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CustomerLoaded) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  // Profile Header Card
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.teal,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white, // Background color
                          child: Text(
                            getInitials(
                              "${state.customer.firstName} ${state.customer.lastName}",
                            ), // Function to get initials
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal, // Text color
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.customer.firstName} ${state.customer.lastName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                state.customer.phoneNumber,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu List
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(S.of(context).Account.toUpperCase()),
                        ),
                        ProfileMenuItem(
                          icon: Icons.person_outline,
                          text: S.of(context).PersonalInformation.toUpperCase(),
                          onTap: () {
                            personalInformationBottomSheet(
                              context,
                              state.customer.firstName,
                              state.customer.lastName,
                            );
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.location_on_outlined,
                          text: S.of(context).MyAddresses.toUpperCase(),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(S.of(context).Settings.toUpperCase()),
                        ),
                        ProfileMenuItem(
                          icon: Icons.security_outlined,
                          text: S.of(context).AccessAndSecurity.toUpperCase(),
                          onTap: () {
                            accessAndSecurityBottomSheet(
                              context,
                              state.customer.phoneNumber,
                            );
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.display_settings_outlined,
                          text:
                              S
                                  .of(context)
                                  .LanguageAndDisplaySettings
                                  .toUpperCase(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppSettingsScreen(),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(S.of(context).AboutUs.toUpperCase()),
                        ),
                        ProfileMenuItem(
                          icon: Icons.rule_outlined,
                          text: S.of(context).TermsAndConditions.toUpperCase(),
                        ),
                        ProfileMenuItem(
                          icon: Icons.help_outline,
                          text: S.of(context).AboutTheApp.toUpperCase(),
                        ),
                        ProfileMenuItem(
                          icon: Icons.star_outline,
                          text: S.of(context).RateUs.toUpperCase(),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).Logout.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.logout_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CustomerError) {
            return Center(child: Text(state.message));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<CustomerBloc>().add(FetchCustomerInfo());
              },
              child: Text("Fetch Customer Info"),
            ),
          );
        },
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

String getInitials(String name) {
  List<String> nameParts = name.split(" ");
  String initials = "";

  if (nameParts.isNotEmpty) {
    initials += nameParts[0][0]; // First letter of first name
  }
  if (nameParts.length > 1) {
    initials += nameParts[1][0]; // First letter of last name
  }

  return initials.toUpperCase(); // Ensure uppercase letters
}

void personalInformationBottomSheet(
  BuildContext context,
  String firstName,
  String lastName,
) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController(
    text: firstName,
  );
  final TextEditingController lastNameController = TextEditingController(
    text: lastName,
  );
  final TextEditingController emailController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    S.of(context).PersonalInformation,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: firstNameController,
                    label: S.of(context).FirstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).FirstName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: lastNameController,
                    label: S.of(context).LastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).LastName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: emailController,
                    label: S.of(context).Email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).ValidateEmailMsg;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.teal),
                      ),
                      child: Text(
                        S.of(context).Save,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void accessAndSecurityBottomSheet(BuildContext context, String firstName) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController(
    text: firstName,
  );
  final TextEditingController passwordController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    S.of(context).AccessAndSecurity,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    label: S.of(context).PhoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).PhoneNumber;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: passwordController,
                    label: S.of(context).OldPassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).Password;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: passwordController,
                    label: S.of(context).NewPassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).Password;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.teal),
                      ),
                      child: Text(
                        S.of(context).Save,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                      ),
                      child: Text(
                        S.of(context).DeleteAccount,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
