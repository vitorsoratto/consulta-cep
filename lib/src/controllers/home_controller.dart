import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:consulta_cep/src/repositories/cep_repository.dart';
import 'package:flutter/widgets.dart';

class HomeController {
  late CepModel cep;
  final repository = CepRepository();

  final state = ValueNotifier<HomeState>(HomeState.start);

  final TextEditingController cepText;

  HomeController({required this.cepText});

  newSearch() {}

  Future findCep() async {
    String cep = cepText.text;

    state.value = HomeState.loading;
    try {
      this.cep = await repository.fetchCep(cep: cep);
      state.value = HomeState.success;
    } catch (e) {
      // this.cep = CepModel(cep: cep, city: '', error: e.toString());
      this.cep = CepModel(cep: cep, city: '', error: e.toString());
      state.value = HomeState.error;
    }
  }

  Future find({required String cep}) async {
    state.value = HomeState.loading;
    try {
      this.cep = await repository.fetchCep(cep: cep);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
