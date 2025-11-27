import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/feactures/auth/data/repositories/auth_repository.dart';
import 'package:substrack/feactures/auth/domain/repositories/iauth_repository.dart';
import 'package:substrack/feactures/subscriptions/data/repositories/subscription_repository.dart';
import 'package:substrack/feactures/subscriptions/domain/repositories/isubcription_repository.dart';

final repositoryProviders = [
  // Subscriptions
  RepositoryProvider<ISubscriptionRepository>(
    create: (context) => SubscriptionRepository(
      fireStore: FirebaseFirestore.instance,
      fireAuth: FirebaseAuth.instance,
    ),
  ),

  // Auth
  RepositoryProvider<IAuthRepository>(
    create: (context) => AuthRepository(FirebaseAuth.instance),
  ),
];
