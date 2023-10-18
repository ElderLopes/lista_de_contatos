// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_contatos/model/lista_contato_model.dart';
import 'package:lista_de_contatos/repository/contato_repository.dart';

class PageContato extends StatefulWidget {
  PageContato(this.contatoRepository, {super.key});

  ContatoRepository contatoRepository;

  @override
  State<PageContato> createState() => _PageContatoState();
}

class _PageContatoState extends State<PageContato> {
  ListaContatosModel _contatosBack4App = ListaContatosModel([]);
  bool carregando = false;

  void loadContatos() async {
    setState(() {
      carregando = true;
    });
    _contatosBack4App = await widget.contatoRepository.obterContatos();
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadContatos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Contatos Salvos")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: carregando
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _contatosBack4App.listaContatos.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var contato = _contatosBack4App.listaContatos[index];
                    return Dismissible(
                      key: Key(contato.objectId),
                      onDismissed: (DismissDirection dismissDirection) async {
                        await widget.contatoRepository
                            .removeContato(contato.objectId);
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              "Contato ${index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const SizedBox(width: 15),
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(File(contato.foto))),
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contato.nome),
                                    Text("${contato.numero}"),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
