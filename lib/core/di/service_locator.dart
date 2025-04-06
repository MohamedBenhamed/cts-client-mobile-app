import 'package:estore_client/features/CustomerAccountSettings/data/datasource/get_customer_info_by_id_remote_datasource.dart';
import 'package:estore_client/features/CustomerAccountSettings/data/repositories/get_customer_info_by_id_repository.dart';
import 'package:estore_client/features/CustomerAccountSettings/domain/repositories/get_customer_info_by_id_base_repository.dart';
import 'package:estore_client/features/CustomerAccountSettings/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:estore_client/features/auth/reqistration/data/datasource/add_customer_remote_data_source.dart';
import 'package:estore_client/features/auth/reqistration/data/repositories/add_user_repository.dart';
import 'package:estore_client/features/auth/reqistration/domain/repositories/add_customer_base_repository.dart';
import 'package:estore_client/features/auth/reqistration/domain/usecases/add_customer_usecase.dart';
import 'package:estore_client/features/auth/login/data/datasource/auth_local_data_source.dart';
import 'package:estore_client/features/auth/login/data/datasource/auth_remote_data_source.dart';
import 'package:estore_client/features/auth/login/data/repositories/auth_customer_repository.dart';
import 'package:estore_client/features/auth/login/domain/repositories/auth_customer_base_repository.dart';
import 'package:estore_client/features/auth/login/domain/usecases/auth_customer_usecase.dart';
import 'package:estore_client/core/network/dio_client.dart';
import 'package:estore_client/features/storeMain/data/datasource/get_all_subcategories_remote_datasource.dart';
import 'package:estore_client/features/storeMain/data/repositories/get_all_subcategories_repository.dart';
import 'package:estore_client/features/storeMain/domain/repositories/get_all_subcategories_base_repository.dart';
import 'package:estore_client/features/storeMain/domain/usecases/get_all_subcategories_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> addUserServiceLocator() async {
    // 🔹 Initialize SharedPreferences before registration
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    // 🔹 Register DioClient
    getIt.registerLazySingleton<DioClient>(() => DioClient());

    // 🔹 Register Auth Remote Data Source
    getIt.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
    );

    // 🔹 Register Auth Local Data Source with SharedPreferences
    getIt.registerLazySingleton<BaseAuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
    );

    // 🔹 Register Auth Repository
    getIt.registerLazySingleton<BaseAuthCustomerRepository>(
      () => AuthCustomerRepository(
        getIt<BaseAuthRemoteDataSource>(),
        getIt<BaseAuthLocalDataSource>(),
      ),
    );

    // 🔹 Register Auth Use Case
    getIt.registerLazySingleton<AuthCustomerUsecase>(
      () => AuthCustomerUsecase(getIt<BaseAuthCustomerRepository>()),
    );

    // 🔹 Register Add Customer Remote Data Source
    getIt.registerLazySingleton<BaseAddCustomerRemoteDataSource>(
      () => AddCustomerRemoteDataSource(getIt<DioClient>()),
    );

    // 🔹 Register Add Customer Repository
    getIt.registerLazySingleton<BaseAddCustomerRepository>(
      () => AddCustomerRepository(getIt<BaseAddCustomerRemoteDataSource>()),
    );

    // 🔹 Register Add Customer Use Case
    getIt.registerLazySingleton<AddNewCustomerUseCase>(
      () => AddNewCustomerUseCase(getIt<BaseAddCustomerRepository>()),
    );

    // 🔹 Register Customer Remote Data Source
    getIt.registerLazySingleton<BaseCustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
    );

    // 🔹 Register Customer Repository
    getIt.registerLazySingleton<GetCustomerInfoByIdBaseRepository>(
      () =>
          GetCustomerInfoByIdRepository(getIt<BaseCustomerRemoteDataSource>()),
    );

    // 🔹 Register GetCustomerInfoByIdUseCase
    getIt.registerLazySingleton<GetCustomerInfoByIdUseCase>(
      () => GetCustomerInfoByIdUseCase(
        getIt<GetCustomerInfoByIdBaseRepository>(),
      ),
    );

    getIt.registerLazySingleton<BaseGetAllSubCategoriesRemoteDataSource>(
      () => GetAllSubCategoriesRemoteDataSource(dioClient: getIt<DioClient>()),
    );

    getIt.registerLazySingleton<GetAllCategoriesBaseRepository>(
      () => GetAllSubcategoriesRepository(
        getIt<BaseGetAllSubCategoriesRemoteDataSource>(),
      ),
    );

    // 🔹 Register GetAllSubCategories Use Case
    getIt.registerLazySingleton<GetAllSubCategoriesUseCase>(
      () => GetAllSubCategoriesUseCase(getIt<GetAllCategoriesBaseRepository>()),
    );
  }
}
