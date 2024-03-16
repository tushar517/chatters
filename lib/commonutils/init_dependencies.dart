import 'package:chat_app/data/Auth_remote_data_source.dart';
import 'package:chat_app/data/List_remote_data_source.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';
import 'package:chat_app/domain/repository/Impl/AuthRepositoryImpl.dart';
import 'package:chat_app/domain/repository/Impl/ListRepositoryImpl.dart';
import 'package:chat_app/domain/repository/ListRepository.dart';
import 'package:chat_app/domain/usecases/chat_list.dart';
import 'package:chat_app/domain/usecases/login.dart';
import 'package:chat_app/domain/usecases/sign_up.dart';
import 'package:chat_app/domain/usecases/user_list.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/presentation/bloc/signup/sign_up_bloc.dart';
import 'package:chat_app/presentation/bloc/userList/user_list_bloc.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

Future<void> initDependencies() async{
  getItInstance.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  getItInstance.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getItInstance()));
  getItInstance.registerFactory(() => SignUp(getItInstance()));
  getItInstance.registerLazySingleton(() => SignUpBloc(signUpUseCase: getItInstance()));

  getItInstance.registerFactory(() => LoginUseCase(getItInstance()));
  getItInstance.registerLazySingleton(() => LoginBloc(loginUseCase: getItInstance()));


  getItInstance.registerFactory<ListRemoteDataSourceRepository>(() => ListRemoteDataSourceImpl());
  getItInstance.registerFactory<ListRepository>(() => ListRepositoryImpl(getItInstance()));
  getItInstance.registerFactory(() => UserListUseCase(getItInstance()));
  getItInstance.registerLazySingleton(() => UserListBloc(userListUseCase: getItInstance()));

  getItInstance.registerFactory(() => ChatListUseCase(getItInstance()));
  getItInstance.registerLazySingleton(() => ChatBloc(chatListUseCase: getItInstance()));

}