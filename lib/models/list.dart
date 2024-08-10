//External Packages
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TodoListItems {
  TodoListItems({
    required this.item,
    String? id,
  }) : id = id ?? ('todo${uuid.v4()}');

  final String id;
  final String item;
}

class PendingListItems {
  PendingListItems({
    required this.item,
    String? id,
  }) : id = id ?? ('pending${uuid.v4()}');

  final String id;
  final String item;
}

class CompletedListItems {
  CompletedListItems({
    required this.item,
    String? id,
  }) : id = id ?? ('completed${uuid.v4()}');

  final String id;
  final String item;
}