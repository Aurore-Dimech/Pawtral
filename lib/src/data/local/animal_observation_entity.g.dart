// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_observation_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimalObservationEntityCollection on Isar {
  IsarCollection<AnimalObservationEntity> get animalObservationEntitys =>
      this.collection();
}

const AnimalObservationEntitySchema = CollectionSchema(
  name: r'AnimalObservationEntity',
  id: -6588131859535536566,
  properties: {
    r'animalName': PropertySchema(
      id: 0,
      name: r'animalName',
      type: IsarType.string,
    ),
    r'cachedImagePath': PropertySchema(
      id: 1,
      name: r'cachedImagePath',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'imagePath': PropertySchema(
      id: 3,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isSynchronized': PropertySchema(
      id: 4,
      name: r'isSynchronized',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 5,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 6,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'remoteId': PropertySchema(
      id: 7,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(id: 8, name: r'userId', type: IsarType.string),
  },

  estimateSize: _animalObservationEntityEstimateSize,
  serialize: _animalObservationEntitySerialize,
  deserialize: _animalObservationEntityDeserialize,
  deserializeProp: _animalObservationEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _animalObservationEntityGetId,
  getLinks: _animalObservationEntityGetLinks,
  attach: _animalObservationEntityAttach,
  version: '3.3.2',
);

int _animalObservationEntityEstimateSize(
  AnimalObservationEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animalName.length * 3;
  {
    final value = object.cachedImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _animalObservationEntitySerialize(
  AnimalObservationEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animalName);
  writer.writeString(offsets[1], object.cachedImagePath);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.imagePath);
  writer.writeBool(offsets[4], object.isSynchronized);
  writer.writeDouble(offsets[5], object.latitude);
  writer.writeDouble(offsets[6], object.longitude);
  writer.writeString(offsets[7], object.remoteId);
  writer.writeString(offsets[8], object.userId);
}

AnimalObservationEntity _animalObservationEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimalObservationEntity();
  object.animalName = reader.readString(offsets[0]);
  object.cachedImagePath = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.imagePath = reader.readString(offsets[3]);
  object.isSynchronized = reader.readBool(offsets[4]);
  object.latitude = reader.readDoubleOrNull(offsets[5]);
  object.longitude = reader.readDoubleOrNull(offsets[6]);
  object.remoteId = reader.readString(offsets[7]);
  object.userId = reader.readString(offsets[8]);
  return object;
}

P _animalObservationEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _animalObservationEntityGetId(AnimalObservationEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animalObservationEntityGetLinks(
  AnimalObservationEntity object,
) {
  return [];
}

void _animalObservationEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  AnimalObservationEntity object,
) {
  object.id = id;
}

extension AnimalObservationEntityQueryWhereSort
    on QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QWhere> {
  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimalObservationEntityQueryWhere
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QWhereClause
        > {
  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterWhereClause
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterWhereClause
  >
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
}

extension AnimalObservationEntityQueryFilter
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QFilterCondition
        > {
  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  animalNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'animalName', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  animalNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'animalName', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cachedImagePath'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cachedImagePath'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedImagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'cachedImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'cachedImagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedImagePath', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  cachedImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'cachedImagePath', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  isSynchronizedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isSynchronized', value: value),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'latitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'longitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<
    AnimalObservationEntity,
    AnimalObservationEntity,
    QAfterFilterCondition
  >
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension AnimalObservationEntityQueryObject
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QFilterCondition
        > {}

extension AnimalObservationEntityQueryLinks
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QFilterCondition
        > {}

extension AnimalObservationEntityQuerySortBy
    on QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QSortBy> {
  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByCachedImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedImagePath', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByCachedImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedImagePath', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByIsSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronized', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByIsSynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronized', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension AnimalObservationEntityQuerySortThenBy
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QSortThenBy
        > {
  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByAnimalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByAnimalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalName', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByCachedImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedImagePath', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByCachedImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedImagePath', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByIsSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronized', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByIsSynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronized', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QAfterSortBy>
  thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension AnimalObservationEntityQueryWhereDistinct
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QDistinct
        > {
  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByAnimalName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByCachedImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'cachedImagePath',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByIsSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynchronized');
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalObservationEntity, AnimalObservationEntity, QDistinct>
  distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension AnimalObservationEntityQueryProperty
    on
        QueryBuilder<
          AnimalObservationEntity,
          AnimalObservationEntity,
          QQueryProperty
        > {
  QueryBuilder<AnimalObservationEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimalObservationEntity, String, QQueryOperations>
  animalNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalName');
    });
  }

  QueryBuilder<AnimalObservationEntity, String?, QQueryOperations>
  cachedImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedImagePath');
    });
  }

  QueryBuilder<AnimalObservationEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AnimalObservationEntity, String, QQueryOperations>
  imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<AnimalObservationEntity, bool, QQueryOperations>
  isSynchronizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynchronized');
    });
  }

  QueryBuilder<AnimalObservationEntity, double?, QQueryOperations>
  latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<AnimalObservationEntity, double?, QQueryOperations>
  longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<AnimalObservationEntity, String, QQueryOperations>
  remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<AnimalObservationEntity, String, QQueryOperations>
  userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
