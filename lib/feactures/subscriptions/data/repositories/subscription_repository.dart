import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/domain/repositories/isubcription_repository.dart';

class SubscriptionRepository extends ISubscriptionRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _fireAuth;

  SubscriptionRepository({
    required FirebaseFirestore fireStore,
    required FirebaseAuth fireAuth,
  }) : _fireStore = fireStore,
       _fireAuth = fireAuth;

  @override
  Future<void> addSubscription({
    required SubscriptionModel newSubscription,
  }) async {
    try {
      final User? user = _fireAuth.currentUser;
      if (user == null) throw Exception('Usuario no autenticado');
      final docRef = _fireStore.collection('subscriptions').doc();

      final subscriptionToSave = newSubscription.copyWith(
        id: docRef.id,
        userId: user.uid,
        status: 'active',
      );

      await docRef.set(subscriptionToSave.toFirestore());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubscriptionModel?> fetchSubscription({required String id}) async {
    try {
      final docSnapshot = await _fireStore
          .collection('subscriptions')
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        return SubscriptionModel.fromSnapshot(docSnapshot);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionModel>> fetchSubscriptions() async {
    final String? uid = _fireAuth.currentUser?.uid;
    if (uid == null) {
      return [];
    }

    final querySnapshot = await _fireStore
        .collection('subscriptions')
        .where('userId', isEqualTo: uid)
        .get();

    final List<SubscriptionModel> subsList = querySnapshot.docs
        .map((doc) => SubscriptionModel.fromSnapshot(doc))
        .toList();

    return subsList;
  }

  @override
  Future<void> removeSubscription({required String id}) async {
    await _fireStore.collection('subscriptions').doc(id).delete();
  }

  @override
  Future<void> editSubscription({
    required SubscriptionModel subscription,
  }) async {
    try {
      if (subscription.id == null || subscription.id!.isEmpty) {
        throw Exception('No se puede editar una suscripción sin ID');
      }

      final docRef = _fireStore
          .collection('subscriptions')
          .doc(subscription.id);

      await docRef.update(subscription.toFirestore());
    } catch (e) {
      rethrow;
    }
  }
}
