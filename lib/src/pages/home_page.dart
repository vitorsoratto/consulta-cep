import 'package:consulta_cep/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  final TextEditingController cepText = TextEditingController();

  bool _validate = false;

  _success() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.cep.city),
                    subtitle: Text(
                        '${controller.cep.neighborhood}, ${controller.cep.street} - ${controller.cep.cep}'),
                  );
                }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  cepText.text = '';
                  controller.state.value = HomeState.start;
                },
                child: const Text('Nova Consulta'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _error() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
              '${controller.cep.error?.replaceAll('Exception: ', '')} (${controller.cep.cep}) '),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              cepText.text = '';
              controller.state.value = HomeState.start;
            },
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // final TextEditingController controller;

  _start() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Digite o CEP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                keyboardType: TextInputType.number,
                controller: controller.cepText,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText: _validate ? 'CEP inválido' : null)),
          ),
          ElevatedButton(
              onPressed: () async {
                var _validCharacters = RegExp(r'^[0-9]+$');
                String _cep = controller.cepText.text;
                setState(() {
                  _cep.isEmpty || !_validCharacters.hasMatch(_cep)
                      ? _validate = true
                      : _validate = false;
                });
                if (!_validate) await controller.findCep();
              },
              child: Text('Buscar'))
        ],
      ),
    );
  }

  manageState(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.error:
        return _error();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = HomeController(cepText: cepText);
    controller.state.value = HomeState.start;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP'),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return manageState(controller.state.value);
          // return manageState(HomeState.start);
        },
      ),
    );
  }
}
