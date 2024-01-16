import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/transfer_sponsorship_controller.dart';

class TransferSponsorshipView extends GetView<TransferSponsorshipController> {
  const TransferSponsorshipView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        title: const Text('TransferSponsorshipView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransferSponsorshipView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
