import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/user_profile.dart';

class UserProfileRepository {
  final FirebaseFirestore firestore;

  UserProfileRepository({required this.firestore});

  Future<void> saveUserProfile(UserProfile userProfile) async {
    try {
      await firestore
          .collection('user_profiles')
          .doc(userProfile.name)
          .set(userProfile.toMap());
    } catch (e) {
      throw Exception('Failed to save user profile');
    }
  }

  Future<UserProfile?> loadUserProfile(String email) async {
    try {
      final querySnapshot = await firestore
          .collection('user_profiles')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();

        return UserProfile.fromMap(data);
      } else {
        return null; // No matching profile found
      }
    } catch (e) {
      throw Exception('Failed to load user profile');
    }
  }
}
