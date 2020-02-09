import 'package:intl/intl.dart';

class Cadastrojs {
  String nome;
  double idade;
  String celular;
  double altura;
  double peso;
  double sistole;
  double diastole;
  String classificacaopa;
  String classificacaoimc;
  double imc;
  String genero;
  var tmpArray = [];
  String  tiposangueEscolhido;



  //Construtor
  Cadastrojs(this.nome, this.idade, this.celular, this.altura, this.peso, this.sistole, this.diastole, this.classificacaopa,
      this.imc, this.genero, this.tmpArray, this.classificacaoimc, this.tiposangueEscolhido);

  Cadastrojs.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    idade = json['idade'].toDouble();
    celular = json['celular'];
    altura = json['altura'].toDouble();
    peso = json['peso'].toDouble();
    sistole = json['sistole'].toDouble();
    diastole = json['diastole'].toDouble();
    classificacaopa = json['classificacaopa'];
    classificacaoimc = json['classificacaoimc'];
    imc = json['imc'].toDouble();
    genero = json['genero'];
    tmpArray = json['tmpArray'];
    tiposangueEscolhido = json['tiposangueEscolhido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['idade'] = this.idade;
    data['celular'] = this.celular;
    data['altura'] = this.altura;
    data['peso'] = this.peso;
    data['sistole'] = this.sistole;
    data['diastole'] = this.diastole;
    data['classificacaopa'] = this.classificacaopa;
    data['classificacaoimc'] = this.classificacaoimc;
    data['imc'] = this.imc;
    data['genero'] = this.genero;
    data['tmpArray'] = this.tmpArray;
    data['tiposangueEscolhido'] = this.tiposangueEscolhido;
    return data;
  }
}