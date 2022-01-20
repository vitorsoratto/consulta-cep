class CepModel {
  late final String cep;
  String? state;
  late final String city;
  String? neighborhood;
  String? street;
  String? service;
  String? error;

  CepModel(
      {required this.cep,
      this.state,
      required this.city,
      this.neighborhood,
      this.street,
      this.service,
      this.error});

  CepModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
    service = json['service'];
    error = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cep'] = cep;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['street'] = street;
    data['service'] = service;
    data['error'] = error;
    return data;
  }
}

class Veiculo {
  String? cor;
  String? nome;

  acelerar() {
    print('aceleando com as roda');
  }
}

class Carro extends Veiculo {

  @override
  acelerar() {
    return super.acelerar();
  } 
}
