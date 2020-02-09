import 'package:appmaissaudev2/database/dao/cadastro_dao.dart';
import 'package:appmaissaudev2/modelo/cadastro.dart';
import 'package:appmaissaudev2/paginas/pagelistajson.dart';
import 'package:appmaissaudev2/paginasdb/pageformulario.dart';
import 'package:appmaissaudev2/paginasdb/pagevisualizadados.dart';
import 'package:flutter/material.dart';

class PageCadastroLista extends StatelessWidget {

  final CadastroDao _dao = CadastroDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Cadastrados'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Cadastro>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Cadastro> cadastros = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Cadastro cadastro = cadastros[index];
                  return _CadastroItem(cadastro);
                },
                itemCount: cadastros.length,
              );
              break;
          }
          return Text('Erro!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PageListaJson(),
            ),
          );
        },
        child: Icon(
          Icons.list,
        ),
      ),
    );
  }
}

class _CadastroItem extends StatelessWidget {
  final Cadastro cadastro;
  _CadastroItem(this.cadastro);

  @override
  Widget build(BuildContext context) {
    String urlimagem = "";
    if (cadastro.classificacaopa == "Alta") {
      urlimagem = "assets/images/avatar2.png";
    }else {
      urlimagem = "assets/images/avatar1.png";
    }
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(urlimagem),
      ),
      title: Text(cadastro.nome), //nome
      subtitle: Text(cadastro.classificacaopa), //classificacao pressao
      trailing: Text(cadastro.tiposangueEscolhido), //imc
      onTap: (){
        //Ao clicar no item da lista ele irá chamar esta função
        //Em nosso caso, vamos navegar para uma próxima página
        Navigator.push(context, MaterialPageRoute(builder: (context){
          //O return indica para onde iremos navegar, neste caso para PageAvaliaTcc
          return PageVisualizaDados(cadastro);
        }));
      },
    );
  }
}