// ignore_for_file: unnecessary_null_comparison, must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/model/lista_contato_model.dart';
import 'package:lista_de_contatos/repository/contato_repository.dart';

class AddContato extends StatefulWidget {
  AddContato(this.contatoRepository, {super.key});

  ContatoRepository contatoRepository;

  @override
  State<AddContato> createState() => _AddContatoState();
}

class _AddContatoState extends State<AddContato> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController numeroController = TextEditingController();

    XFile? photo;

    cropImage(XFile imageFile) async {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        await GallerySaver.saveImage(croppedFile.path);
        setState(() {});
        photo = XFile(croppedFile.path);
        print(photo);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar Contato"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text("Digite o Nome:"),
                TextField(
                  maxLength: 24,
                  controller: nomeController,
                ),
                const SizedBox(height: 24),
                const Text("Digite o Telefone:"),
                TextField(
                  maxLength: 9,
                  keyboardType: TextInputType.phone,
                  controller: numeroController,
                ),
                const SizedBox(height: 24),
                const Text("Foto do Contato:"),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    photo = await picker.pickImage(source: ImageSource.gallery);
                    // cropImage(photo!);
                  },
                  child: const Text("Adicionar Foto da Galeria"),
                ),
                const SizedBox(height: 120),
                OutlinedButton(
                    onPressed: () {
                      if (nomeController.text.isNotEmpty &&
                          numeroController.text.isNotEmpty &&
                          photo != null &&
                          photo!.path != null) {
                        // Adicione a verificação para photo != null aqui
                        widget.contatoRepository.addContato(ContatoModel.criar(
                            nomeController.text,
                            int.parse(numeroController.text),
                            photo!.path));
                        const snackBar = SnackBar(
                          content: Text("Contato adicionado!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      } else {
                        // Trate o caso em que photo ou photo.path é nulo, por exemplo, mostrando uma mensagem de erro.
                        const snackBar = SnackBar(
                          content: Text(
                              "Preencha todos os campos e selecione uma foto válida."),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Salvar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
