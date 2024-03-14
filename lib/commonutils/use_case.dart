import 'package:chat_app/data/models/Result.dart';

abstract interface class UseCase<Params>{
  Future<Result> call(Params params);
}