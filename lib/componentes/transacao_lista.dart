import 'package:flutter/material.dart';
import 'package:primeiro/models/transacao.dart';
import 'package:intl/intl.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transacao> transacoes;

  TransacaoLista(this.transacoes);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: transacoes.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/imagens/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (ctx, index) {
                final tr = transacoes[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${tr.valor.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(tr.titulo,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            DateFormat('d MMM y').format(tr.data),
                            style: TextStyle(color: Colors.grey[250]),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
