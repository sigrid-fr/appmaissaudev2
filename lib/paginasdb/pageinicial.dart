import 'package:appmaissaudev2/paginas/pagesobre.dart';
import 'package:appmaissaudev2/paginasdb/pageformulario.dart';
import 'package:flutter/material.dart';

class PageInicial extends StatelessWidget {
  PageInicial createState()=> PageInicial();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mais Saúde'),
        centerTitle: true,
      ),
      body: _body(context),

    );
  }

  _body(BuildContext context){
    return Container(
      color: Colors.teal,
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(6),
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Divider(
              height: 40.0,
              color: Colors.transparent,
            ),
            _imagem('assets/images/logoapp.png'),
            new Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            _texto('Consulte o seu IMC e PA'),
            new Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            _botao(context),
            new Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            _botao2(context),
          ],
        ),
      ),
    );
  }

  _imagem(String url){
    return Image.asset(url);
  }

  _texto(String txt){
    return Text(txt, style:TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  _botao(BuildContext context){
    return RaisedButton(
      child: Text('AVANÇAR',
        style: new TextStyle(color: Colors.white),
      ),
      color: Colors.orange,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder:(context){
          return PageFormulario();
        }));
      },
    );
  }

  _botao2(BuildContext context){
    return RaisedButton(
      child: Text('SOBRE',
        style: new TextStyle(color: Colors.white),
      ),
      color: Colors.orange,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder:(context){
          return PageSobre();
        }));
      },
    );
  }
}