// ignore_for_file: use_rethrow_when_possible, unused_local_variable

import 'package:dio/dio.dart';
import 'package:lista_de_contatos/model/lista_contato_model.dart';

class ContatoRepository {
  Future<ListaContatosModel> obterContatos() async {
    var dio = Dio();

    dio.options.headers["Content-Type"] = "application/json";
    dio.options.baseUrl = " https://parseapi.back4app.com/classes";
    dio.options.headers["X-Parse-Application-Id"] =
        "MRftJNLxl29sqZEFOaVgjT3acvtgTF9jGpbST7za";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "GvWNnwFYAsWi8ClVDK2QUAdJoSreandnZbQz5oy5";
    var result = await dio
        .get('https://parseapi.back4app.com/classes/MyCustomClassName');

    return ListaContatosModel.fromJson(result.data);
  }

  Future<void> addContato(ContatoModel contatoModel) async {
    var dio = Dio();

    dio.options.headers["Content-Type"] = "application/json";
    dio.options.baseUrl = " https://parseapi.back4app.com/classes";
    dio.options.headers["X-Parse-Application-Id"] =
        "MRftJNLxl29sqZEFOaVgjT3acvtgTF9jGpbST7za";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "GvWNnwFYAsWi8ClVDK2QUAdJoSreandnZbQz5oy5";
    try {
      var response = await dio.post("/MyCustomClassName",
          data: contatoModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeContato(String objectId) async {
    var dio = Dio();

    dio.options.headers["Content-Type"] = "application/json";
    dio.options.baseUrl = " https://parseapi.back4app.com/classes";
    dio.options.headers["X-Parse-Application-Id"] =
        "MRftJNLxl29sqZEFOaVgjT3acvtgTF9jGpbST7za";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "GvWNnwFYAsWi8ClVDK2QUAdJoSreandnZbQz5oy5";
    try {
      var response = await dio.delete("/MyCustomClassName/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
