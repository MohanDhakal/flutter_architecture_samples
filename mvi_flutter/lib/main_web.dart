// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:key_value_store_web/key_value_store_web.dart';
import 'package:mvi_base/mvi_base.dart';
import 'package:mvi_flutter_sample/run_mvi_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MviApp(
    todosRepository: TodosInteractor(
      ReactiveTodosRepositoryFlutter(
        repository: LocalStorageRepository(
          localStorage: LocalStorage(
            'mvi_flutter',
            WebKeyValueStore(window.localStorage),
          ),
        ),
      ),
    ),
    userInteractor: UserInteractor(AnonymousUserRepository()),
  ));
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}
