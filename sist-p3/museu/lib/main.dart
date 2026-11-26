import 'package:flutter/material.dart';
import 'cadastro_page.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lista(),
    ));

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final List<Map<String, String>> dados = [];

  Future<void> abrir([int? i]) async {
    final resultado = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => Cadastro(
          registro: i == null ? null : dados[i],
        ),
      ),
    );
    if (!mounted || resultado == null) return;
    setState(() {
      if (i == null) {
        dados.add(resultado);
      } else {
        dados[i] = resultado;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Museu'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrir(),
        child: const Icon(Icons.add),
      ),
      body: dados.isEmpty
          ? const Center(child: Text('Nenhum registro'))
          : ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, i) {
                final r = dados[i];
                return ListTile(
                  title: Text(r['a']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r['b']!),
                      Text(r['c']!),
                    ],
                  ),
                  onTap: () => abrir(i),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() => dados.removeAt(i));
                    },
                  ),
                );
              },
            ),
    );
  }
}
