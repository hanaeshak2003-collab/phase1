import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double _heightCm = 170;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _heightCm.toInt().toString();
  }

  String get _ftIn {
    final totalInches = _heightCm / 2.54;
    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();
    return "${feet}\'${inches}\"";
  }

  void _onTextChanged(String v) {
    final parsed = int.tryParse(v);
    if (parsed != null) {
      final clamped = parsed.clamp(100, 220).toDouble();
      setState(() => _heightCm = clamped);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.value = _textController.value.copyWith(text: _heightCm.toInt().toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "What's your Height?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("This helps us calculate accurately"),
            const SizedBox(height: 40),

            // Slider + display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Height: ${_heightCm.toInt()} cm  •  $_ftIn"),
                const SizedBox(height: 12),
                Slider(
                  min: 100,
                  max: 220,
                  value: _heightCm,
                  onChanged: (v) => setState(() {
                    _heightCm = v;
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "cm",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onChanged: _onTextChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(_ftIn),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // TODO: pass height to next step or save it
                Navigator.pop(context);
              },
              child: const Text("Next", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
