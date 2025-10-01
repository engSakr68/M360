
import 'package:flutter/material.dart';
import 'openpath_service.dart';

class OpenpathCardScreen extends StatefulWidget {
  const OpenpathCardScreen({super.key});
  @override
  State<OpenpathCardScreen> createState() => _OpenpathCardScreenState();
}
class _OpenpathCardScreenState extends State<OpenpathCardScreen> {
  final _controller = TextEditingController();
  Map<String,dynamic>? _credential;
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpenPath Credential')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Setup Mobile Token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _provision,
              child: _loading ? const CircularProgressIndicator() : const Text('Provision'),
            ),
            const SizedBox(height: 24),
            if (_credential != null)
              Card(
                child: ListTile(
                  title: Text('Credential ID: ${_credential!['credentialId']}'),
                  subtitle: Text('Type: ${_credential!['type']}'),
                ),
              ),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const Spacer(),
            TextButton(
              onPressed: OpenpathService.unprovision,
              child: const Text('Unprovision'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _provision() async {
    setState(() { _loading = true; _error = null; });
    try {
      final cred = await OpenpathService.provision(_controller.text.trim());
      setState(() => _credential = cred);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }
}
