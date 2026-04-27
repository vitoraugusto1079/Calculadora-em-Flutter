import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraSenai(),
    );
  }
}

class CalculadoraSenai extends StatefulWidget {
  const CalculadoraSenai({super.key});

  @override
  State<CalculadoraSenai> createState() => _CalculadoraSenaiState();
}

class _CalculadoraSenaiState extends State<CalculadoraSenai> {
  String _display = '0';
  double _numeroAnterior = 0;
  String _operacao = '';
  bool _limparDisplay = false;

  void _botaoPressionado(String textoBotao) {
    setState(() {
      if (textoBotao == 'C') {
        _display = '0';
        _numeroAnterior = 0;
        _operacao = '';
      } else if (textoBotao == '+' || textoBotao == '-' || textoBotao == 'x' || textoBotao == '/') {
        _numeroAnterior = double.parse(_display);
        _operacao = textoBotao;
        _limparDisplay = true; // Próximo número digitado vai limpar a tela
      } else if (textoBotao == '=') {
        double numeroAtual = double.parse(_display);
        if (_operacao == '+') _display = (_numeroAnterior + numeroAtual).toString();
        if (_operacao == '-') _display = (_numeroAnterior - numeroAtual).toString();
        if (_operacao == 'x') _display = (_numeroAnterior * numeroAtual).toString();
        if (_operacao == '/') {
          _display = numeroAtual == 0 ? 'Erro' : (_numeroAnterior / numeroAtual).toString();
        }

        if (_display.endsWith('.0')) {
          _display = _display.substring(0, _display.length - 2);
        }
        
        _operacao = '';
        _limparDisplay = true;
      } else {
        if (_display == '0' || _limparDisplay) {
          _display = textoBotao;
          _limparDisplay = false;
        } else {
          _display += textoBotao;
        }
      }
    });
  }

  Widget _construirBotao(String texto, {Color corFundo = const Color(0xFF323232), Color corTexto = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: corFundo,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _botaoPressionado(texto),
          child: Text(
            texto,
            style: TextStyle(fontSize: 28, color: corTexto, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora SENAI",),
        backgroundColor: const Color.fromARGB(255, 231, 21, 21),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Row(
            children: [
              _construirBotao('7'),
              _construirBotao('8'),
              _construirBotao('9'),
              _construirBotao('÷', corFundo: const Color(0xFF2B2B2B)), // Cor levemente diferente para operadores
            ],
          ),
          Row(
            children: [
              _construirBotao('4'),
              _construirBotao('5'),
              _construirBotao('6'),
              _construirBotao('x', corFundo: const Color(0xFF2B2B2B)),
            ],
          ),
          Row(
            children: [
              _construirBotao('1'),
              _construirBotao('2'),
              _construirBotao('3'),
              _construirBotao('-', corFundo: const Color(0xFF2B2B2B)),
            ],
          ),
          Row(
            children: [
              _construirBotao('C', corFundo: Colors.red.shade400, corTexto: Colors.white),
              _construirBotao('0'),
              _construirBotao('=', corFundo: const Color.fromARGB(255, 31, 234, 75), corTexto: Colors.black), // Cor roxinha do botão de igual da sua imagem
              _construirBotao('+', corFundo: const Color(0xFF2B2B2B)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}