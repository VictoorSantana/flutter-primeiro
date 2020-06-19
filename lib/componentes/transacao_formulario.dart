import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoFormulario extends StatefulWidget {
  final void Function(String, double, DateTime) emEnvio;

  TransacaoFormulario(this.emEnvio);

  @override
  _TransacaoFormularioState createState() => _TransacaoFormularioState();
}

class _TransacaoFormularioState extends State<TransacaoFormulario> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  _formularioEnviado() {
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;

    if (titulo.isEmpty || valor <= 0 || _dataSelecionada == null) {
      return;
    }

    widget.emEnvio(titulo, valor, _dataSelecionada);
  }

  _mostrarDataPegador() {
    showDatePicker(
      context: context, //esse context é por herança
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dataSelecionada = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: tituloController,
              onSubmitted: (_) => _formularioEnviado(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _formularioEnviado(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dataSelecionada == null
                          ? 'Sem data selecionada'
                          : DateFormat('dd/MM/yyyy').format(_dataSelecionada),
                    ),
                  ),
                  FlatButton(
                    onPressed: _mostrarDataPegador,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _formularioEnviado,
                  child: Text('Nova Transação'),
                  textColor: Theme.of(context).textTheme.button.color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
