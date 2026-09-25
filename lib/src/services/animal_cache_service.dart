import 'dart:convert';

import 'package:isar_community/isar.dart';

import '../data/local/animal_cache_entity.dart';

class AnimalCacheService {
  const AnimalCacheService(this._isar);

  final Isar _isar;

  Future<Map<String, dynamic>?> getFromCache(String animalName) async {
    final cached = await _isar.animalCacheEntitys
        .filter()
        .animalNameEqualTo(animalName)
        .findFirst();

    if (cached == null) {
      return null;
    }

    final now = DateTime.now();
    final ttlDuration = Duration(days: 30);
    final isExpired = now.difference(cached.createdAt) > ttlDuration;

    if (isExpired) {
      await _isar.writeTxn(() async {
        await _isar.animalCacheEntitys.delete(cached.id);
      });
      return null;
    }

    try {
      return jsonDecode(cached.jsonData) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveToCache(String animalName, Map<String, dynamic> data) async {
    final existing = await _isar.animalCacheEntitys
        .filter()
        .animalNameEqualTo(animalName)
        .findFirst();

    if (existing != null) {
      await _isar.writeTxn(() async {
        await _isar.animalCacheEntitys.delete(existing.id);
      });
    }

    final cacheEntry = AnimalCacheEntity()
      ..animalName = animalName
      ..animalNameIndex = animalName
      ..jsonData = jsonEncode(data)
      ..createdAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.animalCacheEntitys.put(cacheEntry);
    });
  }

  Future<void> clearCache() async {
    await _isar.writeTxn(() async {
      await _isar.animalCacheEntitys.clear();
    });
  }
}
