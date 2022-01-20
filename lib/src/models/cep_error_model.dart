class CepErrorModel {
  String? name;
  String? message;
  String? type;
  List<Errors>? errors;

  CepErrorModel({this.name, this.message, this.type, this.errors});

  CepErrorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    type = json['type'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['message'] = message;
    data['type'] = type;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  getError() {
    return errors?[0].message;
  }
}

class Errors {
  String? name;
  String? message;
  String? service;

  Errors({this.name, this.message, this.service});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['message'] = message;
    data['service'] = service;
    return data;
  }
}
