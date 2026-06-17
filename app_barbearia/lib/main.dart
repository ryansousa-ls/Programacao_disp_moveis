import 'package:flutter/material.dart';

void main() {
  runApp(const BarbeariaPremiumApp());
}

class BarbeariaPremiumApp extends StatelessWidget {
  const BarbeariaPremiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbearia Premium',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug no canto
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(
          0xFF121212,
        ), // Fundo preto elegante
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(
            255,
            65,
            63,
            59,
          ), // Dourado/Âmbar como cor principal
          secondary: Colors.amberAccent,
          surface: Color(0xFF1E1E1E), // Cinza escuro para os cards
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Fonte limpa
      ),
      home: const TelaAgendamentoPremium(),
    );
  }
}

class TelaAgendamentoPremium extends StatefulWidget {
  const TelaAgendamentoPremium({super.key});

  @override
  State<TelaAgendamentoPremium> createState() => _TelaAgendamentoPremiumState();
}

class _TelaAgendamentoPremiumState extends State<TelaAgendamentoPremium> {
  int? _servicoIndexSelecionado;
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;

  // Lista de serviços mais detalhada usando Map
  final List<Map<String, dynamic>> _servicos = [
    {
      'titulo': 'Corte Degradê',
      'preco': 'R\$ 35,00',
      'icone': Icons.content_cut,
    },
    {'titulo': 'Barba Tradicional', 'preco': 'R\$ 25,00', 'icone': Icons.face},
    {'titulo': 'Corte + Barba', 'preco': 'R\$ 55,00', 'icone': Icons.spa},
    {
      'titulo': 'Luzes / Platinado',
      'preco': 'R\$ 80,00',
      'icone': Icons.color_lens,
    },
  ];

  Future<void> _escolherData() async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.amber,
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (dataEscolhida != null) {
      setState(() => _dataSelecionada = dataEscolhida);
    }
  }

  Future<void> _escolherHora() async {
    final TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.amber,
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
            ),
          ),
          child: child!,
        );
      },
    );
    if (horaEscolhida != null) {
      setState(() => _horaSelecionada = horaEscolhida);
    }
  }

  void _confirmarAgendamento() {
    if (_servicoIndexSelecionado == null ||
        _dataSelecionada == null ||
        _horaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione um serviço, data e horário.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String servicoNome = _servicos[_servicoIndexSelecionado!]['titulo'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sucesso! $servicoNome agendado.',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RYANZIN BARBER',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Nossos Serviços',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Lista de serviços estilo "Cards"
              Expanded(
                child: ListView.builder(
                  itemCount: _servicos.length,
                  itemBuilder: (context, index) {
                    final isSelected = _servicoIndexSelecionado == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _servicoIndexSelecionado = index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.amber.withOpacity(0.1)
                              : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.amber
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.amber
                                    : Colors.grey.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _servicos[index]['icone'],
                                color: isSelected ? Colors.black : Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _servicos[index]['titulo'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _servicos[index]['preco'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.amber,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Text(
                'Data e Horário',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.amber),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _escolherData,
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.amber,
                        size: 20,
                      ),
                      label: Text(
                        _dataSelecionada == null
                            ? 'Escolher Data'
                            : '${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.amber),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _escolherHora,
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.amber,
                        size: 20,
                      ),
                      label: Text(
                        _horaSelecionada == null
                            ? 'Escolher Hora'
                            : _horaSelecionada!.format(context),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Botão de ação (Call to Action) principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _confirmarAgendamento,
                  child: const Text(
                    'RESERVAR HORÁRIO',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
