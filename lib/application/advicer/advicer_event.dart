part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerEvent {}

/// Event when button ist pressed
class AdviceRequestedEvent extends AdvicerEvent {}

//* Only to show the binding in the new Bloc syntax
class ExapleEvent extends AdvicerEvent {}
