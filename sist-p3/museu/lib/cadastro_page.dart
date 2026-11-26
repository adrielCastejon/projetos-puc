import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  final Map<String, String>? registro;

  const Cadastro({super.key, this.registro});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();

  @override
  void initState() {
    super.initState();
    a.text = widget.registro?['a'] ?? '';
    b.text = widget.registro?['b'] ?? '';
    c.text = widget.registro?['c'] ?? '';
  }

  void salvar() {
    if ([a, b, c].any((x) => x.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }
    Navigator.pop(context, {
      'a': a.text.trim(),
      'b': b.text.trim(),
      'c': c.text.trim(),
    });
  }

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.registro == null ? 'Cadastrar' : 'Editar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: a,
            decoration: const InputDecoration(
              labelText: 'Obra',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: b,
            decoration: const InputDecoration(
              labelText: 'Artista',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: c,
            decoration: const InputDecoration(
              labelText: 'Técnica',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: salvar, child: const Text('Salvar')),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
