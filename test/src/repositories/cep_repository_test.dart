import 'package:consulta_cep/src/repositories/cep_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final repository = CepRepository();

  test('Trazer um cep', () async {
    final cep = await repository.fetchCep(cep: '88811780');

    expect(cep, isNotNull);
  });

  test('Utilizando o cep: 88811780 trazer a cidade de Criciúma', () async {
    final cep = await repository.fetchCep(cep: '88811780');

    expect(cep.city, 'Criciúma');
  });
}
