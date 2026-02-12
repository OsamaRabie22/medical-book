class Validators {
  // التحقق من البريد الإلكتروني
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // التحقق من رقم الهاتف - 11 رقم مصري يبدأ بـ 01
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    final phoneRegex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
    return phoneRegex.hasMatch(phone);
  }

  // التحقق من كلمة المرور - 6-25 حرف
  static bool isValidPassword(String password) {
    if (password.isEmpty) return false;
    return password.length >= 6 && password.length <= 25;
  }

  // التحقق من الاسم - 3-100 حرف
  static bool isValidName(String name) {
    if (name.isEmpty) return false;
    return name.length >= 3 && name.length <= 100;
  }

  // التحقق من المدينة - 3-50 حرف
  static bool isValidCity(String city) {
    if (city.isEmpty) return false;
    return city.length >= 3 && city.length <= 50;
  }

  // التحقق من النوع (M/F)
  static bool isValidGender(String gender) {
    return gender == 'M' || gender == 'F' || gender == 'Male' || gender == 'Female';
  }

  // تحويل النوع لصيغة API
  static String formatGenderForApi(String gender) {
    if (gender == 'Male' || gender == 'M') return 'M';
    if (gender == 'Female' || gender == 'F') return 'F';
    return gender;
  }

  // حساب العمر من تاريخ الميلاد
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // التحقق من تاريخ الميلاد (يجب أن يكون عمره >= 0)
  static bool isValidBirthDate(DateTime? birthDate) {
    if (birthDate == null) return false;
    int age = calculateAge(birthDate);
    return age >= 0 && age <= 120; // عمر منطقي
  }

  // التحقق من الطول - 50-300 سم
  static bool isValidHeight(int height) {
    return height >= 50 && height <= 300;
  }

  // التحقق من الوزن - 1-500 كجم
  static bool isValidWeight(int weight) {
    return weight >= 1 && weight <= 500;
  }

  // التحقق من فصيلة الدم
  static bool isValidBloodType(String bloodType) {
    final validBloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    return validBloodTypes.contains(bloodType);
  }

  // التحقق من الملاحظات - أقصى 500 حرف
  static bool isValidNotes(String? notes) {
    if (notes == null || notes.isEmpty) return true;
    return notes.length <= 500;
  }

  // ---------- Validators للـ Form (مع رسائل الخطأ) ----------

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (!isValidName(value.trim())) {
      return 'Name must be between 3 and 100 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!isValidPhone(value.trim())) {
      return 'Enter a valid Egyptian phone number (11 digits starting with 01)';
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    }
    if (!isValidCity(value.trim())) {
      return 'City must be between 3 and 50 characters';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!isValidPassword(value)) {
      return 'Password must be between 6 and 25 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  static String? validateBirthDate(DateTime? value) {
    if (value == null) {
      return 'Birth date is required';
    }
    if (!isValidBirthDate(value)) {
      return 'Please enter a valid birth date';
    }
    return null;
  }

  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Height is required';
    }
    final height = int.tryParse(value);
    if (height == null) {
      return 'Please enter a valid number';
    }
    if (!isValidHeight(height)) {
      return 'Height must be between 50cm and 300cm';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }
    final weight = int.tryParse(value);
    if (weight == null) {
      return 'Please enter a valid number';
    }
    if (!isValidWeight(weight)) {
      return 'Weight must be between 1kg and 500kg';
    }
    return null;
  }

  static String? validateBloodType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Blood type is required';
    }
    if (!isValidBloodType(value)) {
      return 'Please select a valid blood type';
    }
    return null;
  }

  static String? validateNotes(String? value) {
    if (value != null && !isValidNotes(value)) {
      return 'Notes cannot exceed 500 characters';
    }
    return null;
  }

  // دوال مساعدة
  static bool isNumeric(String? value) {
    if (value == null || value.isEmpty) return false;
    return int.tryParse(value) != null;
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}