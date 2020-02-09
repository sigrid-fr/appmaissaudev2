import 'package:appmaissaudev2/paginasdb/pagecadastrolista.dart';
import 'package:flutter/material.dart';
import '../modelo/cadastro.dart';


class PageVisualizaDados extends StatelessWidget {
  final Cadastro cad;

  PageVisualizaDados(this.cad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Cadastro'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Image.asset('assets/images/avatar3.png'), //profile image
          new Divider(
            height: 25.0,
            color: Colors.transparent,
          ),
          _texto_negrito(cad.nome),
          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
          _texto_normal("Celular: ${cad.celular}"),
          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
          _texto_normal("Sexo: ${cad.genero}"),

          new Divider(
            height: 18.0,
            color: Colors.transparent,
          ),

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_normal("Idade: ${cad.idade.toStringAsPrecision(2)}"),
              _texto_normal("Sangue: ${cad.tiposangueEscolhido}"),
            ],
          ),

          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_normal("Sístole: ${cad.sistole.toStringAsPrecision(3)}"),
              _texto_normal("Diástole: ${cad.diastole.toStringAsPrecision(2)}"),
            ],
          ),

          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
          _texto_normal("Classificação PA: ${cad.classificacaopa}"),
          new Divider(
            height: 18.0,
            color: Colors.transparent,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_normal("Altura: ${cad.altura}"),
              _texto_normal("Peso: ${cad.peso.toStringAsPrecision(3)}"),
              _texto_normal("IMC: ${cad.imc.toStringAsPrecision(3)}"),
            ],
          ),
          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
              _texto_normal("Classificação do IMC: ${cad.classificacaoimc}"),
          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  _texto_negrito(String txt){
    return Text(txt, style:TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ));
  }

  _texto_normal(String txt){
    return Text(txt, style:TextStyle(
      fontSize: 16,
    ));
  }
}