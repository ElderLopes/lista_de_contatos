import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/page/add_contato.dart';
import 'package:lista_de_contatos/page/page_contato.dart';
import 'package:lista_de_contatos/repository/contato_repository.dart';

class Contato extends StatefulWidget {
  const Contato({super.key});

  @override
  State<Contato> createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  var dio = Dio();
  ContatoRepository contatoRepository = ContatoRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contatos com Back4App"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              const Text(
                "Clique no botão abaixo para adicionar um contato:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 48),
              OutlinedButton(
                child: const Text("Adicionar Contato"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (bc) => AddContato(contatoRepository)));
                },
              ),
              const SizedBox(height: 48),
              const Text(
                "Para visualizar os contatos salvos, clique no botão abaixo:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 48),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (bc) => PageContato(contatoRepository)));
                    });
                  },
                  child: const Text("Contatos Salvos")),
            ],
          ),
        ),
      ),
    );
  }
}
