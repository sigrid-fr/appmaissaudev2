import 'package:flutter/material.dart';

class PageSobre extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
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
            height: 15.0,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 160.0,
                height: 160.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://miro.medium.com/fit/c/256/256/1*Ccqu3IYpMN3Cvy9g6drr5A.jpeg")
                  ),
                )),
          ),
          new Divider(
            height: 25.0,
            color: Colors.transparent,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_negrito("Sigrid Rodrigues"),
            ],
          ),
          new Divider(
            height: 13.0,
            color: Colors.transparent,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_normal("Desenvolvedora"),
            ],
          ),
          new Divider(
            height: 25.0,
            color: Colors.transparent,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _texto_normal("O app Mais Saúde tem o intuito de\n"
                  "calcular o IMC e classificar a pressão\n"
                  "arterial dos usuários cadastrados, ao\n"
                  "mesmo tempo, busca encontrar pessoas\n"
                  "interessadas em doar sangue, medula\n"
                  "ou órgãos, fora de apps específicos\n"
                  "para isso."),
            ],
          ),
        ],
      ),
    );
  }

  _texto_negrito(String txt){
    return Text(txt, style:TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold
    ));
  }

  _texto_normal(String txt){
    return Text(txt, style: TextStyle(fontSize: 16), textAlign: TextAlign.center
    );
  }
}