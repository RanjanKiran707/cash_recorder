// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBillCollection on Isar {
  IsarCollection<Bill> get bills => this.collection();
}

const BillSchema = CollectionSchema(
  name: r'Bill',
  id: 7031121081258233164,
  properties: {
    r'billName': PropertySchema(
      id: 0,
      name: r'billName',
      type: IsarType.string,
    ),
    r'content': PropertySchema(
      id: 1,
      name: r'content',
      type: IsarType.objectList,
      target: r'Particular',
    )
  },
  estimateSize: _billEstimateSize,
  serialize: _billSerialize,
  deserialize: _billDeserialize,
  deserializeProp: _billDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'parentBill': LinkSchema(
      id: -7852874788767372768,
      name: r'parentBill',
      target: r'Bill',
      single: true,
    )
  },
  embeddedSchemas: {r'Particular': ParticularSchema},
  getId: _billGetId,
  getLinks: _billGetLinks,
  attach: _billAttach,
  version: '3.1.0+1',
);

int _billEstimateSize(
  Bill object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.billName.length * 3;
  bytesCount += 3 + object.content.length * 3;
  {
    final offsets = allOffsets[Particular]!;
    for (var i = 0; i < object.content.length; i++) {
      final value = object.content[i];
      bytesCount += ParticularSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _billSerialize(
  Bill object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.billName);
  writer.writeObjectList<Particular>(
    offsets[1],
    allOffsets,
    ParticularSchema.serialize,
    object.content,
  );
}

Bill _billDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Bill();
  object.billName = reader.readString(offsets[0]);
  object.content = reader.readObjectList<Particular>(
        offsets[1],
        ParticularSchema.deserialize,
        allOffsets,
        Particular(),
      ) ??
      [];
  object.id = id;
  return object;
}

P _billDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<Particular>(
            offset,
            ParticularSchema.deserialize,
            allOffsets,
            Particular(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _billGetId(Bill object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _billGetLinks(Bill object) {
  return [object.parentBill];
}

void _billAttach(IsarCollection<dynamic> col, Id id, Bill object) {
  object.id = id;
  object.parentBill.attach(col, col.isar.collection<Bill>(), r'parentBill', id);
}

extension BillQueryWhereSort on QueryBuilder<Bill, Bill, QWhere> {
  QueryBuilder<Bill, Bill, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BillQueryWhere on QueryBuilder<Bill, Bill, QWhereClause> {
  QueryBuilder<Bill, Bill, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Bill, Bill, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BillQueryFilter on QueryBuilder<Bill, Bill, QFilterCondition> {
  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'billName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'billName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'billName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billName',
        value: '',
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> billNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'billName',
        value: '',
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BillQueryObject on QueryBuilder<Bill, Bill, QFilterCondition> {
  QueryBuilder<Bill, Bill, QAfterFilterCondition> contentElement(
      FilterQuery<Particular> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'content');
    });
  }
}

extension BillQueryLinks on QueryBuilder<Bill, Bill, QFilterCondition> {
  QueryBuilder<Bill, Bill, QAfterFilterCondition> parentBill(
      FilterQuery<Bill> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parentBill');
    });
  }

  QueryBuilder<Bill, Bill, QAfterFilterCondition> parentBillIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parentBill', 0, true, 0, true);
    });
  }
}

extension BillQuerySortBy on QueryBuilder<Bill, Bill, QSortBy> {
  QueryBuilder<Bill, Bill, QAfterSortBy> sortByBillName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billName', Sort.asc);
    });
  }

  QueryBuilder<Bill, Bill, QAfterSortBy> sortByBillNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billName', Sort.desc);
    });
  }
}

extension BillQuerySortThenBy on QueryBuilder<Bill, Bill, QSortThenBy> {
  QueryBuilder<Bill, Bill, QAfterSortBy> thenByBillName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billName', Sort.asc);
    });
  }

  QueryBuilder<Bill, Bill, QAfterSortBy> thenByBillNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billName', Sort.desc);
    });
  }

  QueryBuilder<Bill, Bill, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Bill, Bill, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension BillQueryWhereDistinct on QueryBuilder<Bill, Bill, QDistinct> {
  QueryBuilder<Bill, Bill, QDistinct> distinctByBillName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'billName', caseSensitive: caseSensitive);
    });
  }
}

extension BillQueryProperty on QueryBuilder<Bill, Bill, QQueryProperty> {
  QueryBuilder<Bill, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Bill, String, QQueryOperations> billNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'billName');
    });
  }

  QueryBuilder<Bill, List<Particular>, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ParticularSchema = Schema(
  name: r'Particular',
  id: -1522864590791142818,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'particularName': PropertySchema(
      id: 2,
      name: r'particularName',
      type: IsarType.string,
    )
  },
  estimateSize: _particularEstimateSize,
  serialize: _particularSerialize,
  deserialize: _particularDeserialize,
  deserializeProp: _particularDeserializeProp,
);

int _particularEstimateSize(
  Particular object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.particularName.length * 3;
  return bytesCount;
}

void _particularSerialize(
  Particular object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.particularName);
}

Particular _particularDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Particular();
  object.amount = reader.readDouble(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.particularName = reader.readString(offsets[2]);
  return object;
}

P _particularDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ParticularQueryFilter
    on QueryBuilder<Particular, Particular, QFilterCondition> {
  QueryBuilder<Particular, Particular, QAfterFilterCondition> amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'particularName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'particularName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'particularName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'particularName',
        value: '',
      ));
    });
  }

  QueryBuilder<Particular, Particular, QAfterFilterCondition>
      particularNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'particularName',
        value: '',
      ));
    });
  }
}

extension ParticularQueryObject
    on QueryBuilder<Particular, Particular, QFilterCondition> {}
