import 'package:get_it/get_it.dart';
import 'package:stasks/src/repository/task_repository.dart';
import 'package:stasks/src/repository/task_repository_impl.dart';
import 'package:stasks/src/use_case/task_use_case.dart';

final getIt = GetIt.instance;

void initServiceLocator(){
  getIt.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  getIt.registerSingleton<TaskUseCase>(TaskUseCase());
}
