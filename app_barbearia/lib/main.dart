import 'package:flutter/material.dart';

void main() {
  runApp(const AppBarbearia());
}

class AppBarbearia extends StatelessWidget {
  const AppBarbearia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barbearia 3 patetas',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const TelaPrincipal(),
    );
  }
}

// TELA 1 PÁGINA INICIAL
class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barbearia 3 patetas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Menu Lateral (Drawer)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown[900]),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Página Inicial'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Meus Agendamentos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaAgendamentos(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil do Cliente'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPerfil()),
                );
              },
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.brown, width: 2),
            ),
            child: const Text(
              'Bem-vindo à Barbearia dos 3 patetas!\nNão sabemos cortar cabelo.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/foto.png',
              //height: 300,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Nossos Serviços',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 15),

          Column(
            children: [
              _construirServico(Icons.content_cut, 'Corte Tigela', 'R\$ 45,00'),
              const SizedBox(height: 10),
              _construirServico(
                Icons.face,
                'Tentativa de Degradê',
                'R\$ 35,00',
              ),
              const SizedBox(height: 10),
              _construirServico(
                Icons.clean_hands,
                'Raspagem Total Acidental',
                'R\$ 20,00',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _construirServico(IconData icone, String titulo, String preco) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icone, color: Colors.brown[700], size: 28),
              const SizedBox(width: 15),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            preco,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ],
      ),
    );
  }
}

// TELA 2 MEUS AGENDAMENTOS
class TelaAgendamentos extends StatelessWidget {
  const TelaAgendamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Agendamentos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Próximos Horários',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _cardAgendamento(
            servico: 'Corte Tigela',
            barbeiro: 'Barbeiro: Ryan',
            data: 'Amanhã - 14:30',
          ),
          const SizedBox(height: 12),
          _cardAgendamento(
            servico: 'Tentativa de Degradê',
            barbeiro: 'Barbeiro: luca',
            data: 'Amanhã - 15:00',
          ),
          const SizedBox(height: 12),
          _cardAgendamento(
            servico: 'Raspagem Total Acidental',
            barbeiro: 'Barbeiro: Hilario',
            data: 'Amanhã - 16:00',
          ),
        ],
      ),
    );
  }

  Widget _cardAgendamento({
    required String servico,
    required String barbeiro,
    required String data,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            servico,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            barbeiro,
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
          Text(
            'Data: $data',
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// TELA 3 PERFIL DO CLIENTE
class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Cliente',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.brown[900],
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'João Silva',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 25),
          const Divider(),

          _itemPerfil(Icons.email, 'E-mail', 'joao.silva@gmail.com'),
          _itemPerfil(Icons.phone, 'Telefone', '(89) 707070-70denovo'),
        ],
      ),
    );
  }

  Widget _itemPerfil(IconData icone, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icone, color: Colors.brown[700], size: 26),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
