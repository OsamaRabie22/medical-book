// [file name]: lib/providers/patient_provider.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/patient_model.dart';
import '../services/api_service.dart';

class PatientProvider extends ChangeNotifier {
  Patient? _currentPatient;
  bool _isLoading = false;
  String? _error;
  String? _token;

  Patient? get currentPatient => _currentPatient;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  bool get isLoggedIn => _currentPatient != null;

  final ApiService _apiService = ApiService();

  // ✅ تسجيل الدخول وجلب البيانات
  Future<bool> loginAndFetchPatient(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print("🔵 Step 1: Attempting login...");

      // 1. تسجيل الدخول
      final loginResponse = await _apiService.loginPatient({
        'patient_email': email,
        'patient_password': password,
      });

      print("==========================================");
      print("📍 Login Status Code: ${loginResponse.statusCode}");
      print("📍 Login Response Data: ${loginResponse.data}");
      print("==========================================");

      if (loginResponse.statusCode == 200 && loginResponse.data != null) {

        int? patientId;
        String? token;
        String? patientName;
        String? patientEmail;

        if (loginResponse.data is Map) {
          // ✅ استخراج الـ token
          token = loginResponse.data['data']?['token'] ??
              loginResponse.data['token'];

          if (token != null) {
            _token = token;
            print("🔑 Token saved successfully");
          }

          // ✅ استخراج بيانات المريض من الـ response
          var dataSection = loginResponse.data['data'];
          var patientData = dataSection?['patient'];

          if (patientData != null && patientData is Map) {
            patientId = patientData['id'];
            patientName = patientData['name'];
            patientEmail = patientData['email'];

            print("✅ Extracted from login response:");
            print("   - Patient ID: $patientId");
            print("   - Patient Name: $patientName");
            print("   - Patient Email: $patientEmail");
          }
        }

        if (patientId != null) {
          print("🔵 Step 2: Patient ID found: $patientId");
          print("🔵 Step 3: Attempting to fetch full profile...");

          // ✅ محاولة جلب البيانات الكاملة من الـ API
          bool profileFetchedSuccessfully = false;

          try {
            await fetchPatientProfile(patientId);

            // ✅ تحقق لو الـ API رجع بيانات كاملة
            if (_currentPatient != null) {
              print("✅ Profile API call completed");

              // لو في بيانات إضافية (age, phone, city)، يبقى الـ API شغال
              if (_currentPatient!.patientAge != null ||
                  _currentPatient!.patientPhone != null ||
                  _currentPatient!.patientCity != null) {
                print("✅ Full profile loaded with complete data from API");
                profileFetchedSuccessfully = true;
              } else {
                print("⚠️ API returned data but missing details");
              }
            }
          } catch (e) {
            print("⚠️ Exception while fetching profile: $e");
          }

          // ✅ Plan B: لو الـ API فشل أو رجع بيانات ناقصة
          if (!profileFetchedSuccessfully || _currentPatient == null) {
            print("🔵 Step 4: Using basic data from login response (API failed or incomplete)");

            _currentPatient = Patient(
              patientId: patientId,
              patientName: patientName,
              patientEmail: patientEmail,
            );

            print("✅ Patient created with basic info:");
            print("   - ID: ${_currentPatient?.patientId}");
            print("   - Name: ${_currentPatient?.patientName}");
            print("   - Email: ${_currentPatient?.patientEmail}");
          }

          _isLoading = false;
          notifyListeners();
          return _currentPatient != null;

        } else {
          print("❌ No patient ID found in response");
          _error = 'Failed to get patient ID from server';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        print("❌ Login failed with status: ${loginResponse.statusCode}");
        _error = 'Login failed with status ${loginResponse.statusCode}';
        _isLoading = false;
        notifyListeners();
        return false;
      }

    } on DioException catch (e) {
      print("💥 DioException during login: ${e.type}");
      print("💥 Status: ${e.response?.statusCode}");

      if (e.response?.statusCode == 401) {
        _error = 'Invalid email or password';
      } else {
        _error = 'Login failed: ${e.message}';
      }

      _isLoading = false;
      notifyListeners();
      return false;

    } catch (e) {
      print("💥 Exception during login: $e");
      _error = 'Error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ✅ جلب بيانات المريض بالـ ID
  Future<void> fetchPatientProfile(int patientId) async {
    print("==========================================");
    print("🔵 fetchPatientProfile() CALLED with ID: $patientId");
    print("==========================================");

    try {
      print("🔄 Sending GET request to: PatientProfile/$patientId");

      final response = await _apiService.getPatientProfile(patientId);

      print("📍 Profile API Response Status: ${response.statusCode}");
      print("📍 Profile API Response Data: ${response.data}");
      print("📍 Profile API Response Type: ${response.data.runtimeType}");

      // في lib/providers/patient_provider.dart

// في دالة fetchPatientProfile
      if (response.statusCode == 200 && response.data != null) {
        print("✅ Profile API returned 200 OK");

        try {
          _currentPatient = Patient.fromJsonProfile(response.data);
          _error = null;

          print("✅✅✅ Patient object created from API:");
          print("   - ID: ${_currentPatient?.patientId}");
          print("   - Name: ${_currentPatient?.patientName}");
          print("   - Age: ${_currentPatient?.patientAge}"); // هتظهر 0 لو null
          print("   - Gender: ${_currentPatient?.patientGender}"); // هتظهر 'Not specified' لو null
          print("   - Email: ${_currentPatient?.patientEmail}");
          print("   - Phone: ${_currentPatient?.patientPhone}");
          print("   - City: ${_currentPatient?.patientCity}");

          notifyListeners();
        } catch (parseError) {
          print("❌ Error parsing Patient.fromJson: $parseError");
          throw parseError;
        }
      } else {
        print("⚠️ Profile API returned unexpected status: ${response.statusCode}");
        throw Exception('Profile API returned ${response.statusCode}');
      }

    } on DioException catch (e) {
      print("==========================================");
      print("💥💥💥 DioException in fetchPatientProfile:");
      print("💥 Type: ${e.type}");
      print("💥 Status: ${e.response?.statusCode}");
      print("💥 Message: ${e.message}");
      print("💥 Response Data: ${e.response?.data}");
      print("💥 Request URL: ${e.requestOptions.uri}");
      print("💥 Request Path: ${e.requestOptions.path}");
      print("💥 Base URL: ${e.requestOptions.baseUrl}");
      print("==========================================");

      rethrow;

    } catch (e) {
      print("==========================================");
      print("💥💥💥 General Exception in fetchPatientProfile:");
      print("💥 Error: $e");
      print("==========================================");

      rethrow;
    }
  }

  void updatePatient(Patient patient) {
    _currentPatient = patient;
    notifyListeners();
  }

  void logout() {
    _currentPatient = null;
    _token = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}