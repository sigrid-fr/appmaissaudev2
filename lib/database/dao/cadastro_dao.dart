import 'package:appmaissaudev2/modelo/cadastro.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';


class CadastroDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_idade INTEGER, '
      '$_celular TEXT, '
      '$_altura REAL, '
      '$_peso REAL, '
      '$_imc REAL, '
      '$_classificacaoimc TEXT, '
      '$_sistole REAL, '
      '$_diastole REAL, '
      '$_classificacaopa TEXT, '
      '$_genero TEXT, '
      //'$_tmpArray TEXT, '
      '$_tiposangueEscolhido TEXT)';
  static const String _tableName = 'appmaisaude';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _idade = 'idade';
  static const String _celular = 'celular';
  static const String _altura = 'altura';
  static const String _peso = 'peso';
  static const String _imc = 'imc';
  static const String _classificacaoimc = 'classificacaoimc';
  static const String _sistole = 'sistole';
  static const String _diastole = 'diastole';
  static const String _classificacaopa = 'classificacaopa';
  static const String _genero = 'genero';
  //static const String _tmpArray = 'tmpArray';
  static const String _tiposangueEscolhido = 'tiposangueEscolhido';

  Future<int> save(Cadastro cadastro) async {
    final Database db = await getDatabase();
    Map<String, dynamic> cadastroMap = _toMap(cadastro);
    return db.insert(_tableName, cadastroMap);
  }

  Future<List<Cadastro>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Cadastro> cadastros = _toList(result);
    return cadastros;
  }

  Map<String, dynamic> _toMap(Cadastro cadastro) {
    final Map<String, dynamic> cadastroMap = Map();
    cadastroMap[_nome] = cadastro.nome;
    cadastroMap[_idade] = cadastro.idade;
    cadastroMap[_celular] = cadastro.celular;
    cadastroMap[_altura] = cadastro.altura;
    cadastroMap[_peso] = cadastro.peso;
    cadastroMap[_imc] = cadastro.imc;
    cadastroMap[_classificacaoimc] = cadastro.classificacaoimc;
    cadastroMap[_sistole] = cadastro.sistole;
    cadastroMap[_diastole] = cadastro.diastole;
    cadastroMap[_classificacaopa] = cadastro.classificacaopa;
    cadastroMap[_genero] = cadastro.genero;
    //cadastroMap[_tmpArray] = cadastro.tmpArray;
    cadastroMap[_tiposangueEscolhido] = cadastro.tiposangueEscolhido;
    return cadastroMap;
  }

  List<Cadastro> _toList(List<Map<String, dynamic>> result) {
    final List<Cadastro> cadastros = List();
    for (Map<String, dynamic> row in result) {
      final Cadastro cadastro = Cadastro(
        row[_id],
        row[_nome],
        row[_idade],
        row[_celular],
        row[_altura],
        row[_peso],
        row[_imc],
        row[_classificacaoimc],
        row[_sistole],
        row[_diastole],
        row[_classificacaopa],
        row[_genero],
        //row[_tmpArray],
        row[_tiposangueEscolhido],
      );
      cadastros.add(cadastro);
    }
    return cadastros;
  }
}