import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var userName = ''.obs;

  // Observable counts (these go directly into Pie Chart UI)
  var totalCount = 0.obs;
  var normalCount = 0.obs;
  var lowStockCount = 0.obs;
  var expiredCount = 0.obs;
  DateTime now = DateTime.now();
  late DateTime today = DateTime(now.year, now.month, now.day);

  int lowStockThresholdPercentage = 20; // Define low stock threshold (20%)

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  void fetchMedicines() {
    _firestore
        .collection("user")
        .doc(userId)
        .collection("medicines")
        .snapshots()
        .listen((snapshot) {
          int total = snapshot.docs.length;
          int normal = 0;
          int lowStock = 0;
          int expired = 0;

          for (var doc in snapshot.docs) {
            var data = doc.data();
            int qty = int.tryParse(data['quantity']?.toString() ?? '0') ?? 0;
            int size = int.tryParse(data['bottleSize']?.toString() ?? '0') ?? 0;
            DateTime expiry = _parseExpiryDate(data['expiryDate']);
            DateTime expiryDateOnly = DateTime(expiry.year, expiry.month, expiry.day);

            // Expiry check: expired if date is before OR equal to today
            if (expiryDateOnly.isBefore(today) || expiryDateOnly == today) {
              expired++;
            }
            // Low stock check (<= 20% of bottle size)
            else if (qty <= (size * lowStockThresholdPercentage / 100)) {
              lowStock++;
            }
            //Other normal stock
            else {
              normal++;
            }
          }
          // Update observable counts
          totalCount.value = total;
          normalCount.value = normal;
          lowStockCount.value = lowStock;
          expiredCount.value = expired;
        });
  }

  DateTime _parseExpiryDate(dynamic expiryData) {
    if (expiryData == null) return DateTime(2100);

    // Handle Firestore Timestamp
    if (expiryData is Timestamp) {
      return expiryData.toDate();
    }

    // Handle String in dd-mm-yyyy format
    if (expiryData is String) {
      String dateStr = expiryData.trim();

      // Try parsing dd-mm-yyyy format (your format: "28-9-2025")
      if (dateStr.contains('-')) {
        List<String> parts = dateStr.split('-');
        if (parts.length == 3) {
          try {
            int day = int.parse(parts[0]);
            int month = int.parse(parts[1]);
            int year = int.parse(parts[2]);
            return DateTime(year, month, day);
          } catch (e) {
            print("Error parsing date: $dateStr");
          }
        }
      }

      // Fallback: try ISO format
      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        print("Error parsing ISO date: $dateStr");
      }
    }

    return DateTime(2100); // Default fallback
  }
}
