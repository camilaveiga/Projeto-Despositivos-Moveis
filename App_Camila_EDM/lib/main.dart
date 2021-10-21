import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppCamila',
      theme: ThemeData(
        primaryColor: Colors.red.shade900,
        backgroundColor: Colors.grey.shade900,
        focusColor: Colors.grey.shade600,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade700), //TextStyle
          headline3: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      initialRoute: 'TelaLogin',
      routes: {
        'TelaLogin': (context) => TelaLogin(),
        'TelaPrincipal': (context) => TelaPrincipal(),
      }, // passar informações
    ),
  );
}

// Classe para Troca de Dados entre as Telas
class Cadastro {
  final String nome;
  final String email;

  Cadastro(this.nome, this.email);
}

// TELA LOGIN
class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var nome = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.movie,
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
            SizedBox(height: 30),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              controller: nome,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Entre com o nome',
                hintStyle: TextStyle(
                  color: Theme.of(context).focusColor,
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
              ), // decoration: InputDecoration
            ), // TextField
            SizedBox(height: 20),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Entre com o email',
                hintStyle: TextStyle(
                  color: Theme.of(context).focusColor,
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
              ), // decoration: InputDecoration
            ), // TextField
            SizedBox(height: 20),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Entre com a senha',
                hintStyle: TextStyle(
                  color: Theme.of(context).focusColor,
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
              ), // decoration: InputDecoration
            ), // TextField
            SizedBox(height: 50),
            MaterialButton(
              minWidth: 200.0,
              height: 45,
              color: Theme.of(context).primaryColor,
              child: Text('Continuar', style: Theme.of(context).textTheme.headline1),
              onPressed: () {
                var obj = Cadastro(
                  nome.text,
                  email.text,
                );
                Navigator.pushNamed(context, 'TelaPrincipal', arguments: obj);
              },
            ), // MaterialButton
            SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.red.shade900, fontSize: 17),
              ),
              child: Text('Não possuo cadastro'),
              onPressed: () {},
            ),
          ], // <wedgie>
        ), //Column
      ), //body SingleChildScrollView
    ); //Scaford
  }
}

// TELA PRINCIPAL
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  var telaAtual = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var obj;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      obj = ModalRoute.of(context)!.settings.arguments as Cadastro;
    } else {
      obj = Cadastro('', '');
    }

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          TelaHome(),
          TelaPesquisar(),
          TelaSugestao(),
          TelaPerfil(),
        ],
        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
            obj;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).backgroundColor,
        iconSize: 32,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.60),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: telaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Sugestão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          setState(() {
            telaAtual = index;
          });

          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ), //Bottomnavigationbar
    ); //Scafford
  }
}

// TELA HOME
class TelaHome extends StatelessWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var obj;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      obj = ModalRoute.of(context)!.settings.arguments as Cadastro;
    } else {
      obj = Cadastro('', '');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'HOME',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Seja bem vindo, ' + obj.nome,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ]),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaMenu()),
                  );
                },
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.amberAccent,
              tabs: [
                Text("FILMES"),
                Text("SERIES"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TelaFilme(),
              TelaSerie(),
            ],
          ),
        ), // child: Scaffold
      ), // home: DefaultTabController
    ); // Material App
  }
}

// TELA PESQUISAR
class TelaPesquisar extends StatelessWidget {
  const TelaPesquisar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          TextField(
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Busque por filme ou série',
              hintStyle: TextStyle(
                color: Colors.grey.shade700,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              )),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              )),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ), // TextField
          SizedBox(height: 40),
          Text('Pesquisas recentes', style: TextStyle(color: Theme.of(context).primaryColor)),
        ],
      ), // Column
    ); // Container
  }
}

