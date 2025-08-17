import 'package:estore_client/features/CustomerAccountSettings/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:estore_client/features/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_bloc.dart';
import 'package:estore_client/features/auth/login/data/datasource/auth_local_data_source.dart';
import 'package:estore_client/features/auth/login/domain/usecases/auth_customer_usecase.dart';
import 'package:estore_client/features/auth/login/presentation/controllers/auth_bloc.dart';
import 'package:estore_client/features/auth/login/presentation/controllers/auth_event.dart';
import 'package:estore_client/features/auth/shared/authCheck/authCubit.dart';
import 'package:estore_client/core/di/service_locator.dart';
import 'package:estore_client/features/appSettings/presentation/controllers/settingsCubit.dart';
import 'package:estore_client/core/utils/themes/theme.dart';
import 'package:estore_client/features/home/presentation/controllers/productsController/get_home_products_bloc.dart';
import 'package:estore_client/features/home/presentation/controllers/productsController/get_home_products_events.dart';
import 'package:estore_client/features/search/domain/usecases/get_all_products_usecase.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_bloc.dart';
import 'package:estore_client/features/search/presentation/controllers/productsController/get_all_products_events.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:estore_client/features/navigationMain/HomeScreen.dart';
import 'package:estore_client/features/home/domain/usecases/get_all_subcategories_usecase.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_bloc.dart';
import 'package:estore_client/features/home/presentation/controllers/categoriesController/get_all_subcategories_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().addUserServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(
          create:
              (context) => AuthBloc(
                getIt<AuthCustomerUsecase>(),
                getIt<BaseAuthLocalDataSource>(),
              )..add(AuthCheckStatusEvent()),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create:
              (context) => CustomerBloc(
                getCustomerInfo: getIt<GetCustomerInfoByIdUseCase>(),
                authLocalDataSource: getIt<BaseAuthLocalDataSource>(),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  SubcategoryBloc(getIt<GetAllSubCategoriesUseCase>())
                    ..add(LoadSubcategories()),
        ),
        BlocProvider(
          create:
              (context) =>
                  ProductsBloc(getIt<GetAllProductsUsecase>())
                    ..add(LoadProducts()),
        ),
        BlocProvider(
          create:
              (context) =>
                  HomeProductsBloc(getIt<GetAllProductsUsecase>())
                    ..add(LoadHomeProducts()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp(
                locale: Locale(state.languageCode),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: TAppTheme.lightTheme,
                darkTheme: TAppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                //home: CartScreen(),
                home: NavigationMainScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
