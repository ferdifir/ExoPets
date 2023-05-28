import 'package:exopets/module/cs/cs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSupport extends StatelessWidget {
  CustomerSupport({super.key});

  final TextEditingController _messageController = TextEditingController();
  final controller = Get.put(CsController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CsController>(
      init: CsController(),
      initState: (_) {},
      builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Customer Support'),
          ),
          body: Container(
            margin: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Laporkan masalah anda disini',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _messageController,
                    maxLines: 5,
                    validator: (value) =>
                        value!.isEmpty ? 'Pesan tidak boleh kosong' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Masukkan Pesan',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.sendReport(_messageController.text);
                        _messageController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Kirim'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