// TELA PERFIL
class TelaPerfil extends StatelessWidget {
  const TelaPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cancelaButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {},
    );
    Widget continuaButton = FlatButton(
      child: Text("Continar"),
      onPressed: () {},
    );

    var obj;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      obj = ModalRoute.of(context)!.settings.arguments as Cadastro;
    } else {
      obj = Cadastro('', '');
    }

    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Deseja mesmo sair?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );

    return Scaffold(
      body: Container(
        width: 360,
        color: Colors.grey.shade900,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(obj.email),
              accountName: Text(obj.nome),
              currentAccountPicture: CircleAvatar(
                child: Text("UN"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('Minha conta', style: Theme.of(context).textTheme.headline3),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.white),
              title: Text('Perguntas frequentes', style: Theme.of(context).textTheme.headline3),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.white),
              title: Text('Notificações', style: Theme.of(context).textTheme.headline3),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.file_copy, color: Colors.white),
              title: Text('Termos e políticas', style: Theme.of(context).textTheme.headline3),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Sair', style: Theme.of(context).textTheme.headline3),
              onTap: () => {
                //exibe o diálogo
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                ),
              },
            ),
          ], // <Widget>
        ), //Column
      ), // Container
    ); // Scaffold
  }
}

// TELA SERIE
class TelaSerie extends StatelessWidget {
  const TelaSerie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Container(
                //largura responsiva
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WidgetProduto('WandaVision', '9,1/10', 'lib/imagens/wandavision.jpg'),
                      WidgetProduto('Round 6', '9,2/10', 'lib/imagens/round6.jpg'),
                      WidgetProduto('The Office', '8,1/10', 'lib/imagens/theoffice.jpg'),
                      WidgetProduto('Friends', '9,4/10', 'lib/imagens/friends.jpg'),
                      WidgetProduto('O Homem do Castelo', '8,4/10', 'lib/imagens/ohdca.jpg'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              //largura responsiva
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Destaques',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                      ),
                    ),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                  ],
                ),
              ),
            ),
          ],
        ), // Column
      ), // body: SingleChildScrollView
    ); // Scafford
  }
}

// TELA INFORMAÇÕES
class TelaInfo extends StatelessWidget {
  const TelaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade900,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 360,
                color: Theme.of(context).backgroundColor,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    image: new DecorationImage(image: AssetImage("lib/imagens/dvp_capa.jpg"), fit: BoxFit.cover),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 360,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'De Volta Pro Futuro',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(40, 15, 5, 5),
                            child: Image.asset(
                              'lib/imagens/12.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Back To The Future', style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(height: 20),
                    Text('Sinopse:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 12),
                    Text(
                      'Marty McFly, um adolescente de uma pequena cidade californiana, é transportado para a década de 1950 quando a experiência do excêntrico cientista Doc Brown dá errado. Viajando no tempo em um carro modificado, Marty conhece versões jovens de seus pais e precisa fazer com que eles se apaixonem, ou então ele deixará de existir. Para complicar, Marty precisa voltar para casa a tempo de salvar o cientista.',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Onde assistir: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 12),
                                ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image.asset('lib/imagens/striming.jpg')),
                                SizedBox(height: 12),
                                Text('Genero:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 10),
                                Text('Ficção Científica\nAventura e Ação', style: TextStyle(fontSize: 13, color: Colors.white)),
                                SizedBox(height: 12),
                                Text('Elenco:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 12),
                                Text(
                                  'Marty McFly: Michael J.\nFox\nDr. Emmett "Doc" Brown:\nChristopher Lloyd\nLorraine Baines McFly:\nLea Thompson\nGeorge McFly: Crispin\nGlover \nBiff Tannen: Thomas F.\nWilson ',
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Nota: ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(height: 12),
                                      Icon(Icons.star, color: Colors.yellow, size: 15.0),
                                      SizedBox(height: 12),
                                      Text(
                                        '8,5/10  IMDb',
                                        style: TextStyle(fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Lançamento: 3 de\nJulho de 1985',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Direção: Robert Zemeckis\nRoteiro: Robert Zemeckis,\nBob Gale\nMúsica: Alan Silvestri\nCinematografia: Dean\nCundey\nEdição: Harry Keramidas,\nArthur Schmidt\nDistribuição:\nUniversal Pictures',
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // Container
                  ],
                ),
              ),
            ],
          ), // Column
        ), // SingleChildScrollView(
      ), // Container
    ); // Scaffold
  }
}

