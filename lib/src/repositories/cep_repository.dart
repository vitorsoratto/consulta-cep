import 'package:consulta_cep/src/models/cep_error_model.dart';
import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:dio/dio.dart';

class CepRepository {
  final dio = Dio();
  final url = 'https://brasilapi.com.br/api/cep/v1';
  late CepModel cepModel;
  CepErrorModel cepError = CepErrorModel();

  Future fetchCep({required String cep}) async {
    try {
      final res = await dio.get('$url/$cep');
      cepModel = CepModel.fromJson(res.data);
    } on DioError catch (e) {
      if (e.response != null) {
        cepError = CepErrorModel.fromJson(e.response?.data);
        throw Exception(cepError.getError());
      } else {
        throw Exception(e.message);
      }
    }

    return cepModel;
  }
}
