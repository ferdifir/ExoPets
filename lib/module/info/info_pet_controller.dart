import 'dart:math';
import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPetController extends GetxController {
  final int id = Get.arguments;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  Map<String, dynamic> pet = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double distance = 0.0;

  @override
  void onInit() async {
    super.onInit();
    getPet();
  }

  getPet() async {
    final String uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.get('/products/product/$uid/$id');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        printInfo(info: result.toString());
        pet = result;
        distance =
            await calculateDistance(result['address']['x'], result['address']['y']);
        update();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<double> calculateDistance(double lat1, double lon1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const double earthRadius = 6371; // in kilometers
    double lat2 = prefs.getDouble('latitude') ?? 0.0;
    double lon2 = prefs.getDouble('longitude') ?? 0.0;

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);

    // Calculate the difference between the latitudes and longitudes
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Apply Haversine formula
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
