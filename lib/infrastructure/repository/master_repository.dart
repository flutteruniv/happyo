import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happyo/model/master.dart';

class MasterRepository {
  final _masterRef = FirebaseFirestore.instance.collection('master');
  static MasterRepository? _instance;
  static Master? _master;

  static MasterRepository get instance {
    return _instance ?? MasterRepository();
  }

  Future<void> initialie(String version) async {
    final snapshot = await _masterRef.doc(version).get();
    if (snapshot.exists) {
      _master = Master.fromJson(snapshot.data()!);
    }
  }

  Master get master {
    return _master ?? Master();
  }
}
