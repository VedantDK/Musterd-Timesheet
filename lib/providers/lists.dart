//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

//Project Packages
import 'package:timesheet/models/list.dart';

Future<Database> _getTodoDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final dbTodo = await sql.openDatabase(
    path.join(dbpath, 'todo.db'),
    onCreate: (dbTodo, version) {
      return dbTodo.execute(
        'CREATE TABLE todo_list(id TEXT PRIMARY KEY, item TEXT)'
      );
    },
    version: 1,
  );
  return dbTodo;
}

Future<Database> _getPendingDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final dbPending = await sql.openDatabase(
    path.join(dbpath, 'pending.db'),
    onCreate: (dbPending, version) {
      return dbPending.execute(
        'CREATE TABLE pending_list(id TEXT PRIMARY KEY, item TEXT)'
      );
    },
    version: 1,
  );
  return dbPending;
}

Future<Database> _getCompletedDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final dbCompleted = await sql.openDatabase(
    path.join(dbpath, 'completed.db'),
    onCreate: (dbCompleted, version) {
      return dbCompleted.execute(
        'CREATE TABLE completed_list(id TEXT PRIMARY KEY, item TEXT)'
      );
    },
    version: 1,
  );
  return dbCompleted;
}

class TodoListNotifier extends StateNotifier<List<TodoListItems>> {
  TodoListNotifier() : super(const []);

  Future<void> loadTodoList() async {
    final db = await _getTodoDatabase();
    final data = await db.query('todo_list');
    final todoItems = data.map(
      (row) => TodoListItems(
        id: row['id'] as String,
        item: row['item'] as String,
      )
    ).toList();
    state = todoItems;
  }

  void addItem(String item) async { 
    final newItem = TodoListItems(item: item);
    final db = await _getTodoDatabase();
    db.insert('todo_list', {
      'id': newItem.id,
      'item': newItem.item,
    }
    );

    state = [newItem, ...state];
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<TodoListItems>>(
  (ref) => TodoListNotifier(),
);

class PendingListNotifier extends StateNotifier<List<PendingListItems>> {
  PendingListNotifier() : super(const []);

  Future<void> loadPendingList() async {
    final db = await _getPendingDatabase();
    final data = await db.query('pending_list');
    final pendingItems = data.map(
      (row) => PendingListItems(
        id: row['id'] as String,
        item: row['item'] as String,
      )
    ).toList();
    state = pendingItems;
  }

  void addItem(String item) async { 
    final newItem = PendingListItems(item: item);
    final db = await _getPendingDatabase();
    db.insert('pending_list', {
      'id': newItem.id,
      'item': newItem.item,
    }
    );

    state = [newItem, ...state];
  }
}

final pendingListProvider = StateNotifierProvider<PendingListNotifier, List<PendingListItems>>(
  (ref) => PendingListNotifier(),
);

class CompletedListNotifier extends StateNotifier<List<CompletedListItems>> {
  CompletedListNotifier() : super(const []);

  Future<void> loadCompletedList() async {
    final db = await _getCompletedDatabase();
    final data = await db.query('completed_list');
    final completedItems = data.map(
      (row) => CompletedListItems(
        id: row['id'] as String,
        item: row['item'] as String,
      )
    ).toList();
    state = completedItems;
  }

  void addItem(String item) async { 
    final newItem = CompletedListItems(item: item);
    final db = await _getCompletedDatabase();
    db.insert('completed_list', {
      'id': newItem.id,
      'item': newItem.item,
    }
    );

    state = [newItem, ...state];
  }
}

final completedListProvider = StateNotifierProvider<CompletedListNotifier, List<CompletedListItems>>(
  (ref) => CompletedListNotifier(),
);