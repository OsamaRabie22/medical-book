// dummy_data.dart
import '../models/doctor_model.dart';
import 'package:flutter/material.dart';

// List of dummy doctors
List<Doctor> dummyDoctors = [
  Doctor(
    name: "Dr. Osama Rabie",
    specialty: "Dermatology",
    location: "Cairo – Maadi",
    contact: "01012345678",
    rating: 4.9,
    image:
    "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
    availableTimes: ["Monday 9 AM - 12 PM", "Wednesday 2 PM - 5 PM"],
    consultationFee: 250.0,
    isSaved: false, // Default isSaved to false
  ),
  Doctor(
    name: "Dr. Sara Mohamed",
    specialty: "Dermatologist",
    location: "Cairo – Nasr City",
    contact: "01087654321",
    rating: 4.8,
    image: "assets/images/doctors/Sara-Mohamed.jpg",
    availableTimes: ["Tuesday 10 AM - 1 PM", "Thursday 3 PM - 6 PM"],
    consultationFee: 300.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Khaled Omar",
    specialty: "Surgeon",
    location: "Alexandria",
    contact: "01011223344",
    rating: 4.7,
    image: "assets/images/doctors/Khaled-Omar.jpg",
    availableTimes: ["Monday 1 PM - 4 PM", "Friday 10 AM - 2 PM"],
    consultationFee: 500.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Ahmed Hassan",
    specialty: "Orthopedic",
    location: "Cairo – Zamalek",
    contact: "01022334455",
    rating: 4.9,
    image: "assets/images/doctors/Ahmed-Hassan.jpg",
    availableTimes: ["Sunday 8 AM - 1 PM", "Thursday 4 PM - 7 PM"],
    consultationFee: 350.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Mona Samy",
    specialty: "Dentist",
    location: "Cairo – Heliopolis",
    contact: "01033445566",
    rating: 4.9,
    image: "assets/images/doctors/Mona-Samy.jpg",
    availableTimes: ["Monday 10 AM - 2 PM", "Friday 3 PM - 5 PM"],
    consultationFee: 200.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Omar Ibrahim",
    specialty: "Neurologist",
    location: "Cairo – Mohandessin",
    contact: "01044556677",
    rating: 4.8,
    image: "assets/images/doctors/Omar-Ibrahim.jpg",
    availableTimes: ["Tuesday 9 AM - 12 PM", "Wednesday 4 PM - 6 PM"],
    consultationFee: 400.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Tamer Ali",
    specialty: "Pediatrician",
    location: "Cairo – Nasr City",
    contact: "01055667788",
    rating: 4.5,
    image: "assets/images/doctors/Tamer-Ali.jpg",
    availableTimes: ["Monday 1 PM - 3 PM", "Thursday 5 PM - 8 PM"],
    consultationFee: 250.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Ahmed Zaki",
    specialty: "Psychologist",
    location: "Cairo – Maadi",
    contact: "01066778899",
    rating: 4.8,
    image: "assets/images/doctors/Ahmed-Zaki.jpg",
    availableTimes: ["Tuesday 8 AM - 12 PM", "Saturday 1 PM - 4 PM"],
    consultationFee: 300.0,
    isSaved: false,
  ),
  Doctor(
    name: "Dr. Yasser El-Feky",
    specialty: "General Physician",
    location: "Cairo – Shobra",
    contact: "01077889900",
    rating: 4.7,
    image: "assets/images/doctors/Yasser-El-Feky.jpg",
    availableTimes: ["Sunday 9 AM - 1 PM", "Wednesday 3 PM - 6 PM"],
    consultationFee: 150.0,
    isSaved: true,
  ),
  Doctor(
    name: "Dr. Nada Ahmed",
    specialty: "Gynaecologist",
    location: "Cairo – Heliopolis",
    contact: "01088990011",
    rating: 4.9,
    image: "assets/images/doctors/Nada-Ahmed.jpg",
    availableTimes: ["Monday 10 AM - 1 PM", "Thursday 2 PM - 4 PM"],
    consultationFee: 350.0,
    isSaved: false,
  ),
  // أضف باقي الأطباء هنا لتصل إلى 20 دكتورًا...
];

// List of dummy bookings
// List of dummy bookings
List<Booking> dummyBookings = [
  Booking(
    doctorName: dummyDoctors[0].name,
    specialty: dummyDoctors[0].specialty,
    doctorImage: dummyDoctors[0].image,
    status: "Completed",
    statusColor: Colors.green,
    statusBackground: Colors.green.shade100,
    date: "2023-12-12",
    time: "9:00 AM",
    location: "Cairo – Maadi",
    consultationFee: dummyDoctors[0].consultationFee,
    isSaved: false,
    rating: dummyDoctors[0].rating,
  ),
  Booking(
    doctorName: dummyDoctors[1].name,
    specialty: dummyDoctors[1].specialty,
    doctorImage: dummyDoctors[1].image,
    status: "Pending",
    statusColor: Colors.orange,
    statusBackground: Colors.orange.shade100,
    date: "2023-12-13",
    time: "10:30 AM",
    location: "Cairo – Nasr City",
    consultationFee: dummyDoctors[1].consultationFee,
    isSaved: false,
    rating: dummyDoctors[1].rating,
  ),
  Booking(
    doctorName: dummyDoctors[2].name,
    specialty: dummyDoctors[2].specialty,
    doctorImage: dummyDoctors[2].image,
    status: "Completed",
    statusColor: Colors.green,
    statusBackground: Colors.green.shade100,
    date: "2023-12-14",
    time: "2:00 PM",
    location: "Alexandria",
    consultationFee: dummyDoctors[2].consultationFee,
    isSaved: false,
    rating: dummyDoctors[2].rating,
  ),
  Booking(
    doctorName: dummyDoctors[3].name,
    specialty: dummyDoctors[3].specialty,
    doctorImage: dummyDoctors[3].image,
    status: "Cancelled", // New booking with Cancelled status
    statusColor: Colors.red,
    statusBackground: Colors.red.shade100,
    date: "2023-12-15",
    time: "11:00 AM",
    location: "Cairo – Zamalek",
    consultationFee: dummyDoctors[3].consultationFee,
    isSaved: false,
    rating: dummyDoctors[3].rating,
  ),
  Booking(
    doctorName: dummyDoctors[4].name,
    specialty: dummyDoctors[4].specialty,
    doctorImage: dummyDoctors[4].image,
    status: "Cancelled", // New booking with Cancelled status
    statusColor: Colors.red,
    statusBackground: Colors.red.shade100,
    date: "2023-12-16",
    time: "3:00 PM",
    location: "Cairo – Heliopolis",
    consultationFee: dummyDoctors[4].consultationFee,
    isSaved: false,
    rating: dummyDoctors[4].rating,
  ),
];


// List of dummy payment confirmations
List<PaymentConfirmation> dummyPaymentConfirmations = [
  PaymentConfirmation(
    booking: dummyBookings[0], // Link to the first booking
    status: "Confirmed",
  ),
  PaymentConfirmation(
    booking: dummyBookings[1], // Link to the second booking
    status: "Pending",
  ),
  PaymentConfirmation(
    booking: dummyBookings[2], // Link to the third booking
    status: "Completed",
  ),
  // أضف المزيد من تأكيدات الدفع حسب الحاجة...
];
