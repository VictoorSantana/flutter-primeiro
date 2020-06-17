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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transacoes = [
    Transacao(
      id: 't0',
      titulo: 'Monitor novo',
      valor: 350.50,
      data: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transacao(
      id: 't1',
      titulo: 'Novo Tênis de Corrida',
      valor: 310.76,
      data: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de luz',
      valor: 211.30,
      data: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

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

  _adicionarTransacao(String titulo, double valor) {
    print('_adicionarTransacao');
    final novaTransacao = Transacao(
      id: new Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop(); //fecha o modal
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
            TransacaoLista(_transacoes),
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
