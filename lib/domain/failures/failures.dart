import 'package:equatable/equatable.dart';

abstract class Failure {}

//* extention for testing
class ServerFailures extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GeneralFailures extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
