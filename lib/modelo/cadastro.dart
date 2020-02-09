class Cadastro {
  final int id;
  final String nome;
  final int idade;
  final String celular;
  final double altura;
  final double peso;
  final double imc;
  final String classificacaoimc;
  final double sistole;
  final double diastole;
  final String classificacaopa;
  final String genero;
  //var tmpArray;
  final tiposangueEscolhido;

  Cadastro(
      this.id, this.nome, this.idade, this.celular, this.altura,
      this.peso, this.imc, this.classificacaoimc, this.sistole, this.diastole,
      this.classificacaopa, this.genero, this.tiposangueEscolhido,
      );

  @override
  String toString() {
    return 'Cadastro{id: $id, nome: $nome, idade: $idade, celular: $celular, altura: $altura, peso: $peso, imc: $imc,'
        'classificacaoimc: $classificacaoimc, sistole: $sistole, diastole: $diastole, classificacaopa: $classificacaopa,'
        'genero: $genero, tiposangueEscolhido: $tiposangueEscolhido}';
  }
}
