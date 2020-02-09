import 'package:appmaissaudev2/modelo/cadastrojs.dart';
import 'package:appmaissaudev2/paginas/pagevisualizajson.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert' as converte;

class PageListaJson extends StatefulWidget {
  @override
  _PageListaCadastradosState createState() => _PageListaCadastradosState();
}

class _PageListaCadastradosState extends State<PageListaJson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Json'),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(6),
          child: _montarlistadinamica(context)
      ),
    );

  }

  _montarlistadinamica(BuildContext context){
    //O FutureBuilder diferente do Future simples, permite retornar um Widget
    //Nesta implementação usaremos ele para retornar um Listview preenchido
    //com dados vindos da Internet.
    //Em seu construtor temos o "future" que será o local de recebimento dos
    //dados e "builder" que recebe um função que tem como parâmetro o "contexto" e o
    //snapshot que "guarda" os dados a serem recebidos a partir de uma ação assíncrona.
    return FutureBuilder(
        future: _buscardados(),
        builder: (context,snapshot){
          //Se já tiver os dados, ele chama a função que cria a ListView
          //Perceba que a função recebe o snapshot.data, dentro deste recurso estarão os dados
          //a serem apresentados no ListView
          if (snapshot.hasData) {
            return _crialistview(snapshot.data);
          } else {
            //Enquanto a Future não tem os dados, ele apresenta um CircularProgress
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

  Future<List<Cadastrojs>> _buscardados() async{
    List<Cadastrojs> lista = new List<Cadastrojs>();

    String url = "https://api.myjson.com/bins/g7mrm";

    http.Response resposta = await http.get(url);
    if(resposta.statusCode == HttpStatus.ok){
      //A chamada aconteceu com sucesso
      var listaretorno = converte.jsonDecode(resposta.body);
      for (var cad in listaretorno) {
        //Transformamos nosso mapa em um objeto Monografia
        Cadastrojs objcad = Cadastrojs.fromJson(cad);
        lista.add(objcad);
      }
    }
    else{
      //Falha ao chamar o serviço
      print("Falha ao receber os dados da Internet.");
    }

    return Future.value(lista);
  }

  _crialistview(listacad){
    return ListView.builder(
      itemCount: listacad.length,
      itemBuilder: (context,index){
        //Recuperamos um objeto que estava dentro da Lista retornada pelo
        //FutureBuilder (snapshot.data)
        Cadastrojs itemcad = listacad[index];
        //Aqui tomamos uma decisão baseado na nota do aluno
        //Se a nota do aluno for "0.0", estamos considerando que ele ainda não
        //foi avaliado, mudando a imagem a ser apresentada na lista
        String urlimagem = "";
        if (itemcad.classificacaopa == "Alta") {
          urlimagem = "assets/images/avatar2.png";
        }else {
          urlimagem = "assets/images/avatar1.png";
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(urlimagem),
          ),
          title: Text(itemcad.nome), //nome
          subtitle: Text(itemcad.classificacaopa), //classificacao pressao
          trailing: Text(itemcad.tiposangueEscolhido), //imc
          onTap: (){
            //Ao clicar no item da lista ele irá chamar esta função
            //Em nosso caso, vamos navegar para uma próxima página
            Navigator.push(context, MaterialPageRoute(builder: (context){
              //O return indica para onde iremos navegar, neste caso para PageAvaliaTcc
              return PageVisualizaJson(itemcad);
            }));
          },
        );
      },
    );
  }
}
