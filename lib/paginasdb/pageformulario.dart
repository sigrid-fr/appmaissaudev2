import 'package:appmaissaudev2/database/dao/cadastro_dao.dart';
import 'package:appmaissaudev2/modelo/cadastro.dart';
import 'package:appmaissaudev2/paginasdb/pagecadastrolista.dart';
import 'package:appmaissaudev2/paginasdb/pageinicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//Classe da Aplicação
class PageFormulario extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new MaterialApp(
        title: "Formulário",
        theme: new ThemeData(primarySwatch: Colors.teal),
        home: new PaginaPrincipalPage());
  }
}


//Classe da Página Principal
class PaginaPrincipalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PaginaPrincipalState();
}

//Classe Estado da Página Principal
class _PaginaPrincipalState extends State<PaginaPrincipalPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _generoValue; //grupo usado no radio button
  //Variáveis usadas em conjunto com o CheckBox
  bool orgaosVal = false, medulaVal = false, sangueVal = false; //valores do checkbox
  int idade;
  double altura, peso, sistole, diastole, imcdb;
  String classificacaodb, classificacaoimcdb, nome, generodb, celular;
  List<String> _ts = <String>[
    '', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];
  String _tipoSangue = '', tiposangueEscolhidodb;
  //Controladores de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _sistoleController = TextEditingController();
  final TextEditingController _diastoleController = TextEditingController();
  final CadastroDao _dao = CadastroDao(); //Classe do banco de dados


  /*
  menos de 18.6 abaixo do peso
  Entre 18.6 e 24.9	Peso ideal
  Entre 24.9 e 34.9	Obesidade grau I
  Entre 34.9 e 39.9	Obesidade grau II
  Mais de 40	Obesidade grau III
  */
  //Calcula o IMC
  void _calculate() {
    // ignore: missing_return
    setState(() {
      peso = double.parse(_pesoController.text);
      altura = double.parse(_alturaController.text) / 100;
      imcdb = peso / (altura * altura);

      if (imcdb < 18.6) {
        return classificacaoimcdb = "Abaixo do peso";
      }
      if (imcdb >= 18.6 && imcdb < 24.9) {
        return classificacaoimcdb = "Peso ideal";
      }
      if (imcdb >= 24.9 && imcdb < 34.9) {
        return classificacaoimcdb = "Obesidade Grau I";
      }
      if (imcdb >= 34.9 && imcdb < 39.9) {
        return classificacaoimcdb = "Obesidade Grau II";
      }
      if (imcdb >= 40) {
        return classificacaoimcdb = "Obesidade Grau III";
      }
    });
  }

  // Método que retorna uma classificação de acordo com a sistole e diastole
  String _classificar() {
    sistole = double.parse(_sistoleController.text);
    diastole = double.parse(_diastoleController.text);
    if (sistole >= 100 &&
        sistole <= 129 &&
        diastole >= 60 &&
        diastole <= 84)
      return classificacaodb = "Normal";
    if (sistole >= 130 &&
        sistole <= 139 &&
        diastole >= 85 &&
        diastole <= 89)
      return classificacaodb = "Limítrofe";
    if (sistole >= 140 && diastole >= 90)
      return classificacaodb = "Alta";
    else
      return classificacaodb = "Erro, tente novamente";
  }

  //Resetar os campos do formulario a cada envio
  void _resetFields() {
    _formKey.currentState.reset();
    _pesoController.text = "";
    _alturaController.text = "";
    _sistoleController.text = "";
    _diastoleController.text = "";
    _nomeController.text = "";
    _idadeController.text = "";
    _celularController.text = "";
    _generoValue = "";
    _tipoSangue = "";
    setState(() {
      orgaosVal = false;
      medulaVal = false;
      sangueVal = false;
      showMessage("Informe seus dados!", Colors.blue);
    });
  }

//Botão que valida e envia os dados
  void _submitForm() {
    final FormState form = _formKey.currentState;
    // Se o radiobutton gênero não for selecionado
    if (_generoValue == null) {
      showMessage("Por favor, selecione o seu gênero!", Colors.orange);
    }
    if (_tipoSangue == null) {
      showMessage("Por favor, selecione um tipo sanguíneo!", Colors.orange);
    }
    if (_nomeController == null) {
      showMessage("Por favor, digite seu nome!", Colors.orange);
    }
    if (_idadeController == null) {
      showMessage("Por favor, digite sua idade!", Colors.orange);
    }
    if (_celularController == null) {
      showMessage("Por favor, digite o celular!", Colors.orange);
    }
    if (!form.validate()) {
      showMessage('Por favor, verifique os campos e tente novamente.', Colors.red);
    } else {
      _calculate();
      _classificar();
      //form.save();//Chama todos os eventos onSaved
      final String nome = _nomeController.text;
      final int idade = int.tryParse(_idadeController.text);
      final String celular = _celularController.text;
      final double altura = double.tryParse(_alturaController.text);
      final double peso = double.tryParse(_pesoController.text);
      final double sistole = double.tryParse(_sistoleController.text);
      final double diastole = double.tryParse(_diastoleController.text);
      final imc = imcdb;
      final genero = generodb;
      final classificacaopa = classificacaodb;
      //var tmpArray = tmpArraydb;
      final classificacaoimc = classificacaoimcdb;
      final tiposangueEscolhido = tiposangueEscolhidodb;
      final Cadastro newCadastro = Cadastro(0, nome, idade, celular, altura, peso, imc, classificacaoimc, sistole, diastole,
             classificacaopa, genero, tiposangueEscolhido);
      _dao.save(newCadastro).then((id) => Navigator.maybePop(context));
      //print('Formulário salvo, o cadastro foi atualizado...');
      showMessage('Dados salvos com sucesso!', Colors.green);
      _resetFields();
    }
  }


