// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_cache_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimalCacheEntityCollection on Isar {
  IsarCollection<AnimalCacheEntity> get animalCacheEntitys => this.collection();
}

const AnimalCacheEntitySchema = CollectionSchema(
  name: r'AnimalCacheEntity',
  id: 4798216651067837030,
  properties: {
    r'animalName': PropertySchema(
      id: 0,
      name: r'animalName',
      type: IsarType.string,
    ),
    r'animalNameIndex': PropertySchema(
      id: 1,
      name: r'animalNameIndex',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'jsonData': PropertySchema(
      id: 3,
      name: r'jsonData',
      type: IsarType.string,
    ),
  },

  estimateSize: _animalCacheEntityEstimateSize,
  serialize: _animalCacheEntitySerialize,
  deserialize: _animalCacheEntityDeserialize,
  deserializeProp: _animalCacheEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'animalNameIndex': IndexSchema(
      id: -2847392997646721589,
      name: r'animalNameIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'animalNameIndex',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _animalCacheEntityGetId,
  getLinks: _animalCacheEntityGetLinks,
  attach: _animalCacheEntityAttach,
  version: '3.3.2',
);

int _animalCacheEntityEstimateSize(
  AnimalCacheEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animalName.length * 3;
  bytesCount += 3 + object.animalNameIndex.length * 3;
  bytesCount += 3 + object.jsonData.length * 3;
  return bytesCount;
}

void _animalCacheEntitySerialize(
  AnimalCacheEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animalName);
  writer.writeString(offsets[1], object.animalNameIndex);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.jsonData);
}

AnimalCacheEntity _animalCacheEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimalCacheEntity();
  object.animalName = reader.readString(offsets[0]);
  object.animalNameIndex = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.jsonData = reader.readString(offsets[3]);
  return object;
}

P _animalCacheEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _animalCacheEntityGetId(AnimalCacheEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animalCacheEntityGetLinks(
  AnimalCacheEntity object,
) {
  return [];
}

void _animalCacheEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  AnimalCacheEntity object,
) {
  object.id = id;
}

extension AnimalCacheEntityQueryWhereSort
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QWhere> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimalCacheEntityQueryWhere
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QWhereClause> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  animalNameIndexEqualTo(String animalNameIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'animalNameIndex',
          value: [animalNameIndex],
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterWhereClause>
  animalNameIndexNotEqualTo(String animalNameIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'animalNameIndex',
                lower: [],
                upper: [animalNameIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'animalNameIndex',
                lower: [animalNameIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'animalNameIndex',
                lower: [animalNameIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'animalNameIndex',
                lower: [],
                upper: [animalNameIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AnimalCacheEntityQueryFilter
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QFilterCondition> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'animalName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'animalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'animalName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'animalName', value: ''),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'animalName', value: ''),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'animalNameIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'animalNameIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'animalNameIndex',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'animalNameIndex', value: ''),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  animalNameIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'animalNameIndex', value: ''),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'jsonData',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'jsonData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'jsonData',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'jsonData', value: ''),
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterFilterCondition>
  jsonDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'jsonData', value: ''),
      );
    });
  }
}

extension AnimalCacheEntityQueryObject
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QFilterCondition> {}

extension AnimalCacheEntityQueryLinks
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QFilterCondition> {}

extension AnimalCacheEntityQuerySortBy
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QSortBy> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByAnimalNameIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalNameIndex', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByAnimalNameIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalNameIndex', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  sortByJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.desc);
    });
  }
}

extension AnimalCacheEntityQuerySortThenBy
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QSortThenBy> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByAnimalNameIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalNameIndex', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByAnimalNameIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalNameIndex', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.asc);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QAfterSortBy>
  thenByJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.desc);
    });
  }
}

extension AnimalCacheEntityQueryWhereDistinct
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QDistinct> {
  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QDistinct>
  distinctByAnimalName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QDistinct>
  distinctByAnimalNameIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'animalNameIndex',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QDistinct>
  distinctByJsonData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jsonData', caseSensitive: caseSensitive);
    });
  }
}

extension AnimalCacheEntityQueryProperty
    on QueryBuilder<AnimalCacheEntity, AnimalCacheEntity, QQueryProperty> {
  QueryBuilder<AnimalCacheEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimalCacheEntity, String, QQueryOperations>
  animalNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalName');
    });
  }

  QueryBuilder<AnimalCacheEntity, String, QQueryOperations>
  animalNameIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalNameIndex');
    });
  }

  QueryBuilder<AnimalCacheEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AnimalCacheEntity, String, QQueryOperations> jsonDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jsonData');
    });
  }
}
