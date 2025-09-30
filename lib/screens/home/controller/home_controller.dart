import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   var userId = FirebaseAuth.instance.currentUser?.uid;
   var userName = ''.obs;

   // 👇 Observable counts (these go directly into Pie Chart UI)
   var totalCount = 0.obs;
   var normalCount = 0.obs;
   var lowStockCount = 0.obs;
   var expiredCount = 0.obs;


   var medicines = <Map<String, dynamic>>[].obs;

    @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async{

  }
}