//Mostra mensagens em caso de campos inválidos
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Formulário"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageInicial())),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(8),
      child: new Form(
        key: _formKey,
        autovalidate: true,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                labelText: 'Nome Completo',
              ),
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              controller: _nomeController,
              validator: (val) => val.isEmpty ? 'O nome é obrigatório!' : null,
              onSaved: (val) => nome = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.cake),
                labelText: 'Idade',
              ),
              keyboardType: TextInputType.number,
              controller: _idadeController,
              // ignore: missing_return
              validator: (value) {
                if (value.length == 0 || double.parse(value) == 0.0) {
                  return ('A idade tem que ser > 0');
                }
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                labelText: 'Celular',
              ),
              keyboardType: TextInputType.phone,
              controller: _celularController,
              inputFormatters: [
                new WhitelistingTextInputFormatter(
                    new RegExp(r'^[()\d -]{1,14}$')),
              ],
              validator: (value) => isValidPhoneNumber(value)
                  ? null
                  : 'O celular deve estar no formato (##)#####-####',
              onSaved: (val) => celular = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.straighten),
                labelText: 'Altura (cm)',
              ),
              keyboardType: TextInputType.number,
              controller: _alturaController,
              // ignore: missing_return
              validator: (value) {
                if (value.length == 0 || double.parse(value) == 0.0) {
                  return ('A altura tem que ser > 0');
                }
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.directions_walk),
                labelText: 'Peso (Kg)',
              ),
              keyboardType: TextInputType.number,
              controller: _pesoController,
              // ignore: missing_return
              validator: (value) {
                if (value.length == 0 || double.parse(value) == 0.0) {
                  return ('O peso tem que ser > 0');
                }
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.favorite_border),
                labelText: 'Sístole',
              ),
              keyboardType: TextInputType.number,
              controller: _sistoleController,
              // ignore: missing_return
              validator: (value) {
                if (value.length == 0 || double.parse(value) == 0.0) {
                  return ('A sístole tem que ser > 0');
                }
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.favorite),
                labelText: 'Diástole',
              ),
              keyboardType: TextInputType.number,
              controller: _diastoleController,
              // ignore: missing_return
              validator: (value) {
                if (value.length == 0 || double.parse(value) == 0.0) {
                  return ('A diástole tem que ser > 0');
                }
              },
            ),
            new FormField(
              builder: (FormFieldState state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.colorize),
                    labelText: 'Tipo Sanguíneo',
                  ),
                  isEmpty: _tipoSangue == '',
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                      value: _tipoSangue,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          tiposangueEscolhidodb = newValue;
                          _tipoSangue = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: _ts.map((String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              validator: (val) {
                return val != '' ? null : 'Selecione um tipo sanguíneo';
              },
            ),

            new Divider(
              height: 45.0,
              color: Colors.transparent,
            ),

            _texto ('Selecione o seu gênero'),
            new Divider(
              height: 5.0,
              color: Colors.transparent,
            ),

            //RadioButtons do gênero
            Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<String>(
                    value: 'Feminino',
                    title: Text ('F'),
                    groupValue:  _generoValue,
                    onChanged: (value) {
                      setState(() {
                        _generoValue = value;
                        generodb = value;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: 'Masculino',
                    title: Text ('M'),
                    groupValue: _generoValue,
                    onChanged: (value) {
                      setState(() {
                        _generoValue = value;
                        generodb = value;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                ),
              ],
            ),

            new Divider(
              height: 25.0,
              color: Colors.transparent,
            ),

            _texto ('Selecione se tiver interesse em doar'),

            new Divider(
              height: 3.0,
              color: Colors.transparent,
            ),

            new Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: orgaosVal,
                      onChanged: (value){
                        setState(() {
                          orgaosVal = value;
                        });
                      },
                    ),
                    _textocheckbox('Doação de Órgãos'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: medulaVal,
                      onChanged: (value){
                        setState(() {
                          medulaVal = value;
                        });
                      },
                    ),
                    _textocheckbox('Doação de Medula'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: sangueVal,
                      onChanged: (value){
                        setState(() {
                          sangueVal = value;
                        });
                      },
                    ),
                    _textocheckbox('Doação de Sangue'),
                  ],
                ),
                new Divider(
                  height: 15.0,
                  color: Colors.transparent,
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: _submitForm,
                      child: new Text("ENVIAR"),
                    ),
                    new RaisedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PageCadastroLista(),
                          ),
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        "LISTAR",
                      ),
                    ),
                  ],
                ),
              ],
            ),

            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

//Método dos Textos
_texto(String mensagem){
  return Text(mensagem, style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),);
}

//Método dos Textos do Checkbox
_textocheckbox(String mensagem){
  return Text(mensagem, style: TextStyle(
    fontSize: 16,
  ),);

}

//Valida celular
bool isValidPhoneNumber(String input) {
  final RegExp regex = new RegExp(r'^\(\d\d\)\d\d\d\d\d\-\d\d\d\d$');
  return regex.hasMatch(input);
}

