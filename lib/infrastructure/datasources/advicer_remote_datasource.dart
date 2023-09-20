import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/infrastructure/exceptions/exceptions.dart';
import 'package:api_name/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///Requests random advice from free Api
///thows a server-Exception if code ist not 200
abstract class AdvicerRemoteDatasource {
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDatasource {
  final http.Client client;

  AdvicerRemoteDatasourceImpl({required this.client});

  @override
  //* API request from INFRASTRUCTURE/remoteDataSource
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {
        'ContentType': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}
