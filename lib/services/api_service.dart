// [file name]: lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://expansively-nuciform-saran.ngrok-free.dev/api/',
      connectTimeout: Duration(seconds: 500),
      receiveTimeout: Duration(seconds: 300),
    ),
  );

  // تسجيل مستخدم جديد
  Future<Response> registerPatient(Map<String, dynamic> patientData) async {
    try {
      final response = await _dio.post('auth/patient/register', data: patientData);
      return response;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  // تسجيل الدخول للمريض
  Future<Response> loginPatient(Map<String, dynamic> loginData) async {
    try {
      final response = await _dio.post('auth/patient/login', data: loginData);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // ✅ إضافة sick record بعد التسجيل
  Future<Response> createSickRecord(Map<String, dynamic> sickRecordData) async {
    try {
      final response = await _dio.post('patient/sick-record', data: sickRecordData);
      return response;
    } catch (e) {
      throw Exception('Failed to create sick record: $e');
    }
  }
  // ✅ إضافة في ApiService
  // في lib/services/api_service.dart

  Future<Response> getPatientProfile(int patientId) async {
    try {
      print("🌐 API CALL: GET PatientProfile/$patientId");
      final response = await _dio.get('PatientProfile/$patientId');
      print("🌐 API RESPONSE: ${response.statusCode}");
      return response;
    } catch (e) {
      print("💥 API ERROR: $e");
      if (e is DioException) {
        print("💥 DioException Type: ${e.type}");
        print("💥 DioException Response: ${e.response?.data}");
      }
      throw Exception('Failed to fetch patient profile: $e');
    }
  }
}