import 'package:flutter/material.dart';
import 'package:primeiro/componentes/grafico_barra.dart';
import 'package:primeiro/models/transacao.dart';

import 'package:intl/intl.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  Grafico(this.transacoesRecentes);

  List<Map<String, Object>> get transacoesAgrupadas {
    return List.generate(7, (index) {
      final diaDaSemana = DateTime.now().subtract(
        Duration(days: index),
      );

      double somaTotal = 0.0;

      for (var i = 0; i < transacoesRecentes.length; i++) {
        bool mesmoDia = transacoesRecentes[i].data.day == diaDaSemana.day;
        bool mesmoMes = transacoesRecentes[i].data.month == diaDaSemana.month;
        bool mesmoAno = transacoesRecentes[i].data.year == diaDaSemana.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          somaTotal += transacoesRecentes[i].valor;
        }
      }

      //print(DateFormat.E().format(diaDaSemana)[0]);
      //print(somaTotal);

      return {
        'dia': DateFormat.E().format(diaDaSemana)[0],
        'valor': somaTotal,
      };
    });
  }

  double get _somaTotalDaSemana {
    return transacoesAgrupadas.fold(0.0, (soma, tr) {
      return soma + tr['valor'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transacoesAgrupadas.map((tr) {
          return Flexible(
            child: GraficoBarra(
              rotulo: tr['dia'],
              valor: tr['valor'],
              porcentual: (tr['valor'] as double) / _somaTotalDaSemana,
            ),
          );
        }).toList(),
      ),
    );
  }
}
