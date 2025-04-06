import 'package:estore_client/features/homeScreen/widgets/bottomAppBarWidget.dart';
import 'package:estore_client/features/homeScreen/widgets/drawerItemWidget.dart';
import 'package:estore_client/features/storeMain/presentation/screens/StoreMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estore_client/features/appSettings/presentation/screens/appSettings.dart';
import 'package:estore_client/features/auth/login/presentation/screens/login_screen.dart';
import 'package:estore_client/features/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/features/CustomerAccountSettings/presentation/screens/customer_account_Settins.dart';
import 'package:estore_client/features/storeMain/presentation/widgets/loginDialog.dart';
import '../../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDrawerOpen = false;
  int _screenIndex = 0;

  String getAppTitle(BuildContext context) {
    switch (_screenIndex) {
      case 0:
        return S.of(context).Home;
      case 1:
        return S.of(context).Search;
      case 2:
        return S.of(context).Cart;
      case 3:
        return S.of(context).Orders;
      case 4:
        return S.of(context).Account;
      default:
        return S.of(context).AppTitle;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authCubit = context.read<AuthCubit>();
      final isLoggedIn = authCubit.state;

      if (isLoggedIn == null) {
        // Show loading state or wait for state to be determined
        bool isLogin = await authCubit.checkAuthStatus();
        if (isLogin == false) {
          logInDialog(context);
        }
      }
    });
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    StoreMainScreen(), // Home screen
    StoreMainScreen(), // Search screen
    StoreMainScreen(), // Orders screen
    StoreMainScreen(), // Orders screen
    CustomerAccountSettins(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey.shade900,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      S.of(context).Menu,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  drawerItem(Icons.home, S.of(context).Home, () {
                    Navigator.pop(context);
                  }),
                  drawerItem(Icons.shopping_cart, S.of(context).Orders, () {}),
                  drawerItem(Icons.settings, S.of(context).Settings, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppSettingsScreen(),
                      ),
                    );
                  }),
                  Spacer(),
                  BlocBuilder<AuthCubit, bool?>(
                    builder: (context, isLoggedIn) {
                      if (isLoggedIn == null) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return isLoggedIn
                          ? drawerItem(
                            Icons.logout,
                            S.of(context).Logout,
                            () {
                              context.read<AuthCubit>().logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            color: Colors.redAccent,
                          )
                          : drawerItem(Icons.login, S.of(context).Login, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }, color: Colors.teal);
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
          // Main Screen
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              bool isRTL = Directionality.of(context) == TextDirection.rtl;
              double slide =
                  isRTL ? -120 * _controller.value : 190 * _controller.value;
              double scale = 1 - (0.2 * _controller.value);

              return Transform(
                transform:
                    Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                child: GestureDetector(
                  onTap: isDrawerOpen ? toggleDrawer : null,
                  child: AbsorbPointer(
                    absorbing: isDrawerOpen,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: Text(
                          getAppTitle(context), // Dynamic title
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        leading: IconButton(
                          icon: Icon(
                            color: Theme.of(context).primaryColor,
                            isDrawerOpen ? Icons.arrow_back : Icons.menu,
                          ),
                          onPressed: toggleDrawer,
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      body: IndexedStack(
                        index: _screenIndex,
                        children: _screens,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar:
          isDrawerOpen
              ? SizedBox.shrink() // Hide bottom nav bar when drawer is open
              : bottomAppBar(context, _screenIndex, _onItemTapped),
    );
  }
}
