import 'package:flutter/foundation.dart';

/// از هر جای برنامه می‌توان `value` آن را تغییر داد و هر کسی که گوش دهد، دستور را دریافت می‌کند.
final commandBus = ValueNotifier<String>('');