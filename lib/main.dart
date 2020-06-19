import 'package:flutter/material.dart';

import 'dart:math';
import 'package:primeiro/componentes/grafico.dart';
import 'package:primeiro/componentes/transacao_formulario.dart';
import 'package:primeiro/componentes/transacao_lista.dart';

import 'models/transacao.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Montserrat',
        textTheme: (
          ThemeData.light().textTheme.copyWith(
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ) 
        )
      ),            
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transacoes = [ ];

  _abrirModalTransacao(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransacaoFormulario(_adicionarTransacao);
      },
    );
  }

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }  

  _adicionarTransacao(String titulo, double valor, DateTime data) {
    print('_adicionarTransacao');
    final novaTransacao = Transacao(
      id: new Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop(); //fecha o modal
  }

  _removerTransacao(String id) {
    setState(() {
      _transacoes.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _abrirModalTransacao(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Grafico(_transacoesRecentes),
            TransacaoLista(_transacoes, _removerTransacao),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _abrirModalTransacao(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
