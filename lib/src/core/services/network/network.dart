import 'package:flutter_network/flutter_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider(
  (ref) {
    return FlutterNetwork(
      baseUrl: 'https://fakestoreapi.com/',
      tokenCallback: () async {},
    );
  },
);
