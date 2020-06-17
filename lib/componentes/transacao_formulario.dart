import 'package:flutter/material.dart';

class TransacaoFormulario extends StatefulWidget {
  final void Function(String, double) emEnvio;

  TransacaoFormulario(this.emEnvio);

  @override
  _TransacaoFormularioState createState() => _TransacaoFormularioState();
}

class _TransacaoFormularioState extends State<TransacaoFormulario> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  _formularioEnviado() {    
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;
    
    if(titulo.isEmpty || valor <= 0) {
      return ;
    }  

    widget.emEnvio(titulo, valor);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: _formularioEnviado,
                  child: Text('Nova Transação'),
                  textColor: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