// TELA MENU
class TelaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('MENU', style: Theme.of(context).textTheme.headline1),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: Theme.of(context).textTheme.headline3),
              onTap: () => {
                Navigator.of(context).pop()
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Configuração', style: Theme.of(context).textTheme.headline3),
              onTap: () => {
                Navigator.of(context).pop()
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text('Sobre o App', style: Theme.of(context).textTheme.headline3),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaSobre()),
                )
              },
            ),
          ],
        ), // ListWiew
      ), // Container
    ); // Drewer
  }
}

//TELA FILME
class TelaFilme extends StatelessWidget {
  const TelaFilme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Container(
                //largura responsiva
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WidgetProduto('De Volta Para o Futuro', '8,5/10', 'lib/imagens/de_volta_pro.jpg'),
                      WidgetProduto('Vingadores', '9,2/10', 'lib/imagens/vigadores.jpg'),
                      WidgetProduto('Jogos Vorazes', '8,7/10', 'lib/imagens/jogosvorazes.jpg'),
                      WidgetProduto('Batman: O Caveleiro das', '9,8/10', 'lib/imagens/batmantrevas.jpg'),
                      WidgetProduto('Star Wars: Epsode I', '5,6/10', 'lib/imagens/sw1.jpg'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              //largura responsiva
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Destaques',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                      ),
                    ),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                  ],
                ),
              ),
            ),
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}

// TELA SOBRE
class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o APP'),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  child: Image.asset('lib/imagens/sobre.jpg')),
            ),
            SizedBox(height: 20),
            Text(
              'Desenvolvedora: Camila Veiga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade200),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Esse é um aplicativo que tem como propósito fornecer informações gerais sobre séries e filmes para que o telespectdor possa encontrar tudo sobre suas séries e filmes favoritos de uma maneira fácil e objetiva.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade200),
              ),
            ),
          ],
        ),
      ), // Container
    ); // Scaffold
  }
}

// TELA SUGESTÃO
class TelaSugestao extends StatelessWidget {
  const TelaSugestao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var obj;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      obj = ModalRoute.of(context)!.settings.arguments as Cadastro;
    } else {
      obj = Cadastro('', '');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sugestões para ' + obj.nome),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              //largura responsiva
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('The Flah', '7,8/10', 'outubro de 2014', 'lib/imagens/theflash.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                    WidgetProduto2('Carrossel: O Filme', '4,2/10', 'julho de 2015', 'lib/imagens/carrossel.jpg'),
                  ],
                ),
              ),
            ),
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}

class WidgetProduto extends StatelessWidget {
  final String nome;
  final String nota;
  final String foto;

  //CONSTRUTOR
  const WidgetProduto(this.nome, this.nota, this.foto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 250,
      child: InkWell(
        child: Column(
          children: [
            //FOTO do produto
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  child: Image.asset(this.foto)),
            ),
            Text(
              this.nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade200),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20.0),
                  Icon(Icons.star, color: Colors.yellow, size: 20.0),
                  Icon(Icons.star, color: Colors.yellow, size: 20.0),
                  Icon(Icons.star, color: Colors.yellow, size: 20.0),
                  Icon(Icons.star_outline, color: Colors.yellow, size: 20.0),
                ],
              ),
            ),
          ],
        ), // Column
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaInfo()),
          );
        },
      ), // InkWell
    ); // Container
  }
}

class WidgetProduto2 extends StatelessWidget {
  final String nome;
  final String data;
  final String nota;
  final String foto;

  //CONSTRUTOR
  const WidgetProduto2(this.nome, this.nota, this.data, this.foto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: 360,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //FOTO do produto
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    child: Image.asset(this.foto))),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.nome,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade200),
                  ),
                  Text(
                    this.data,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade200),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20.0),
                        Icon(Icons.star, color: Colors.yellow, size: 20.0),
                        Icon(Icons.star, color: Colors.yellow, size: 20.0),
                        Icon(Icons.star, color: Colors.yellow, size: 20.0),
                        Icon(Icons.star_outline, color: Colors.yellow, size: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), // Row
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaInfo()),
          );
        },
      ), // InkWell
    ); // Container
  }
}
