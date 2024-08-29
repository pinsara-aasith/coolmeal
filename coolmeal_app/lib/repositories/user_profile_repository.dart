import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileRepository {
  final FirebaseFirestore firestore;
  UserProfile? _userProfile;

  UserProfileRepository({required this.firestore});
  UserProfile? get userProfile => _userProfile;

  Future<void> saveUserProfile(UserProfile userProfile) async {
    try {
      await firestore
          .collection('user_profiles')
          .doc(userProfile.name)
          .set(userProfile.toMap());

      await loadUserProfile(FirebaseAuth.instance.currentUser?.email ?? '');
    
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

        _userProfile = UserProfile.fromMap(data);
        return _userProfile;
      } else {
        return null; // No matching profile found
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load user profile');
    }
  }
}
