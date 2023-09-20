import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel(String advice, int id)
      : super(
          advice: advice,
          id: id,
        );

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      json["advice"],
      json["id"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [advice, id];
}
