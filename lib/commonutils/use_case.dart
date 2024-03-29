import 'package:chat_app/commonutils/Result.dart';

abstract interface class UseCase<Params>{
  Future<Result> call(Params params);
}