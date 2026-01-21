import 'package:dishdash/core/constants/app_config.dart';
import 'package:dishdash/core/network/api_client.dart';
import 'package:dishdash/core/utils/app_logger.dart';
import 'package:dishdash/features/login_sign_up/data/datasources/remote_datasource.dart';
import 'package:dishdash/features/login_sign_up/data/repositories/auth_repository_impl.dart';
import 'package:dishdash/features/login_sign_up/domain/usecases/login_usecase.dart';
import 'package:dishdash/features/login_sign_up/domain/usecases/sign_up_usecase.dart';

import 'auth_bloc.dart';

class AuthBlocFactory {
  const AuthBlocFactory._();

  static AuthBloc create() {
    AppLogger.d('[AuthBlocFactory] Creating AuthBloc');
    final apiClient = ApiClient(baseUrl: AppConfig.apiBaseUrl);
    AppLogger.d(
      '[AuthBlocFactory] ApiClient initialized with baseUrl ${AppConfig.apiBaseUrl}',
    );
    final remoteDatasource = RemoteDatasourceImpl(apiClient: apiClient);
    final repository = AuthRepositoryImpl(remoteDatasource: remoteDatasource);

    return AuthBloc(
      loginUseCase: LoginUseCase(repository),
      signUpUseCase: SignUpUseCase(repository),
    );
  }
}
