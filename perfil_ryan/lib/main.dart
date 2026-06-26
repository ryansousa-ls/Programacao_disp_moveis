import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil',
      theme: ThemeData(
        // mexe aqui para alterar o esquema de cores do app
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF009688),
          brightness: Brightness.dark, //tema escuro mais massa
        ),
      ),
      home: const MyHomePage(title: 'Meu Perfil'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int paginaAtual = 0;

  final List<Widget> paginas = const [
    SobrePage(),
    FormacaoPage(),
    ContatoPage(),
  ];

  void selecionarPagina(int index) {
    setState(() {
      paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //barra do comentario la em cima
        backgroundColor: const Color.fromARGB(255, 9, 45, 107),
        title: Text(widget.title),
      ),

      // Menu lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 75, 6, 255)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/perfil.jpg'),
                  ),
                  Text(
                    'Opções do Perfil',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Sobre Mim'),
              onTap: () {
                //quando clica na opção ele abre outra pagina
                selecionarPagina(0);
                Navigator.pop(context); // Fecha o menu lateral
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Formação'),
              onTap: () {
                selecionarPagina(1);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contato'),
              onTap: () {
                selecionarPagina(2);
                Navigator.pop(context);
              },
            ),
          ], //children
        ),
      ),

      body: paginas[paginaAtual],

      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: selecionarPagina,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Sobre Mim'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Formação'),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contato',
          ),
        ],
      ),
    );
  }
}

// --- PÁGINAS ---

// 1. Página "Sobre"
class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 15),
        Flexible(child: Text(text, style: const TextStyle(fontSize: 18))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: Text(
            'Quem eu sou',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),

        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // deixa as bodas redondas
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset('assets/images/perfil.jpg', height: 200),
                ),
                const SizedBox(height: 24),
                _buildInfoRow(Icons.person, 'Nome: Ryan Charles'),
                const SizedBox(
                  height: 12,
                ), // Espaço extra entre as linhas para respirar
                _buildInfoRow(Icons.work, 'Profissão: Analista de sistemas'),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.location_city, 'Instituição: UESPI'),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.cake, 'Idade: 22 anos'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 2. Página "Formação"
class FormacaoPage extends StatelessWidget {
  const FormacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Minha Formação',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.school, size: 48, color: Colors.blueAccent),
                    SizedBox(height: 16),
                    Text(
                      'Bacharelado em Ciência da Computação',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Universidade Estadual do Piauí (UESPI)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(137, 255, 255, 255),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Página "Contato"
class ContatoPage extends StatelessWidget {
  const ContatoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Meus Contatos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      leading: Icon(Icons.phone, size: 36, color: Colors.green),
                      title: Text(
                        '(89) 99445-9976',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Telefone / WhatsApp'),
                    ),
                    Divider(height: 24, thickness: 1),
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        size: 36,
                        color: Colors.blueAccent,
                      ),
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ryancharlessousa50@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text('E-mail Pessoal'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
