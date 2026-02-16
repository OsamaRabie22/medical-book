// [file name]: lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://expansively-nuciform-saran.ngrok-free.dev/api/',
      connectTimeout: Duration(seconds: 500),
      receiveTimeout: Duration(seconds: 300),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true', // ✅ مهم جداً لـ ngrok
        'User-Agent': 'MedicalBook/1.0', // ✅ ضيف ده كمان
      },
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        print("🔵 REQUEST[${options.method}] => ${options.path}");
        print("🔵 Headers: ${options.headers}");
        print("🔵 Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("🟢 RESPONSE[${response.statusCode}]");
        print("🟢 Data: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("🔴 ERROR[${e.response?.statusCode}]");
        print("🔴 Response: ${e.response?.data}");
        return handler.next(e);
      },
    ),
  );

  // ✅ تسجيل مستخدم جديد
  Future<Response> registerPatient(Map<String, dynamic> patientData) async {
    try {
      print("==========================================");
      print("📤 Registering patient");
      print("📤 Data: $patientData");
      print("==========================================");

      final response = await _dio.post(
        'auth/patient/register',
        data: patientData,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print("⚠️ JSON failed with 400, trying FormData...");
        return await _registerWithFormData(patientData);
      }
      rethrow;
    }
  }

  Future<Response> _registerWithFormData(
      Map<String, dynamic> patientData) async {
    try {
      print("📤 Attempt 2: Sending as FormData");
      final formData = FormData.fromMap(patientData);

      final response = await _dio.post(
        'auth/patient/register',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      print("✅ FormData succeeded!");
      return response;
    } catch (e) {
      print("❌ FormData also failed: $e");
      rethrow;
    }
  }

  // تسجيل الدخول
  Future<Response> loginPatient(Map<String, dynamic> loginData) async {
    try {
      final response = await _dio.post('auth/patient/login', data: loginData);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // ✅ إنشاء sick record
  Future<Response> createSickRecord(Map<String, dynamic> sickRecordData) async {
    try {
      print("==========================================");
      print("📤 Creating sick record");
      print("📤 Data: $sickRecordData");
      print("==========================================");

      final response = await _dio.post('patient/sick-record', data: sickRecordData);

      print("✅ Sick record created: ${response.statusCode}");
      return response;
    } on DioException catch (e) {
      print("❌ Sick record creation failed");
      print("❌ Status: ${e.response?.statusCode}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("❌ Sick record error: $e");
      throw Exception('Failed to create sick record: $e');
    }
  }

  // جلب بيانات المريض
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