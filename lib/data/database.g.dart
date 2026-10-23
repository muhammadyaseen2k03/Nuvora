// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _cloudUserIdMeta = const VerificationMeta(
    'cloudUserId',
  );
  @override
  late final GeneratedColumn<String> cloudUserId = GeneratedColumn<String>(
    'cloud_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recoveryQuestionMeta = const VerificationMeta(
    'recoveryQuestion',
  );
  @override
  late final GeneratedColumn<String> recoveryQuestion = GeneratedColumn<String>(
    'recovery_question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recoveryHashMeta = const VerificationMeta(
    'recoveryHash',
  );
  @override
  late final GeneratedColumn<String> recoveryHash = GeneratedColumn<String>(
    'recovery_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recoverySaltMeta = const VerificationMeta(
    'recoverySalt',
  );
  @override
  late final GeneratedColumn<String> recoverySalt = GeneratedColumn<String>(
    'recovery_salt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    mode,
    cloudUserId,
    recoveryQuestion,
    recoveryHash,
    recoverySalt,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    }
    if (data.containsKey('cloud_user_id')) {
      context.handle(
        _cloudUserIdMeta,
        cloudUserId.isAcceptableOrUnknown(
          data['cloud_user_id']!,
          _cloudUserIdMeta,
        ),
      );
    }
    if (data.containsKey('recovery_question')) {
      context.handle(
        _recoveryQuestionMeta,
        recoveryQuestion.isAcceptableOrUnknown(
          data['recovery_question']!,
          _recoveryQuestionMeta,
        ),
      );
    }
    if (data.containsKey('recovery_hash')) {
      context.handle(
        _recoveryHashMeta,
        recoveryHash.isAcceptableOrUnknown(
          data['recovery_hash']!,
          _recoveryHashMeta,
        ),
      );
    }
    if (data.containsKey('recovery_salt')) {
      context.handle(
        _recoverySaltMeta,
        recoverySalt.isAcceptableOrUnknown(
          data['recovery_salt']!,
          _recoverySaltMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      cloudUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cloud_user_id'],
      ),
      recoveryQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_question'],
      ),
      recoveryHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_hash'],
      ),
      recoverySalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_salt'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String displayName;
  final String mode;
  final String? cloudUserId;
  final String? recoveryQuestion;
  final String? recoveryHash;
  final String? recoverySalt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Profile({
    required this.id,
    required this.displayName,
    required this.mode,
    this.cloudUserId,
    this.recoveryQuestion,
    this.recoveryHash,
    this.recoverySalt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || cloudUserId != null) {
      map['cloud_user_id'] = Variable<String>(cloudUserId);
    }
    if (!nullToAbsent || recoveryQuestion != null) {
      map['recovery_question'] = Variable<String>(recoveryQuestion);
    }
    if (!nullToAbsent || recoveryHash != null) {
      map['recovery_hash'] = Variable<String>(recoveryHash);
    }
    if (!nullToAbsent || recoverySalt != null) {
      map['recovery_salt'] = Variable<String>(recoverySalt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      mode: Value(mode),
      cloudUserId: cloudUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudUserId),
      recoveryQuestion: recoveryQuestion == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryQuestion),
      recoveryHash: recoveryHash == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryHash),
      recoverySalt: recoverySalt == null && nullToAbsent
          ? const Value.absent()
          : Value(recoverySalt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      mode: serializer.fromJson<String>(json['mode']),
      cloudUserId: serializer.fromJson<String?>(json['cloudUserId']),
      recoveryQuestion: serializer.fromJson<String?>(json['recoveryQuestion']),
      recoveryHash: serializer.fromJson<String?>(json['recoveryHash']),
      recoverySalt: serializer.fromJson<String?>(json['recoverySalt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'mode': serializer.toJson<String>(mode),
      'cloudUserId': serializer.toJson<String?>(cloudUserId),
      'recoveryQuestion': serializer.toJson<String?>(recoveryQuestion),
      'recoveryHash': serializer.toJson<String?>(recoveryHash),
      'recoverySalt': serializer.toJson<String?>(recoverySalt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Profile copyWith({
    String? id,
    String? displayName,
    String? mode,
    Value<String?> cloudUserId = const Value.absent(),
    Value<String?> recoveryQuestion = const Value.absent(),
    Value<String?> recoveryHash = const Value.absent(),
    Value<String?> recoverySalt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Profile(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    mode: mode ?? this.mode,
    cloudUserId: cloudUserId.present ? cloudUserId.value : this.cloudUserId,
    recoveryQuestion: recoveryQuestion.present
        ? recoveryQuestion.value
        : this.recoveryQuestion,
    recoveryHash: recoveryHash.present ? recoveryHash.value : this.recoveryHash,
    recoverySalt: recoverySalt.present ? recoverySalt.value : this.recoverySalt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      mode: data.mode.present ? data.mode.value : this.mode,
      cloudUserId: data.cloudUserId.present
          ? data.cloudUserId.value
          : this.cloudUserId,
      recoveryQuestion: data.recoveryQuestion.present
          ? data.recoveryQuestion.value
          : this.recoveryQuestion,
      recoveryHash: data.recoveryHash.present
          ? data.recoveryHash.value
          : this.recoveryHash,
      recoverySalt: data.recoverySalt.present
          ? data.recoverySalt.value
          : this.recoverySalt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('mode: $mode, ')
          ..write('cloudUserId: $cloudUserId, ')
          ..write('recoveryQuestion: $recoveryQuestion, ')
          ..write('recoveryHash: $recoveryHash, ')
          ..write('recoverySalt: $recoverySalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    mode,
    cloudUserId,
    recoveryQuestion,
    recoveryHash,
    recoverySalt,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.mode == this.mode &&
          other.cloudUserId == this.cloudUserId &&
          other.recoveryQuestion == this.recoveryQuestion &&
          other.recoveryHash == this.recoveryHash &&
          other.recoverySalt == this.recoverySalt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String> mode;
  final Value<String?> cloudUserId;
  final Value<String?> recoveryQuestion;
  final Value<String?> recoveryHash;
  final Value<String?> recoverySalt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.mode = const Value.absent(),
    this.cloudUserId = const Value.absent(),
    this.recoveryQuestion = const Value.absent(),
    this.recoveryHash = const Value.absent(),
    this.recoverySalt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String displayName,
    this.mode = const Value.absent(),
    this.cloudUserId = const Value.absent(),
    this.recoveryQuestion = const Value.absent(),
    this.recoveryHash = const Value.absent(),
    this.recoverySalt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? mode,
    Expression<String>? cloudUserId,
    Expression<String>? recoveryQuestion,
    Expression<String>? recoveryHash,
    Expression<String>? recoverySalt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (mode != null) 'mode': mode,
      if (cloudUserId != null) 'cloud_user_id': cloudUserId,
      if (recoveryQuestion != null) 'recovery_question': recoveryQuestion,
      if (recoveryHash != null) 'recovery_hash': recoveryHash,
      if (recoverySalt != null) 'recovery_salt': recoverySalt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String>? mode,
    Value<String?>? cloudUserId,
    Value<String?>? recoveryQuestion,
    Value<String?>? recoveryHash,
    Value<String?>? recoverySalt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      mode: mode ?? this.mode,
      cloudUserId: cloudUserId ?? this.cloudUserId,
      recoveryQuestion: recoveryQuestion ?? this.recoveryQuestion,
      recoveryHash: recoveryHash ?? this.recoveryHash,
      recoverySalt: recoverySalt ?? this.recoverySalt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (cloudUserId.present) {
      map['cloud_user_id'] = Variable<String>(cloudUserId.value);
    }
    if (recoveryQuestion.present) {
      map['recovery_question'] = Variable<String>(recoveryQuestion.value);
    }
    if (recoveryHash.present) {
      map['recovery_hash'] = Variable<String>(recoveryHash.value);
    }
    if (recoverySalt.present) {
      map['recovery_salt'] = Variable<String>(recoverySalt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('mode: $mode, ')
          ..write('cloudUserId: $cloudUserId, ')
          ..write('recoveryQuestion: $recoveryQuestion, ')
          ..write('recoveryHash: $recoveryHash, ')
          ..write('recoverySalt: $recoverySalt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _fitnessLevelMeta = const VerificationMeta(
    'fitnessLevel',
  );
  @override
  late final GeneratedColumn<String> fitnessLevel = GeneratedColumn<String>(
    'fitness_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('beginner'),
  );
  static const VerificationMeta _workoutMinutesMeta = const VerificationMeta(
    'workoutMinutes',
  );
  @override
  late final GeneratedColumn<int> workoutMinutes = GeneratedColumn<int>(
    'workout_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  static const VerificationMeta _studyGoalMinutesMeta = const VerificationMeta(
    'studyGoalMinutes',
  );
  @override
  late final GeneratedColumn<int> studyGoalMinutes = GeneratedColumn<int>(
    'study_goal_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _waterGoalMlMeta = const VerificationMeta(
    'waterGoalMl',
  );
  @override
  late final GeneratedColumn<int> waterGoalMl = GeneratedColumn<int>(
    'water_goal_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2000),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    themeMode,
    languageCode,
    fitnessLevel,
    workoutMinutes,
    studyGoalMinutes,
    waterGoalMl,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('fitness_level')) {
      context.handle(
        _fitnessLevelMeta,
        fitnessLevel.isAcceptableOrUnknown(
          data['fitness_level']!,
          _fitnessLevelMeta,
        ),
      );
    }
    if (data.containsKey('workout_minutes')) {
      context.handle(
        _workoutMinutesMeta,
        workoutMinutes.isAcceptableOrUnknown(
          data['workout_minutes']!,
          _workoutMinutesMeta,
        ),
      );
    }
    if (data.containsKey('study_goal_minutes')) {
      context.handle(
        _studyGoalMinutesMeta,
        studyGoalMinutes.isAcceptableOrUnknown(
          data['study_goal_minutes']!,
          _studyGoalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('water_goal_ml')) {
      context.handle(
        _waterGoalMlMeta,
        waterGoalMl.isAcceptableOrUnknown(
          data['water_goal_ml']!,
          _waterGoalMlMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      fitnessLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fitness_level'],
      )!,
      workoutMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_minutes'],
      )!,
      studyGoalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_goal_minutes'],
      )!,
      waterGoalMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_goal_ml'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final String profileId;
  final String themeMode;
  final String languageCode;
  final String fitnessLevel;
  final int workoutMinutes;
  final int studyGoalMinutes;
  final int waterGoalMl;
  final DateTime updatedAt;
  const UserPreference({
    required this.profileId,
    required this.themeMode,
    required this.languageCode,
    required this.fitnessLevel,
    required this.workoutMinutes,
    required this.studyGoalMinutes,
    required this.waterGoalMl,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['theme_mode'] = Variable<String>(themeMode);
    map['language_code'] = Variable<String>(languageCode);
    map['fitness_level'] = Variable<String>(fitnessLevel);
    map['workout_minutes'] = Variable<int>(workoutMinutes);
    map['study_goal_minutes'] = Variable<int>(studyGoalMinutes);
    map['water_goal_ml'] = Variable<int>(waterGoalMl);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      profileId: Value(profileId),
      themeMode: Value(themeMode),
      languageCode: Value(languageCode),
      fitnessLevel: Value(fitnessLevel),
      workoutMinutes: Value(workoutMinutes),
      studyGoalMinutes: Value(studyGoalMinutes),
      waterGoalMl: Value(waterGoalMl),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      profileId: serializer.fromJson<String>(json['profileId']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      fitnessLevel: serializer.fromJson<String>(json['fitnessLevel']),
      workoutMinutes: serializer.fromJson<int>(json['workoutMinutes']),
      studyGoalMinutes: serializer.fromJson<int>(json['studyGoalMinutes']),
      waterGoalMl: serializer.fromJson<int>(json['waterGoalMl']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'themeMode': serializer.toJson<String>(themeMode),
      'languageCode': serializer.toJson<String>(languageCode),
      'fitnessLevel': serializer.toJson<String>(fitnessLevel),
      'workoutMinutes': serializer.toJson<int>(workoutMinutes),
      'studyGoalMinutes': serializer.toJson<int>(studyGoalMinutes),
      'waterGoalMl': serializer.toJson<int>(waterGoalMl),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreference copyWith({
    String? profileId,
    String? themeMode,
    String? languageCode,
    String? fitnessLevel,
    int? workoutMinutes,
    int? studyGoalMinutes,
    int? waterGoalMl,
    DateTime? updatedAt,
  }) => UserPreference(
    profileId: profileId ?? this.profileId,
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode ?? this.languageCode,
    fitnessLevel: fitnessLevel ?? this.fitnessLevel,
    workoutMinutes: workoutMinutes ?? this.workoutMinutes,
    studyGoalMinutes: studyGoalMinutes ?? this.studyGoalMinutes,
    waterGoalMl: waterGoalMl ?? this.waterGoalMl,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      fitnessLevel: data.fitnessLevel.present
          ? data.fitnessLevel.value
          : this.fitnessLevel,
      workoutMinutes: data.workoutMinutes.present
          ? data.workoutMinutes.value
          : this.workoutMinutes,
      studyGoalMinutes: data.studyGoalMinutes.present
          ? data.studyGoalMinutes.value
          : this.studyGoalMinutes,
      waterGoalMl: data.waterGoalMl.present
          ? data.waterGoalMl.value
          : this.waterGoalMl,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('profileId: $profileId, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('workoutMinutes: $workoutMinutes, ')
          ..write('studyGoalMinutes: $studyGoalMinutes, ')
          ..write('waterGoalMl: $waterGoalMl, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    themeMode,
    languageCode,
    fitnessLevel,
    workoutMinutes,
    studyGoalMinutes,
    waterGoalMl,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.profileId == this.profileId &&
          other.themeMode == this.themeMode &&
          other.languageCode == this.languageCode &&
          other.fitnessLevel == this.fitnessLevel &&
          other.workoutMinutes == this.workoutMinutes &&
          other.studyGoalMinutes == this.studyGoalMinutes &&
          other.waterGoalMl == this.waterGoalMl &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<String> profileId;
  final Value<String> themeMode;
  final Value<String> languageCode;
  final Value<String> fitnessLevel;
  final Value<int> workoutMinutes;
  final Value<int> studyGoalMinutes;
  final Value<int> waterGoalMl;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.profileId = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.workoutMinutes = const Value.absent(),
    this.studyGoalMinutes = const Value.absent(),
    this.waterGoalMl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String profileId,
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.fitnessLevel = const Value.absent(),
    this.workoutMinutes = const Value.absent(),
    this.studyGoalMinutes = const Value.absent(),
    this.waterGoalMl = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       updatedAt = Value(updatedAt);
  static Insertable<UserPreference> custom({
    Expression<String>? profileId,
    Expression<String>? themeMode,
    Expression<String>? languageCode,
    Expression<String>? fitnessLevel,
    Expression<int>? workoutMinutes,
    Expression<int>? studyGoalMinutes,
    Expression<int>? waterGoalMl,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (themeMode != null) 'theme_mode': themeMode,
      if (languageCode != null) 'language_code': languageCode,
      if (fitnessLevel != null) 'fitness_level': fitnessLevel,
      if (workoutMinutes != null) 'workout_minutes': workoutMinutes,
      if (studyGoalMinutes != null) 'study_goal_minutes': studyGoalMinutes,
      if (waterGoalMl != null) 'water_goal_ml': waterGoalMl,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? profileId,
    Value<String>? themeMode,
    Value<String>? languageCode,
    Value<String>? fitnessLevel,
    Value<int>? workoutMinutes,
    Value<int>? studyGoalMinutes,
    Value<int>? waterGoalMl,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      profileId: profileId ?? this.profileId,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      workoutMinutes: workoutMinutes ?? this.workoutMinutes,
      studyGoalMinutes: studyGoalMinutes ?? this.studyGoalMinutes,
      waterGoalMl: waterGoalMl ?? this.waterGoalMl,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (fitnessLevel.present) {
      map['fitness_level'] = Variable<String>(fitnessLevel.value);
    }
    if (workoutMinutes.present) {
      map['workout_minutes'] = Variable<int>(workoutMinutes.value);
    }
    if (studyGoalMinutes.present) {
      map['study_goal_minutes'] = Variable<int>(studyGoalMinutes.value);
    }
    if (waterGoalMl.present) {
      map['water_goal_ml'] = Variable<int>(waterGoalMl.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('fitnessLevel: $fitnessLevel, ')
          ..write('workoutMinutes: $workoutMinutes, ')
          ..write('studyGoalMinutes: $studyGoalMinutes, ')
          ..write('waterGoalMl: $waterGoalMl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTable extends NotificationPreferences
    with TableInfo<$NotificationPreferencesTable, NotificationPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _prayerMeta = const VerificationMeta('prayer');
  @override
  late final GeneratedColumn<bool> prayer = GeneratedColumn<bool>(
    'prayer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("prayer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _studyMeta = const VerificationMeta('study');
  @override
  late final GeneratedColumn<bool> study = GeneratedColumn<bool>(
    'study',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("study" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _workoutMeta = const VerificationMeta(
    'workout',
  );
  @override
  late final GeneratedColumn<bool> workout = GeneratedColumn<bool>(
    'workout',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("workout" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hydrationMeta = const VerificationMeta(
    'hydration',
  );
  @override
  late final GeneratedColumn<bool> hydration = GeneratedColumn<bool>(
    'hydration',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hydration" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reflectionMeta = const VerificationMeta(
    'reflection',
  );
  @override
  late final GeneratedColumn<bool> reflection = GeneratedColumn<bool>(
    'reflection',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reflection" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _quietStartMinuteMeta = const VerificationMeta(
    'quietStartMinute',
  );
  @override
  late final GeneratedColumn<int> quietStartMinute = GeneratedColumn<int>(
    'quiet_start_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quietEndMinuteMeta = const VerificationMeta(
    'quietEndMinute',
  );
  @override
  late final GeneratedColumn<int> quietEndMinute = GeneratedColumn<int>(
    'quiet_end_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prayerMaskMeta = const VerificationMeta(
    'prayerMask',
  );
  @override
  late final GeneratedColumn<int> prayerMask = GeneratedColumn<int>(
    'prayer_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(31),
  );
  static const VerificationMeta _prayerOffsetMinutesMeta =
      const VerificationMeta('prayerOffsetMinutes');
  @override
  late final GeneratedColumn<int> prayerOffsetMinutes = GeneratedColumn<int>(
    'prayer_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _studyMinuteMeta = const VerificationMeta(
    'studyMinute',
  );
  @override
  late final GeneratedColumn<int> studyMinute = GeneratedColumn<int>(
    'study_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1140),
  );
  static const VerificationMeta _workoutMinuteMeta = const VerificationMeta(
    'workoutMinute',
  );
  @override
  late final GeneratedColumn<int> workoutMinute = GeneratedColumn<int>(
    'workout_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1020),
  );
  static const VerificationMeta _hydrationIntervalMinutesMeta =
      const VerificationMeta('hydrationIntervalMinutes');
  @override
  late final GeneratedColumn<int> hydrationIntervalMinutes =
      GeneratedColumn<int>(
        'hydration_interval_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(120),
      );
  static const VerificationMeta _reflectionMinuteMeta = const VerificationMeta(
    'reflectionMinute',
  );
  @override
  late final GeneratedColumn<int> reflectionMinute = GeneratedColumn<int>(
    'reflection_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1260),
  );
  static const VerificationMeta _flashcardsMeta = const VerificationMeta(
    'flashcards',
  );
  @override
  late final GeneratedColumn<bool> flashcards = GeneratedColumn<bool>(
    'flashcards',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("flashcards" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _flashcardsMinuteMeta = const VerificationMeta(
    'flashcardsMinute',
  );
  @override
  late final GeneratedColumn<int> flashcardsMinute = GeneratedColumn<int>(
    'flashcards_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1080),
  );
  static const VerificationMeta _weeklyReportMeta = const VerificationMeta(
    'weeklyReport',
  );
  @override
  late final GeneratedColumn<bool> weeklyReport = GeneratedColumn<bool>(
    'weekly_report',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("weekly_report" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _weeklyReportDayMeta = const VerificationMeta(
    'weeklyReportDay',
  );
  @override
  late final GeneratedColumn<int> weeklyReportDay = GeneratedColumn<int>(
    'weekly_report_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _showDetailsMeta = const VerificationMeta(
    'showDetails',
  );
  @override
  late final GeneratedColumn<bool> showDetails = GeneratedColumn<bool>(
    'show_details',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_details" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    prayer,
    study,
    workout,
    hydration,
    reflection,
    quietStartMinute,
    quietEndMinute,
    prayerMask,
    prayerOffsetMinutes,
    studyMinute,
    workoutMinute,
    hydrationIntervalMinutes,
    reflectionMinute,
    flashcards,
    flashcardsMinute,
    weeklyReport,
    weeklyReportDay,
    showDetails,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('prayer')) {
      context.handle(
        _prayerMeta,
        prayer.isAcceptableOrUnknown(data['prayer']!, _prayerMeta),
      );
    }
    if (data.containsKey('study')) {
      context.handle(
        _studyMeta,
        study.isAcceptableOrUnknown(data['study']!, _studyMeta),
      );
    }
    if (data.containsKey('workout')) {
      context.handle(
        _workoutMeta,
        workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta),
      );
    }
    if (data.containsKey('hydration')) {
      context.handle(
        _hydrationMeta,
        hydration.isAcceptableOrUnknown(data['hydration']!, _hydrationMeta),
      );
    }
    if (data.containsKey('reflection')) {
      context.handle(
        _reflectionMeta,
        reflection.isAcceptableOrUnknown(data['reflection']!, _reflectionMeta),
      );
    }
    if (data.containsKey('quiet_start_minute')) {
      context.handle(
        _quietStartMinuteMeta,
        quietStartMinute.isAcceptableOrUnknown(
          data['quiet_start_minute']!,
          _quietStartMinuteMeta,
        ),
      );
    }
    if (data.containsKey('quiet_end_minute')) {
      context.handle(
        _quietEndMinuteMeta,
        quietEndMinute.isAcceptableOrUnknown(
          data['quiet_end_minute']!,
          _quietEndMinuteMeta,
        ),
      );
    }
    if (data.containsKey('prayer_mask')) {
      context.handle(
        _prayerMaskMeta,
        prayerMask.isAcceptableOrUnknown(data['prayer_mask']!, _prayerMaskMeta),
      );
    }
    if (data.containsKey('prayer_offset_minutes')) {
      context.handle(
        _prayerOffsetMinutesMeta,
        prayerOffsetMinutes.isAcceptableOrUnknown(
          data['prayer_offset_minutes']!,
          _prayerOffsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('study_minute')) {
      context.handle(
        _studyMinuteMeta,
        studyMinute.isAcceptableOrUnknown(
          data['study_minute']!,
          _studyMinuteMeta,
        ),
      );
    }
    if (data.containsKey('workout_minute')) {
      context.handle(
        _workoutMinuteMeta,
        workoutMinute.isAcceptableOrUnknown(
          data['workout_minute']!,
          _workoutMinuteMeta,
        ),
      );
    }
    if (data.containsKey('hydration_interval_minutes')) {
      context.handle(
        _hydrationIntervalMinutesMeta,
        hydrationIntervalMinutes.isAcceptableOrUnknown(
          data['hydration_interval_minutes']!,
          _hydrationIntervalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('reflection_minute')) {
      context.handle(
        _reflectionMinuteMeta,
        reflectionMinute.isAcceptableOrUnknown(
          data['reflection_minute']!,
          _reflectionMinuteMeta,
        ),
      );
    }
    if (data.containsKey('flashcards')) {
      context.handle(
        _flashcardsMeta,
        flashcards.isAcceptableOrUnknown(data['flashcards']!, _flashcardsMeta),
      );
    }
    if (data.containsKey('flashcards_minute')) {
      context.handle(
        _flashcardsMinuteMeta,
        flashcardsMinute.isAcceptableOrUnknown(
          data['flashcards_minute']!,
          _flashcardsMinuteMeta,
        ),
      );
    }
    if (data.containsKey('weekly_report')) {
      context.handle(
        _weeklyReportMeta,
        weeklyReport.isAcceptableOrUnknown(
          data['weekly_report']!,
          _weeklyReportMeta,
        ),
      );
    }
    if (data.containsKey('weekly_report_day')) {
      context.handle(
        _weeklyReportDayMeta,
        weeklyReportDay.isAcceptableOrUnknown(
          data['weekly_report_day']!,
          _weeklyReportDayMeta,
        ),
      );
    }
    if (data.containsKey('show_details')) {
      context.handle(
        _showDetailsMeta,
        showDetails.isAcceptableOrUnknown(
          data['show_details']!,
          _showDetailsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  NotificationPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreference(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      prayer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}prayer'],
      )!,
      study: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}study'],
      )!,
      workout: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}workout'],
      )!,
      hydration: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hydration'],
      )!,
      reflection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reflection'],
      )!,
      quietStartMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiet_start_minute'],
      ),
      quietEndMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiet_end_minute'],
      ),
      prayerMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prayer_mask'],
      )!,
      prayerOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prayer_offset_minutes'],
      )!,
      studyMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_minute'],
      )!,
      workoutMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_minute'],
      )!,
      hydrationIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hydration_interval_minutes'],
      )!,
      reflectionMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reflection_minute'],
      )!,
      flashcards: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}flashcards'],
      )!,
      flashcardsMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}flashcards_minute'],
      )!,
      weeklyReport: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}weekly_report'],
      )!,
      weeklyReportDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_report_day'],
      )!,
      showDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_details'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationPreferencesTable createAlias(String alias) {
    return $NotificationPreferencesTable(attachedDatabase, alias);
  }
}

class NotificationPreference extends DataClass
    implements Insertable<NotificationPreference> {
  final String profileId;
  final bool prayer;
  final bool study;
  final bool workout;
  final bool hydration;
  final bool reflection;
  final int? quietStartMinute;
  final int? quietEndMinute;
  final int prayerMask;
  final int prayerOffsetMinutes;
  final int studyMinute;
  final int workoutMinute;
  final int hydrationIntervalMinutes;
  final int reflectionMinute;
  final bool flashcards;
  final int flashcardsMinute;
  final bool weeklyReport;
  final int weeklyReportDay;
  final bool showDetails;
  final DateTime updatedAt;
  const NotificationPreference({
    required this.profileId,
    required this.prayer,
    required this.study,
    required this.workout,
    required this.hydration,
    required this.reflection,
    this.quietStartMinute,
    this.quietEndMinute,
    required this.prayerMask,
    required this.prayerOffsetMinutes,
    required this.studyMinute,
    required this.workoutMinute,
    required this.hydrationIntervalMinutes,
    required this.reflectionMinute,
    required this.flashcards,
    required this.flashcardsMinute,
    required this.weeklyReport,
    required this.weeklyReportDay,
    required this.showDetails,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['prayer'] = Variable<bool>(prayer);
    map['study'] = Variable<bool>(study);
    map['workout'] = Variable<bool>(workout);
    map['hydration'] = Variable<bool>(hydration);
    map['reflection'] = Variable<bool>(reflection);
    if (!nullToAbsent || quietStartMinute != null) {
      map['quiet_start_minute'] = Variable<int>(quietStartMinute);
    }
    if (!nullToAbsent || quietEndMinute != null) {
      map['quiet_end_minute'] = Variable<int>(quietEndMinute);
    }
    map['prayer_mask'] = Variable<int>(prayerMask);
    map['prayer_offset_minutes'] = Variable<int>(prayerOffsetMinutes);
    map['study_minute'] = Variable<int>(studyMinute);
    map['workout_minute'] = Variable<int>(workoutMinute);
    map['hydration_interval_minutes'] = Variable<int>(hydrationIntervalMinutes);
    map['reflection_minute'] = Variable<int>(reflectionMinute);
    map['flashcards'] = Variable<bool>(flashcards);
    map['flashcards_minute'] = Variable<int>(flashcardsMinute);
    map['weekly_report'] = Variable<bool>(weeklyReport);
    map['weekly_report_day'] = Variable<int>(weeklyReportDay);
    map['show_details'] = Variable<bool>(showDetails);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationPreferencesCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesCompanion(
      profileId: Value(profileId),
      prayer: Value(prayer),
      study: Value(study),
      workout: Value(workout),
      hydration: Value(hydration),
      reflection: Value(reflection),
      quietStartMinute: quietStartMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(quietStartMinute),
      quietEndMinute: quietEndMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(quietEndMinute),
      prayerMask: Value(prayerMask),
      prayerOffsetMinutes: Value(prayerOffsetMinutes),
      studyMinute: Value(studyMinute),
      workoutMinute: Value(workoutMinute),
      hydrationIntervalMinutes: Value(hydrationIntervalMinutes),
      reflectionMinute: Value(reflectionMinute),
      flashcards: Value(flashcards),
      flashcardsMinute: Value(flashcardsMinute),
      weeklyReport: Value(weeklyReport),
      weeklyReportDay: Value(weeklyReportDay),
      showDetails: Value(showDetails),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreference(
      profileId: serializer.fromJson<String>(json['profileId']),
      prayer: serializer.fromJson<bool>(json['prayer']),
      study: serializer.fromJson<bool>(json['study']),
      workout: serializer.fromJson<bool>(json['workout']),
      hydration: serializer.fromJson<bool>(json['hydration']),
      reflection: serializer.fromJson<bool>(json['reflection']),
      quietStartMinute: serializer.fromJson<int?>(json['quietStartMinute']),
      quietEndMinute: serializer.fromJson<int?>(json['quietEndMinute']),
      prayerMask: serializer.fromJson<int>(json['prayerMask']),
      prayerOffsetMinutes: serializer.fromJson<int>(
        json['prayerOffsetMinutes'],
      ),
      studyMinute: serializer.fromJson<int>(json['studyMinute']),
      workoutMinute: serializer.fromJson<int>(json['workoutMinute']),
      hydrationIntervalMinutes: serializer.fromJson<int>(
        json['hydrationIntervalMinutes'],
      ),
      reflectionMinute: serializer.fromJson<int>(json['reflectionMinute']),
      flashcards: serializer.fromJson<bool>(json['flashcards']),
      flashcardsMinute: serializer.fromJson<int>(json['flashcardsMinute']),
      weeklyReport: serializer.fromJson<bool>(json['weeklyReport']),
      weeklyReportDay: serializer.fromJson<int>(json['weeklyReportDay']),
      showDetails: serializer.fromJson<bool>(json['showDetails']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'prayer': serializer.toJson<bool>(prayer),
      'study': serializer.toJson<bool>(study),
      'workout': serializer.toJson<bool>(workout),
      'hydration': serializer.toJson<bool>(hydration),
      'reflection': serializer.toJson<bool>(reflection),
      'quietStartMinute': serializer.toJson<int?>(quietStartMinute),
      'quietEndMinute': serializer.toJson<int?>(quietEndMinute),
      'prayerMask': serializer.toJson<int>(prayerMask),
      'prayerOffsetMinutes': serializer.toJson<int>(prayerOffsetMinutes),
      'studyMinute': serializer.toJson<int>(studyMinute),
      'workoutMinute': serializer.toJson<int>(workoutMinute),
      'hydrationIntervalMinutes': serializer.toJson<int>(
        hydrationIntervalMinutes,
      ),
      'reflectionMinute': serializer.toJson<int>(reflectionMinute),
      'flashcards': serializer.toJson<bool>(flashcards),
      'flashcardsMinute': serializer.toJson<int>(flashcardsMinute),
      'weeklyReport': serializer.toJson<bool>(weeklyReport),
      'weeklyReportDay': serializer.toJson<int>(weeklyReportDay),
      'showDetails': serializer.toJson<bool>(showDetails),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationPreference copyWith({
    String? profileId,
    bool? prayer,
    bool? study,
    bool? workout,
    bool? hydration,
    bool? reflection,
    Value<int?> quietStartMinute = const Value.absent(),
    Value<int?> quietEndMinute = const Value.absent(),
    int? prayerMask,
    int? prayerOffsetMinutes,
    int? studyMinute,
    int? workoutMinute,
    int? hydrationIntervalMinutes,
    int? reflectionMinute,
    bool? flashcards,
    int? flashcardsMinute,
    bool? weeklyReport,
    int? weeklyReportDay,
    bool? showDetails,
    DateTime? updatedAt,
  }) => NotificationPreference(
    profileId: profileId ?? this.profileId,
    prayer: prayer ?? this.prayer,
    study: study ?? this.study,
    workout: workout ?? this.workout,
    hydration: hydration ?? this.hydration,
    reflection: reflection ?? this.reflection,
    quietStartMinute: quietStartMinute.present
        ? quietStartMinute.value
        : this.quietStartMinute,
    quietEndMinute: quietEndMinute.present
        ? quietEndMinute.value
        : this.quietEndMinute,
    prayerMask: prayerMask ?? this.prayerMask,
    prayerOffsetMinutes: prayerOffsetMinutes ?? this.prayerOffsetMinutes,
    studyMinute: studyMinute ?? this.studyMinute,
    workoutMinute: workoutMinute ?? this.workoutMinute,
    hydrationIntervalMinutes:
        hydrationIntervalMinutes ?? this.hydrationIntervalMinutes,
    reflectionMinute: reflectionMinute ?? this.reflectionMinute,
    flashcards: flashcards ?? this.flashcards,
    flashcardsMinute: flashcardsMinute ?? this.flashcardsMinute,
    weeklyReport: weeklyReport ?? this.weeklyReport,
    weeklyReportDay: weeklyReportDay ?? this.weeklyReportDay,
    showDetails: showDetails ?? this.showDetails,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationPreference copyWithCompanion(
    NotificationPreferencesCompanion data,
  ) {
    return NotificationPreference(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      prayer: data.prayer.present ? data.prayer.value : this.prayer,
      study: data.study.present ? data.study.value : this.study,
      workout: data.workout.present ? data.workout.value : this.workout,
      hydration: data.hydration.present ? data.hydration.value : this.hydration,
      reflection: data.reflection.present
          ? data.reflection.value
          : this.reflection,
      quietStartMinute: data.quietStartMinute.present
          ? data.quietStartMinute.value
          : this.quietStartMinute,
      quietEndMinute: data.quietEndMinute.present
          ? data.quietEndMinute.value
          : this.quietEndMinute,
      prayerMask: data.prayerMask.present
          ? data.prayerMask.value
          : this.prayerMask,
      prayerOffsetMinutes: data.prayerOffsetMinutes.present
          ? data.prayerOffsetMinutes.value
          : this.prayerOffsetMinutes,
      studyMinute: data.studyMinute.present
          ? data.studyMinute.value
          : this.studyMinute,
      workoutMinute: data.workoutMinute.present
          ? data.workoutMinute.value
          : this.workoutMinute,
      hydrationIntervalMinutes: data.hydrationIntervalMinutes.present
          ? data.hydrationIntervalMinutes.value
          : this.hydrationIntervalMinutes,
      reflectionMinute: data.reflectionMinute.present
          ? data.reflectionMinute.value
          : this.reflectionMinute,
      flashcards: data.flashcards.present
          ? data.flashcards.value
          : this.flashcards,
      flashcardsMinute: data.flashcardsMinute.present
          ? data.flashcardsMinute.value
          : this.flashcardsMinute,
      weeklyReport: data.weeklyReport.present
          ? data.weeklyReport.value
          : this.weeklyReport,
      weeklyReportDay: data.weeklyReportDay.present
          ? data.weeklyReportDay.value
          : this.weeklyReportDay,
      showDetails: data.showDetails.present
          ? data.showDetails.value
          : this.showDetails,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreference(')
          ..write('profileId: $profileId, ')
          ..write('prayer: $prayer, ')
          ..write('study: $study, ')
          ..write('workout: $workout, ')
          ..write('hydration: $hydration, ')
          ..write('reflection: $reflection, ')
          ..write('quietStartMinute: $quietStartMinute, ')
          ..write('quietEndMinute: $quietEndMinute, ')
          ..write('prayerMask: $prayerMask, ')
          ..write('prayerOffsetMinutes: $prayerOffsetMinutes, ')
          ..write('studyMinute: $studyMinute, ')
          ..write('workoutMinute: $workoutMinute, ')
          ..write('hydrationIntervalMinutes: $hydrationIntervalMinutes, ')
          ..write('reflectionMinute: $reflectionMinute, ')
          ..write('flashcards: $flashcards, ')
          ..write('flashcardsMinute: $flashcardsMinute, ')
          ..write('weeklyReport: $weeklyReport, ')
          ..write('weeklyReportDay: $weeklyReportDay, ')
          ..write('showDetails: $showDetails, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    prayer,
    study,
    workout,
    hydration,
    reflection,
    quietStartMinute,
    quietEndMinute,
    prayerMask,
    prayerOffsetMinutes,
    studyMinute,
    workoutMinute,
    hydrationIntervalMinutes,
    reflectionMinute,
    flashcards,
    flashcardsMinute,
    weeklyReport,
    weeklyReportDay,
    showDetails,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreference &&
          other.profileId == this.profileId &&
          other.prayer == this.prayer &&
          other.study == this.study &&
          other.workout == this.workout &&
          other.hydration == this.hydration &&
          other.reflection == this.reflection &&
          other.quietStartMinute == this.quietStartMinute &&
          other.quietEndMinute == this.quietEndMinute &&
          other.prayerMask == this.prayerMask &&
          other.prayerOffsetMinutes == this.prayerOffsetMinutes &&
          other.studyMinute == this.studyMinute &&
          other.workoutMinute == this.workoutMinute &&
          other.hydrationIntervalMinutes == this.hydrationIntervalMinutes &&
          other.reflectionMinute == this.reflectionMinute &&
          other.flashcards == this.flashcards &&
          other.flashcardsMinute == this.flashcardsMinute &&
          other.weeklyReport == this.weeklyReport &&
          other.weeklyReportDay == this.weeklyReportDay &&
          other.showDetails == this.showDetails &&
          other.updatedAt == this.updatedAt);
}

class NotificationPreferencesCompanion
    extends UpdateCompanion<NotificationPreference> {
  final Value<String> profileId;
  final Value<bool> prayer;
  final Value<bool> study;
  final Value<bool> workout;
  final Value<bool> hydration;
  final Value<bool> reflection;
  final Value<int?> quietStartMinute;
  final Value<int?> quietEndMinute;
  final Value<int> prayerMask;
  final Value<int> prayerOffsetMinutes;
  final Value<int> studyMinute;
  final Value<int> workoutMinute;
  final Value<int> hydrationIntervalMinutes;
  final Value<int> reflectionMinute;
  final Value<bool> flashcards;
  final Value<int> flashcardsMinute;
  final Value<bool> weeklyReport;
  final Value<int> weeklyReportDay;
  final Value<bool> showDetails;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotificationPreferencesCompanion({
    this.profileId = const Value.absent(),
    this.prayer = const Value.absent(),
    this.study = const Value.absent(),
    this.workout = const Value.absent(),
    this.hydration = const Value.absent(),
    this.reflection = const Value.absent(),
    this.quietStartMinute = const Value.absent(),
    this.quietEndMinute = const Value.absent(),
    this.prayerMask = const Value.absent(),
    this.prayerOffsetMinutes = const Value.absent(),
    this.studyMinute = const Value.absent(),
    this.workoutMinute = const Value.absent(),
    this.hydrationIntervalMinutes = const Value.absent(),
    this.reflectionMinute = const Value.absent(),
    this.flashcards = const Value.absent(),
    this.flashcardsMinute = const Value.absent(),
    this.weeklyReport = const Value.absent(),
    this.weeklyReportDay = const Value.absent(),
    this.showDetails = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationPreferencesCompanion.insert({
    required String profileId,
    this.prayer = const Value.absent(),
    this.study = const Value.absent(),
    this.workout = const Value.absent(),
    this.hydration = const Value.absent(),
    this.reflection = const Value.absent(),
    this.quietStartMinute = const Value.absent(),
    this.quietEndMinute = const Value.absent(),
    this.prayerMask = const Value.absent(),
    this.prayerOffsetMinutes = const Value.absent(),
    this.studyMinute = const Value.absent(),
    this.workoutMinute = const Value.absent(),
    this.hydrationIntervalMinutes = const Value.absent(),
    this.reflectionMinute = const Value.absent(),
    this.flashcards = const Value.absent(),
    this.flashcardsMinute = const Value.absent(),
    this.weeklyReport = const Value.absent(),
    this.weeklyReportDay = const Value.absent(),
    this.showDetails = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationPreference> custom({
    Expression<String>? profileId,
    Expression<bool>? prayer,
    Expression<bool>? study,
    Expression<bool>? workout,
    Expression<bool>? hydration,
    Expression<bool>? reflection,
    Expression<int>? quietStartMinute,
    Expression<int>? quietEndMinute,
    Expression<int>? prayerMask,
    Expression<int>? prayerOffsetMinutes,
    Expression<int>? studyMinute,
    Expression<int>? workoutMinute,
    Expression<int>? hydrationIntervalMinutes,
    Expression<int>? reflectionMinute,
    Expression<bool>? flashcards,
    Expression<int>? flashcardsMinute,
    Expression<bool>? weeklyReport,
    Expression<int>? weeklyReportDay,
    Expression<bool>? showDetails,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (prayer != null) 'prayer': prayer,
      if (study != null) 'study': study,
      if (workout != null) 'workout': workout,
      if (hydration != null) 'hydration': hydration,
      if (reflection != null) 'reflection': reflection,
      if (quietStartMinute != null) 'quiet_start_minute': quietStartMinute,
      if (quietEndMinute != null) 'quiet_end_minute': quietEndMinute,
      if (prayerMask != null) 'prayer_mask': prayerMask,
      if (prayerOffsetMinutes != null)
        'prayer_offset_minutes': prayerOffsetMinutes,
      if (studyMinute != null) 'study_minute': studyMinute,
      if (workoutMinute != null) 'workout_minute': workoutMinute,
      if (hydrationIntervalMinutes != null)
        'hydration_interval_minutes': hydrationIntervalMinutes,
      if (reflectionMinute != null) 'reflection_minute': reflectionMinute,
      if (flashcards != null) 'flashcards': flashcards,
      if (flashcardsMinute != null) 'flashcards_minute': flashcardsMinute,
      if (weeklyReport != null) 'weekly_report': weeklyReport,
      if (weeklyReportDay != null) 'weekly_report_day': weeklyReportDay,
      if (showDetails != null) 'show_details': showDetails,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationPreferencesCompanion copyWith({
    Value<String>? profileId,
    Value<bool>? prayer,
    Value<bool>? study,
    Value<bool>? workout,
    Value<bool>? hydration,
    Value<bool>? reflection,
    Value<int?>? quietStartMinute,
    Value<int?>? quietEndMinute,
    Value<int>? prayerMask,
    Value<int>? prayerOffsetMinutes,
    Value<int>? studyMinute,
    Value<int>? workoutMinute,
    Value<int>? hydrationIntervalMinutes,
    Value<int>? reflectionMinute,
    Value<bool>? flashcards,
    Value<int>? flashcardsMinute,
    Value<bool>? weeklyReport,
    Value<int>? weeklyReportDay,
    Value<bool>? showDetails,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationPreferencesCompanion(
      profileId: profileId ?? this.profileId,
      prayer: prayer ?? this.prayer,
      study: study ?? this.study,
      workout: workout ?? this.workout,
      hydration: hydration ?? this.hydration,
      reflection: reflection ?? this.reflection,
      quietStartMinute: quietStartMinute ?? this.quietStartMinute,
      quietEndMinute: quietEndMinute ?? this.quietEndMinute,
      prayerMask: prayerMask ?? this.prayerMask,
      prayerOffsetMinutes: prayerOffsetMinutes ?? this.prayerOffsetMinutes,
      studyMinute: studyMinute ?? this.studyMinute,
      workoutMinute: workoutMinute ?? this.workoutMinute,
      hydrationIntervalMinutes:
          hydrationIntervalMinutes ?? this.hydrationIntervalMinutes,
      reflectionMinute: reflectionMinute ?? this.reflectionMinute,
      flashcards: flashcards ?? this.flashcards,
      flashcardsMinute: flashcardsMinute ?? this.flashcardsMinute,
      weeklyReport: weeklyReport ?? this.weeklyReport,
      weeklyReportDay: weeklyReportDay ?? this.weeklyReportDay,
      showDetails: showDetails ?? this.showDetails,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (prayer.present) {
      map['prayer'] = Variable<bool>(prayer.value);
    }
    if (study.present) {
      map['study'] = Variable<bool>(study.value);
    }
    if (workout.present) {
      map['workout'] = Variable<bool>(workout.value);
    }
    if (hydration.present) {
      map['hydration'] = Variable<bool>(hydration.value);
    }
    if (reflection.present) {
      map['reflection'] = Variable<bool>(reflection.value);
    }
    if (quietStartMinute.present) {
      map['quiet_start_minute'] = Variable<int>(quietStartMinute.value);
    }
    if (quietEndMinute.present) {
      map['quiet_end_minute'] = Variable<int>(quietEndMinute.value);
    }
    if (prayerMask.present) {
      map['prayer_mask'] = Variable<int>(prayerMask.value);
    }
    if (prayerOffsetMinutes.present) {
      map['prayer_offset_minutes'] = Variable<int>(prayerOffsetMinutes.value);
    }
    if (studyMinute.present) {
      map['study_minute'] = Variable<int>(studyMinute.value);
    }
    if (workoutMinute.present) {
      map['workout_minute'] = Variable<int>(workoutMinute.value);
    }
    if (hydrationIntervalMinutes.present) {
      map['hydration_interval_minutes'] = Variable<int>(
        hydrationIntervalMinutes.value,
      );
    }
    if (reflectionMinute.present) {
      map['reflection_minute'] = Variable<int>(reflectionMinute.value);
    }
    if (flashcards.present) {
      map['flashcards'] = Variable<bool>(flashcards.value);
    }
    if (flashcardsMinute.present) {
      map['flashcards_minute'] = Variable<int>(flashcardsMinute.value);
    }
    if (weeklyReport.present) {
      map['weekly_report'] = Variable<bool>(weeklyReport.value);
    }
    if (weeklyReportDay.present) {
      map['weekly_report_day'] = Variable<int>(weeklyReportDay.value);
    }
    if (showDetails.present) {
      map['show_details'] = Variable<bool>(showDetails.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('prayer: $prayer, ')
          ..write('study: $study, ')
          ..write('workout: $workout, ')
          ..write('hydration: $hydration, ')
          ..write('reflection: $reflection, ')
          ..write('quietStartMinute: $quietStartMinute, ')
          ..write('quietEndMinute: $quietEndMinute, ')
          ..write('prayerMask: $prayerMask, ')
          ..write('prayerOffsetMinutes: $prayerOffsetMinutes, ')
          ..write('studyMinute: $studyMinute, ')
          ..write('workoutMinute: $workoutMinute, ')
          ..write('hydrationIntervalMinutes: $hydrationIntervalMinutes, ')
          ..write('reflectionMinute: $reflectionMinute, ')
          ..write('flashcards: $flashcards, ')
          ..write('flashcardsMinute: $flashcardsMinute, ')
          ..write('weeklyReport: $weeklyReport, ')
          ..write('weeklyReportDay: $weeklyReportDay, ')
          ..write('showDetails: $showDetails, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrivacyPreferencesTable extends PrivacyPreferences
    with TableInfo<$PrivacyPreferencesTable, PrivacyPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrivacyPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cloudSyncEnabledMeta = const VerificationMeta(
    'cloudSyncEnabled',
  );
  @override
  late final GeneratedColumn<bool> cloudSyncEnabled = GeneratedColumn<bool>(
    'cloud_sync_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cloud_sync_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _aiConsentMeta = const VerificationMeta(
    'aiConsent',
  );
  @override
  late final GeneratedColumn<bool> aiConsent = GeneratedColumn<bool>(
    'ai_consent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_consent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _aiShareStudyMeta = const VerificationMeta(
    'aiShareStudy',
  );
  @override
  late final GeneratedColumn<bool> aiShareStudy = GeneratedColumn<bool>(
    'ai_share_study',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_share_study" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _aiShareFitnessMeta = const VerificationMeta(
    'aiShareFitness',
  );
  @override
  late final GeneratedColumn<bool> aiShareFitness = GeneratedColumn<bool>(
    'ai_share_fitness',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_share_fitness" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _aiSharePrayerMeta = const VerificationMeta(
    'aiSharePrayer',
  );
  @override
  late final GeneratedColumn<bool> aiSharePrayer = GeneratedColumn<bool>(
    'ai_share_prayer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_share_prayer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    cloudSyncEnabled,
    aiConsent,
    aiShareStudy,
    aiShareFitness,
    aiSharePrayer,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'privacy_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrivacyPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('cloud_sync_enabled')) {
      context.handle(
        _cloudSyncEnabledMeta,
        cloudSyncEnabled.isAcceptableOrUnknown(
          data['cloud_sync_enabled']!,
          _cloudSyncEnabledMeta,
        ),
      );
    }
    if (data.containsKey('ai_consent')) {
      context.handle(
        _aiConsentMeta,
        aiConsent.isAcceptableOrUnknown(data['ai_consent']!, _aiConsentMeta),
      );
    }
    if (data.containsKey('ai_share_study')) {
      context.handle(
        _aiShareStudyMeta,
        aiShareStudy.isAcceptableOrUnknown(
          data['ai_share_study']!,
          _aiShareStudyMeta,
        ),
      );
    }
    if (data.containsKey('ai_share_fitness')) {
      context.handle(
        _aiShareFitnessMeta,
        aiShareFitness.isAcceptableOrUnknown(
          data['ai_share_fitness']!,
          _aiShareFitnessMeta,
        ),
      );
    }
    if (data.containsKey('ai_share_prayer')) {
      context.handle(
        _aiSharePrayerMeta,
        aiSharePrayer.isAcceptableOrUnknown(
          data['ai_share_prayer']!,
          _aiSharePrayerMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  PrivacyPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrivacyPreference(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      cloudSyncEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cloud_sync_enabled'],
      )!,
      aiConsent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_consent'],
      )!,
      aiShareStudy: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_share_study'],
      )!,
      aiShareFitness: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_share_fitness'],
      )!,
      aiSharePrayer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_share_prayer'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrivacyPreferencesTable createAlias(String alias) {
    return $PrivacyPreferencesTable(attachedDatabase, alias);
  }
}

class PrivacyPreference extends DataClass
    implements Insertable<PrivacyPreference> {
  final String profileId;
  final bool cloudSyncEnabled;
  final bool aiConsent;
  final bool aiShareStudy;
  final bool aiShareFitness;
  final bool aiSharePrayer;
  final DateTime updatedAt;
  const PrivacyPreference({
    required this.profileId,
    required this.cloudSyncEnabled,
    required this.aiConsent,
    required this.aiShareStudy,
    required this.aiShareFitness,
    required this.aiSharePrayer,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['cloud_sync_enabled'] = Variable<bool>(cloudSyncEnabled);
    map['ai_consent'] = Variable<bool>(aiConsent);
    map['ai_share_study'] = Variable<bool>(aiShareStudy);
    map['ai_share_fitness'] = Variable<bool>(aiShareFitness);
    map['ai_share_prayer'] = Variable<bool>(aiSharePrayer);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrivacyPreferencesCompanion toCompanion(bool nullToAbsent) {
    return PrivacyPreferencesCompanion(
      profileId: Value(profileId),
      cloudSyncEnabled: Value(cloudSyncEnabled),
      aiConsent: Value(aiConsent),
      aiShareStudy: Value(aiShareStudy),
      aiShareFitness: Value(aiShareFitness),
      aiSharePrayer: Value(aiSharePrayer),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrivacyPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrivacyPreference(
      profileId: serializer.fromJson<String>(json['profileId']),
      cloudSyncEnabled: serializer.fromJson<bool>(json['cloudSyncEnabled']),
      aiConsent: serializer.fromJson<bool>(json['aiConsent']),
      aiShareStudy: serializer.fromJson<bool>(json['aiShareStudy']),
      aiShareFitness: serializer.fromJson<bool>(json['aiShareFitness']),
      aiSharePrayer: serializer.fromJson<bool>(json['aiSharePrayer']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'cloudSyncEnabled': serializer.toJson<bool>(cloudSyncEnabled),
      'aiConsent': serializer.toJson<bool>(aiConsent),
      'aiShareStudy': serializer.toJson<bool>(aiShareStudy),
      'aiShareFitness': serializer.toJson<bool>(aiShareFitness),
      'aiSharePrayer': serializer.toJson<bool>(aiSharePrayer),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrivacyPreference copyWith({
    String? profileId,
    bool? cloudSyncEnabled,
    bool? aiConsent,
    bool? aiShareStudy,
    bool? aiShareFitness,
    bool? aiSharePrayer,
    DateTime? updatedAt,
  }) => PrivacyPreference(
    profileId: profileId ?? this.profileId,
    cloudSyncEnabled: cloudSyncEnabled ?? this.cloudSyncEnabled,
    aiConsent: aiConsent ?? this.aiConsent,
    aiShareStudy: aiShareStudy ?? this.aiShareStudy,
    aiShareFitness: aiShareFitness ?? this.aiShareFitness,
    aiSharePrayer: aiSharePrayer ?? this.aiSharePrayer,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrivacyPreference copyWithCompanion(PrivacyPreferencesCompanion data) {
    return PrivacyPreference(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cloudSyncEnabled: data.cloudSyncEnabled.present
          ? data.cloudSyncEnabled.value
          : this.cloudSyncEnabled,
      aiConsent: data.aiConsent.present ? data.aiConsent.value : this.aiConsent,
      aiShareStudy: data.aiShareStudy.present
          ? data.aiShareStudy.value
          : this.aiShareStudy,
      aiShareFitness: data.aiShareFitness.present
          ? data.aiShareFitness.value
          : this.aiShareFitness,
      aiSharePrayer: data.aiSharePrayer.present
          ? data.aiSharePrayer.value
          : this.aiSharePrayer,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrivacyPreference(')
          ..write('profileId: $profileId, ')
          ..write('cloudSyncEnabled: $cloudSyncEnabled, ')
          ..write('aiConsent: $aiConsent, ')
          ..write('aiShareStudy: $aiShareStudy, ')
          ..write('aiShareFitness: $aiShareFitness, ')
          ..write('aiSharePrayer: $aiSharePrayer, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    cloudSyncEnabled,
    aiConsent,
    aiShareStudy,
    aiShareFitness,
    aiSharePrayer,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrivacyPreference &&
          other.profileId == this.profileId &&
          other.cloudSyncEnabled == this.cloudSyncEnabled &&
          other.aiConsent == this.aiConsent &&
          other.aiShareStudy == this.aiShareStudy &&
          other.aiShareFitness == this.aiShareFitness &&
          other.aiSharePrayer == this.aiSharePrayer &&
          other.updatedAt == this.updatedAt);
}

class PrivacyPreferencesCompanion extends UpdateCompanion<PrivacyPreference> {
  final Value<String> profileId;
  final Value<bool> cloudSyncEnabled;
  final Value<bool> aiConsent;
  final Value<bool> aiShareStudy;
  final Value<bool> aiShareFitness;
  final Value<bool> aiSharePrayer;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrivacyPreferencesCompanion({
    this.profileId = const Value.absent(),
    this.cloudSyncEnabled = const Value.absent(),
    this.aiConsent = const Value.absent(),
    this.aiShareStudy = const Value.absent(),
    this.aiShareFitness = const Value.absent(),
    this.aiSharePrayer = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrivacyPreferencesCompanion.insert({
    required String profileId,
    this.cloudSyncEnabled = const Value.absent(),
    this.aiConsent = const Value.absent(),
    this.aiShareStudy = const Value.absent(),
    this.aiShareFitness = const Value.absent(),
    this.aiSharePrayer = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       updatedAt = Value(updatedAt);
  static Insertable<PrivacyPreference> custom({
    Expression<String>? profileId,
    Expression<bool>? cloudSyncEnabled,
    Expression<bool>? aiConsent,
    Expression<bool>? aiShareStudy,
    Expression<bool>? aiShareFitness,
    Expression<bool>? aiSharePrayer,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (cloudSyncEnabled != null) 'cloud_sync_enabled': cloudSyncEnabled,
      if (aiConsent != null) 'ai_consent': aiConsent,
      if (aiShareStudy != null) 'ai_share_study': aiShareStudy,
      if (aiShareFitness != null) 'ai_share_fitness': aiShareFitness,
      if (aiSharePrayer != null) 'ai_share_prayer': aiSharePrayer,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrivacyPreferencesCompanion copyWith({
    Value<String>? profileId,
    Value<bool>? cloudSyncEnabled,
    Value<bool>? aiConsent,
    Value<bool>? aiShareStudy,
    Value<bool>? aiShareFitness,
    Value<bool>? aiSharePrayer,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrivacyPreferencesCompanion(
      profileId: profileId ?? this.profileId,
      cloudSyncEnabled: cloudSyncEnabled ?? this.cloudSyncEnabled,
      aiConsent: aiConsent ?? this.aiConsent,
      aiShareStudy: aiShareStudy ?? this.aiShareStudy,
      aiShareFitness: aiShareFitness ?? this.aiShareFitness,
      aiSharePrayer: aiSharePrayer ?? this.aiSharePrayer,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cloudSyncEnabled.present) {
      map['cloud_sync_enabled'] = Variable<bool>(cloudSyncEnabled.value);
    }
    if (aiConsent.present) {
      map['ai_consent'] = Variable<bool>(aiConsent.value);
    }
    if (aiShareStudy.present) {
      map['ai_share_study'] = Variable<bool>(aiShareStudy.value);
    }
    if (aiShareFitness.present) {
      map['ai_share_fitness'] = Variable<bool>(aiShareFitness.value);
    }
    if (aiSharePrayer.present) {
      map['ai_share_prayer'] = Variable<bool>(aiSharePrayer.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrivacyPreferencesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('cloudSyncEnabled: $cloudSyncEnabled, ')
          ..write('aiConsent: $aiConsent, ')
          ..write('aiShareStudy: $aiShareStudy, ')
          ..write('aiShareFitness: $aiShareFitness, ')
          ..write('aiSharePrayer: $aiSharePrayer, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrayerSettingsTable extends PrayerSettings
    with TableInfo<$PrayerSettingsTable, PrayerSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('muslimWorldLeague'),
  );
  static const VerificationMeta _asrMethodMeta = const VerificationMeta(
    'asrMethod',
  );
  @override
  late final GeneratedColumn<String> asrMethod = GeneratedColumn<String>(
    'asr_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('shafi'),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationLabelMeta = const VerificationMeta(
    'locationLabel',
  );
  @override
  late final GeneratedColumn<String> locationLabel = GeneratedColumn<String>(
    'location_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    method,
    asrMethod,
    latitude,
    longitude,
    locationLabel,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('asr_method')) {
      context.handle(
        _asrMethodMeta,
        asrMethod.isAcceptableOrUnknown(data['asr_method']!, _asrMethodMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('location_label')) {
      context.handle(
        _locationLabelMeta,
        locationLabel.isAcceptableOrUnknown(
          data['location_label']!,
          _locationLabelMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  PrayerSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerSetting(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      asrMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asr_method'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      locationLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_label'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrayerSettingsTable createAlias(String alias) {
    return $PrayerSettingsTable(attachedDatabase, alias);
  }
}

class PrayerSetting extends DataClass implements Insertable<PrayerSetting> {
  final String profileId;
  final String method;
  final String asrMethod;
  final double? latitude;
  final double? longitude;
  final String? locationLabel;
  final DateTime updatedAt;
  const PrayerSetting({
    required this.profileId,
    required this.method,
    required this.asrMethod,
    this.latitude,
    this.longitude,
    this.locationLabel,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['method'] = Variable<String>(method);
    map['asr_method'] = Variable<String>(asrMethod);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || locationLabel != null) {
      map['location_label'] = Variable<String>(locationLabel);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrayerSettingsCompanion toCompanion(bool nullToAbsent) {
    return PrayerSettingsCompanion(
      profileId: Value(profileId),
      method: Value(method),
      asrMethod: Value(asrMethod),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      locationLabel: locationLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLabel),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrayerSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerSetting(
      profileId: serializer.fromJson<String>(json['profileId']),
      method: serializer.fromJson<String>(json['method']),
      asrMethod: serializer.fromJson<String>(json['asrMethod']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      locationLabel: serializer.fromJson<String?>(json['locationLabel']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'method': serializer.toJson<String>(method),
      'asrMethod': serializer.toJson<String>(asrMethod),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'locationLabel': serializer.toJson<String?>(locationLabel),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrayerSetting copyWith({
    String? profileId,
    String? method,
    String? asrMethod,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> locationLabel = const Value.absent(),
    DateTime? updatedAt,
  }) => PrayerSetting(
    profileId: profileId ?? this.profileId,
    method: method ?? this.method,
    asrMethod: asrMethod ?? this.asrMethod,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    locationLabel: locationLabel.present
        ? locationLabel.value
        : this.locationLabel,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrayerSetting copyWithCompanion(PrayerSettingsCompanion data) {
    return PrayerSetting(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      method: data.method.present ? data.method.value : this.method,
      asrMethod: data.asrMethod.present ? data.asrMethod.value : this.asrMethod,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      locationLabel: data.locationLabel.present
          ? data.locationLabel.value
          : this.locationLabel,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerSetting(')
          ..write('profileId: $profileId, ')
          ..write('method: $method, ')
          ..write('asrMethod: $asrMethod, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationLabel: $locationLabel, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    method,
    asrMethod,
    latitude,
    longitude,
    locationLabel,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerSetting &&
          other.profileId == this.profileId &&
          other.method == this.method &&
          other.asrMethod == this.asrMethod &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.locationLabel == this.locationLabel &&
          other.updatedAt == this.updatedAt);
}

class PrayerSettingsCompanion extends UpdateCompanion<PrayerSetting> {
  final Value<String> profileId;
  final Value<String> method;
  final Value<String> asrMethod;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> locationLabel;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrayerSettingsCompanion({
    this.profileId = const Value.absent(),
    this.method = const Value.absent(),
    this.asrMethod = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationLabel = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrayerSettingsCompanion.insert({
    required String profileId,
    this.method = const Value.absent(),
    this.asrMethod = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationLabel = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       updatedAt = Value(updatedAt);
  static Insertable<PrayerSetting> custom({
    Expression<String>? profileId,
    Expression<String>? method,
    Expression<String>? asrMethod,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? locationLabel,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (method != null) 'method': method,
      if (asrMethod != null) 'asr_method': asrMethod,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locationLabel != null) 'location_label': locationLabel,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrayerSettingsCompanion copyWith({
    Value<String>? profileId,
    Value<String>? method,
    Value<String>? asrMethod,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? locationLabel,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrayerSettingsCompanion(
      profileId: profileId ?? this.profileId,
      method: method ?? this.method,
      asrMethod: asrMethod ?? this.asrMethod,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationLabel: locationLabel ?? this.locationLabel,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (asrMethod.present) {
      map['asr_method'] = Variable<String>(asrMethod.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (locationLabel.present) {
      map['location_label'] = Variable<String>(locationLabel.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerSettingsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('method: $method, ')
          ..write('asrMethod: $asrMethod, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationLabel: $locationLabel, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrayerRecordsTable extends PrayerRecords
    with TableInfo<$PrayerRecordsTable, PrayerRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prayerMeta = const VerificationMeta('prayer');
  @override
  late final GeneratedColumn<String> prayer = GeneratedColumn<String>(
    'prayer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    day,
    prayer,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('prayer')) {
      context.handle(
        _prayerMeta,
        prayer.isAcceptableOrUnknown(data['prayer']!, _prayerMeta),
      );
    } else if (isInserting) {
      context.missing(_prayerMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, day, prayer},
  ];
  @override
  PrayerRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      prayer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrayerRecordsTable createAlias(String alias) {
    return $PrayerRecordsTable(attachedDatabase, alias);
  }
}

class PrayerRecord extends DataClass implements Insertable<PrayerRecord> {
  final String id;
  final String profileId;
  final String day;
  final String prayer;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrayerRecord({
    required this.id,
    required this.profileId,
    required this.day,
    required this.prayer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['day'] = Variable<String>(day);
    map['prayer'] = Variable<String>(prayer);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrayerRecordsCompanion toCompanion(bool nullToAbsent) {
    return PrayerRecordsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      day: Value(day),
      prayer: Value(prayer),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrayerRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerRecord(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      day: serializer.fromJson<String>(json['day']),
      prayer: serializer.fromJson<String>(json['prayer']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'day': serializer.toJson<String>(day),
      'prayer': serializer.toJson<String>(prayer),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrayerRecord copyWith({
    String? id,
    String? profileId,
    String? day,
    String? prayer,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PrayerRecord(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    day: day ?? this.day,
    prayer: prayer ?? this.prayer,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrayerRecord copyWithCompanion(PrayerRecordsCompanion data) {
    return PrayerRecord(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      day: data.day.present ? data.day.value : this.day,
      prayer: data.prayer.present ? data.prayer.value : this.prayer,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerRecord(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('prayer: $prayer, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, day, prayer, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerRecord &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.day == this.day &&
          other.prayer == this.prayer &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrayerRecordsCompanion extends UpdateCompanion<PrayerRecord> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> day;
  final Value<String> prayer;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrayerRecordsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.day = const Value.absent(),
    this.prayer = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrayerRecordsCompanion.insert({
    required String id,
    required String profileId,
    required String day,
    required String prayer,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       day = Value(day),
       prayer = Value(prayer),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PrayerRecord> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? day,
    Expression<String>? prayer,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (day != null) 'day': day,
      if (prayer != null) 'prayer': prayer,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrayerRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? day,
    Value<String>? prayer,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrayerRecordsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      day: day ?? this.day,
      prayer: prayer ?? this.prayer,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (prayer.present) {
      map['prayer'] = Variable<String>(prayer.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerRecordsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('prayer: $prayer, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final String id;
  final String profileId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subject({
    required this.id,
    required this.profileId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Subject copyWith({
    String? id,
    String? profileId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Subject> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyllabusTopicsTable extends SyllabusTopics
    with TableInfo<$SyllabusTopicsTable, SyllabusTopic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyllabusTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _estimateMinutesMeta = const VerificationMeta(
    'estimateMinutes',
  );
  @override
  late final GeneratedColumn<int> estimateMinutes = GeneratedColumn<int>(
    'estimate_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('notStarted'),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    subjectId,
    title,
    description,
    priority,
    estimateMinutes,
    status,
    dueDate,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'syllabus_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyllabusTopic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('estimate_minutes')) {
      context.handle(
        _estimateMinutesMeta,
        estimateMinutes.isAcceptableOrUnknown(
          data['estimate_minutes']!,
          _estimateMinutesMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyllabusTopic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyllabusTopic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      estimateMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimate_minutes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyllabusTopicsTable createAlias(String alias) {
    return $SyllabusTopicsTable(attachedDatabase, alias);
  }
}

class SyllabusTopic extends DataClass implements Insertable<SyllabusTopic> {
  final String id;
  final String profileId;
  final String subjectId;
  final String title;
  final String? description;
  final int priority;
  final int? estimateMinutes;
  final String status;
  final DateTime? dueDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyllabusTopic({
    required this.id,
    required this.profileId,
    required this.subjectId,
    required this.title,
    this.description,
    required this.priority,
    this.estimateMinutes,
    required this.status,
    this.dueDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || estimateMinutes != null) {
      map['estimate_minutes'] = Variable<int>(estimateMinutes);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyllabusTopicsCompanion toCompanion(bool nullToAbsent) {
    return SyllabusTopicsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      subjectId: Value(subjectId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priority: Value(priority),
      estimateMinutes: estimateMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimateMinutes),
      status: Value(status),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyllabusTopic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyllabusTopic(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
      estimateMinutes: serializer.fromJson<int?>(json['estimateMinutes']),
      status: serializer.fromJson<String>(json['status']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'priority': serializer.toJson<int>(priority),
      'estimateMinutes': serializer.toJson<int?>(estimateMinutes),
      'status': serializer.toJson<String>(status),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyllabusTopic copyWith({
    String? id,
    String? profileId,
    String? subjectId,
    String? title,
    Value<String?> description = const Value.absent(),
    int? priority,
    Value<int?> estimateMinutes = const Value.absent(),
    String? status,
    Value<DateTime?> dueDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyllabusTopic(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    priority: priority ?? this.priority,
    estimateMinutes: estimateMinutes.present
        ? estimateMinutes.value
        : this.estimateMinutes,
    status: status ?? this.status,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyllabusTopic copyWithCompanion(SyllabusTopicsCompanion data) {
    return SyllabusTopic(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimateMinutes: data.estimateMinutes.present
          ? data.estimateMinutes.value
          : this.estimateMinutes,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyllabusTopic(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('estimateMinutes: $estimateMinutes, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    subjectId,
    title,
    description,
    priority,
    estimateMinutes,
    status,
    dueDate,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyllabusTopic &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.description == this.description &&
          other.priority == this.priority &&
          other.estimateMinutes == this.estimateMinutes &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyllabusTopicsCompanion extends UpdateCompanion<SyllabusTopic> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> priority;
  final Value<int?> estimateMinutes;
  final Value<String> status;
  final Value<DateTime?> dueDate;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyllabusTopicsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimateMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyllabusTopicsCompanion.insert({
    required String id,
    required String profileId,
    required String subjectId,
    required String title,
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimateMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       subjectId = Value(subjectId),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SyllabusTopic> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? priority,
    Expression<int>? estimateMinutes,
    Expression<String>? status,
    Expression<DateTime>? dueDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (estimateMinutes != null) 'estimate_minutes': estimateMinutes,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyllabusTopicsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? subjectId,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? priority,
    Value<int?>? estimateMinutes,
    Value<String>? status,
    Value<DateTime?>? dueDate,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyllabusTopicsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      estimateMinutes: estimateMinutes ?? this.estimateMinutes,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (estimateMinutes.present) {
      map['estimate_minutes'] = Variable<int>(estimateMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyllabusTopicsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('estimateMinutes: $estimateMinutes, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, Exam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examAtMeta = const VerificationMeta('examAt');
  @override
  late final GeneratedColumn<DateTime> examAt = GeneratedColumn<DateTime>(
    'exam_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    subjectId,
    name,
    examAt,
    priority,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('exam_at')) {
      context.handle(
        _examAtMeta,
        examAt.isAcceptableOrUnknown(data['exam_at']!, _examAtMeta),
      );
    } else if (isInserting) {
      context.missing(_examAtMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      examAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exam_at'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class Exam extends DataClass implements Insertable<Exam> {
  final String id;
  final String profileId;
  final String? subjectId;
  final String name;
  final DateTime examAt;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Exam({
    required this.id,
    required this.profileId,
    this.subjectId,
    required this.name,
    required this.examAt,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    map['name'] = Variable<String>(name);
    map['exam_at'] = Variable<DateTime>(examAt);
    map['priority'] = Variable<int>(priority);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      name: Value(name),
      examAt: Value(examAt),
      priority: Value(priority),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Exam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exam(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      subjectId: serializer.fromJson<String?>(json['subjectId']),
      name: serializer.fromJson<String>(json['name']),
      examAt: serializer.fromJson<DateTime>(json['examAt']),
      priority: serializer.fromJson<int>(json['priority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'subjectId': serializer.toJson<String?>(subjectId),
      'name': serializer.toJson<String>(name),
      'examAt': serializer.toJson<DateTime>(examAt),
      'priority': serializer.toJson<int>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Exam copyWith({
    String? id,
    String? profileId,
    Value<String?> subjectId = const Value.absent(),
    String? name,
    DateTime? examAt,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Exam(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    name: name ?? this.name,
    examAt: examAt ?? this.examAt,
    priority: priority ?? this.priority,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Exam copyWithCompanion(ExamsCompanion data) {
    return Exam(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      name: data.name.present ? data.name.value : this.name,
      examAt: data.examAt.present ? data.examAt.value : this.examAt,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exam(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('examAt: $examAt, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    subjectId,
    name,
    examAt,
    priority,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exam &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.subjectId == this.subjectId &&
          other.name == this.name &&
          other.examAt == this.examAt &&
          other.priority == this.priority &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExamsCompanion extends UpdateCompanion<Exam> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> subjectId;
  final Value<String> name;
  final Value<DateTime> examAt;
  final Value<int> priority;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExamsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.name = const Value.absent(),
    this.examAt = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamsCompanion.insert({
    required String id,
    required String profileId,
    this.subjectId = const Value.absent(),
    required String name,
    required DateTime examAt,
    this.priority = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       examAt = Value(examAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Exam> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? subjectId,
    Expression<String>? name,
    Expression<DateTime>? examAt,
    Expression<int>? priority,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (subjectId != null) 'subject_id': subjectId,
      if (name != null) 'name': name,
      if (examAt != null) 'exam_at': examAt,
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? subjectId,
    Value<String>? name,
    Value<DateTime>? examAt,
    Value<int>? priority,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExamsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
      examAt: examAt ?? this.examAt,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (examAt.present) {
      map['exam_at'] = Variable<DateTime>(examAt.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('examAt: $examAt, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedSecondsMeta = const VerificationMeta(
    'plannedSeconds',
  );
  @override
  late final GeneratedColumn<int> plannedSeconds = GeneratedColumn<int>(
    'planned_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pausedAtMeta = const VerificationMeta(
    'pausedAt',
  );
  @override
  late final GeneratedColumn<DateTime> pausedAt = GeneratedColumn<DateTime>(
    'paused_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accumulatedPausedMsMeta =
      const VerificationMeta('accumulatedPausedMs');
  @override
  late final GeneratedColumn<int> accumulatedPausedMs = GeneratedColumn<int>(
    'accumulated_paused_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledMeta = const VerificationMeta(
    'cancelled',
  );
  @override
  late final GeneratedColumn<bool> cancelled = GeneratedColumn<bool>(
    'cancelled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cancelled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    subjectId,
    kind,
    plannedSeconds,
    startedAt,
    pausedAt,
    accumulatedPausedMs,
    endedAt,
    cancelled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('planned_seconds')) {
      context.handle(
        _plannedSecondsMeta,
        plannedSeconds.isAcceptableOrUnknown(
          data['planned_seconds']!,
          _plannedSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedSecondsMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('paused_at')) {
      context.handle(
        _pausedAtMeta,
        pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta),
      );
    }
    if (data.containsKey('accumulated_paused_ms')) {
      context.handle(
        _accumulatedPausedMsMeta,
        accumulatedPausedMs.isAcceptableOrUnknown(
          data['accumulated_paused_ms']!,
          _accumulatedPausedMsMeta,
        ),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('cancelled')) {
      context.handle(
        _cancelledMeta,
        cancelled.isAcceptableOrUnknown(data['cancelled']!, _cancelledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      plannedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_seconds'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      pausedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paused_at'],
      ),
      accumulatedPausedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accumulated_paused_ms'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      cancelled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cancelled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySession extends DataClass implements Insertable<StudySession> {
  final String id;
  final String profileId;
  final String? subjectId;
  final String kind;
  final int plannedSeconds;
  final DateTime startedAt;
  final DateTime? pausedAt;
  final int accumulatedPausedMs;
  final DateTime? endedAt;
  final bool cancelled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudySession({
    required this.id,
    required this.profileId,
    this.subjectId,
    required this.kind,
    required this.plannedSeconds,
    required this.startedAt,
    this.pausedAt,
    required this.accumulatedPausedMs,
    this.endedAt,
    required this.cancelled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    map['kind'] = Variable<String>(kind);
    map['planned_seconds'] = Variable<int>(plannedSeconds);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || pausedAt != null) {
      map['paused_at'] = Variable<DateTime>(pausedAt);
    }
    map['accumulated_paused_ms'] = Variable<int>(accumulatedPausedMs);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['cancelled'] = Variable<bool>(cancelled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      kind: Value(kind),
      plannedSeconds: Value(plannedSeconds),
      startedAt: Value(startedAt),
      pausedAt: pausedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedAt),
      accumulatedPausedMs: Value(accumulatedPausedMs),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      cancelled: Value(cancelled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudySession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySession(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      subjectId: serializer.fromJson<String?>(json['subjectId']),
      kind: serializer.fromJson<String>(json['kind']),
      plannedSeconds: serializer.fromJson<int>(json['plannedSeconds']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      pausedAt: serializer.fromJson<DateTime?>(json['pausedAt']),
      accumulatedPausedMs: serializer.fromJson<int>(
        json['accumulatedPausedMs'],
      ),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      cancelled: serializer.fromJson<bool>(json['cancelled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'subjectId': serializer.toJson<String?>(subjectId),
      'kind': serializer.toJson<String>(kind),
      'plannedSeconds': serializer.toJson<int>(plannedSeconds),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'pausedAt': serializer.toJson<DateTime?>(pausedAt),
      'accumulatedPausedMs': serializer.toJson<int>(accumulatedPausedMs),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'cancelled': serializer.toJson<bool>(cancelled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudySession copyWith({
    String? id,
    String? profileId,
    Value<String?> subjectId = const Value.absent(),
    String? kind,
    int? plannedSeconds,
    DateTime? startedAt,
    Value<DateTime?> pausedAt = const Value.absent(),
    int? accumulatedPausedMs,
    Value<DateTime?> endedAt = const Value.absent(),
    bool? cancelled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudySession(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    kind: kind ?? this.kind,
    plannedSeconds: plannedSeconds ?? this.plannedSeconds,
    startedAt: startedAt ?? this.startedAt,
    pausedAt: pausedAt.present ? pausedAt.value : this.pausedAt,
    accumulatedPausedMs: accumulatedPausedMs ?? this.accumulatedPausedMs,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    cancelled: cancelled ?? this.cancelled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudySession copyWithCompanion(StudySessionsCompanion data) {
    return StudySession(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      kind: data.kind.present ? data.kind.value : this.kind,
      plannedSeconds: data.plannedSeconds.present
          ? data.plannedSeconds.value
          : this.plannedSeconds,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      accumulatedPausedMs: data.accumulatedPausedMs.present
          ? data.accumulatedPausedMs.value
          : this.accumulatedPausedMs,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      cancelled: data.cancelled.present ? data.cancelled.value : this.cancelled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySession(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('kind: $kind, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('accumulatedPausedMs: $accumulatedPausedMs, ')
          ..write('endedAt: $endedAt, ')
          ..write('cancelled: $cancelled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    subjectId,
    kind,
    plannedSeconds,
    startedAt,
    pausedAt,
    accumulatedPausedMs,
    endedAt,
    cancelled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySession &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.subjectId == this.subjectId &&
          other.kind == this.kind &&
          other.plannedSeconds == this.plannedSeconds &&
          other.startedAt == this.startedAt &&
          other.pausedAt == this.pausedAt &&
          other.accumulatedPausedMs == this.accumulatedPausedMs &&
          other.endedAt == this.endedAt &&
          other.cancelled == this.cancelled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudySessionsCompanion extends UpdateCompanion<StudySession> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> subjectId;
  final Value<String> kind;
  final Value<int> plannedSeconds;
  final Value<DateTime> startedAt;
  final Value<DateTime?> pausedAt;
  final Value<int> accumulatedPausedMs;
  final Value<DateTime?> endedAt;
  final Value<bool> cancelled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.kind = const Value.absent(),
    this.plannedSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.accumulatedPausedMs = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    required String profileId,
    this.subjectId = const Value.absent(),
    required String kind,
    required int plannedSeconds,
    required DateTime startedAt,
    this.pausedAt = const Value.absent(),
    this.accumulatedPausedMs = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.cancelled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       kind = Value(kind),
       plannedSeconds = Value(plannedSeconds),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudySession> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? subjectId,
    Expression<String>? kind,
    Expression<int>? plannedSeconds,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? pausedAt,
    Expression<int>? accumulatedPausedMs,
    Expression<DateTime>? endedAt,
    Expression<bool>? cancelled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (subjectId != null) 'subject_id': subjectId,
      if (kind != null) 'kind': kind,
      if (plannedSeconds != null) 'planned_seconds': plannedSeconds,
      if (startedAt != null) 'started_at': startedAt,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (accumulatedPausedMs != null)
        'accumulated_paused_ms': accumulatedPausedMs,
      if (endedAt != null) 'ended_at': endedAt,
      if (cancelled != null) 'cancelled': cancelled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? subjectId,
    Value<String>? kind,
    Value<int>? plannedSeconds,
    Value<DateTime>? startedAt,
    Value<DateTime?>? pausedAt,
    Value<int>? accumulatedPausedMs,
    Value<DateTime?>? endedAt,
    Value<bool>? cancelled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      subjectId: subjectId ?? this.subjectId,
      kind: kind ?? this.kind,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
      accumulatedPausedMs: accumulatedPausedMs ?? this.accumulatedPausedMs,
      endedAt: endedAt ?? this.endedAt,
      cancelled: cancelled ?? this.cancelled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (plannedSeconds.present) {
      map['planned_seconds'] = Variable<int>(plannedSeconds.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<DateTime>(pausedAt.value);
    }
    if (accumulatedPausedMs.present) {
      map['accumulated_paused_ms'] = Variable<int>(accumulatedPausedMs.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (cancelled.present) {
      map['cancelled'] = Variable<bool>(cancelled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('kind: $kind, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('accumulatedPausedMs: $accumulatedPausedMs, ')
          ..write('endedAt: $endedAt, ')
          ..write('cancelled: $cancelled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards
    with TableInfo<$FlashcardsTable, Flashcard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _frontMeta = const VerificationMeta('front');
  @override
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
    'front',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 2000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backMeta = const VerificationMeta('back');
  @override
  late final GeneratedColumn<String> back = GeneratedColumn<String>(
    'back',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 4000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _easeMeta = const VerificationMeta('ease');
  @override
  late final GeneratedColumn<double> ease = GeneratedColumn<double>(
    'ease',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    subjectId,
    front,
    back,
    tags,
    ease,
    intervalDays,
    repetitions,
    dueAt,
    archived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(
    Insertable<Flashcard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('front')) {
      context.handle(
        _frontMeta,
        front.isAcceptableOrUnknown(data['front']!, _frontMeta),
      );
    } else if (isInserting) {
      context.missing(_frontMeta);
    }
    if (data.containsKey('back')) {
      context.handle(
        _backMeta,
        back.isAcceptableOrUnknown(data['back']!, _backMeta),
      );
    } else if (isInserting) {
      context.missing(_backMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('ease')) {
      context.handle(
        _easeMeta,
        ease.isAcceptableOrUnknown(data['ease']!, _easeMeta),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Flashcard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Flashcard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      ),
      front: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front'],
      )!,
      back: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}back'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      ease: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class Flashcard extends DataClass implements Insertable<Flashcard> {
  final String id;
  final String profileId;
  final String? subjectId;
  final String front;
  final String back;
  final String? tags;
  final double ease;
  final int intervalDays;
  final int repetitions;
  final DateTime dueAt;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Flashcard({
    required this.id,
    required this.profileId,
    this.subjectId,
    required this.front,
    required this.back,
    this.tags,
    required this.ease,
    required this.intervalDays,
    required this.repetitions,
    required this.dueAt,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    map['front'] = Variable<String>(front);
    map['back'] = Variable<String>(back);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['ease'] = Variable<double>(ease);
    map['interval_days'] = Variable<int>(intervalDays);
    map['repetitions'] = Variable<int>(repetitions);
    map['due_at'] = Variable<DateTime>(dueAt);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      front: Value(front),
      back: Value(back),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      ease: Value(ease),
      intervalDays: Value(intervalDays),
      repetitions: Value(repetitions),
      dueAt: Value(dueAt),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Flashcard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Flashcard(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      subjectId: serializer.fromJson<String?>(json['subjectId']),
      front: serializer.fromJson<String>(json['front']),
      back: serializer.fromJson<String>(json['back']),
      tags: serializer.fromJson<String?>(json['tags']),
      ease: serializer.fromJson<double>(json['ease']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'subjectId': serializer.toJson<String?>(subjectId),
      'front': serializer.toJson<String>(front),
      'back': serializer.toJson<String>(back),
      'tags': serializer.toJson<String?>(tags),
      'ease': serializer.toJson<double>(ease),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'repetitions': serializer.toJson<int>(repetitions),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Flashcard copyWith({
    String? id,
    String? profileId,
    Value<String?> subjectId = const Value.absent(),
    String? front,
    String? back,
    Value<String?> tags = const Value.absent(),
    double? ease,
    int? intervalDays,
    int? repetitions,
    DateTime? dueAt,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Flashcard(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    front: front ?? this.front,
    back: back ?? this.back,
    tags: tags.present ? tags.value : this.tags,
    ease: ease ?? this.ease,
    intervalDays: intervalDays ?? this.intervalDays,
    repetitions: repetitions ?? this.repetitions,
    dueAt: dueAt ?? this.dueAt,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Flashcard copyWithCompanion(FlashcardsCompanion data) {
    return Flashcard(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      front: data.front.present ? data.front.value : this.front,
      back: data.back.present ? data.back.value : this.back,
      tags: data.tags.present ? data.tags.value : this.tags,
      ease: data.ease.present ? data.ease.value : this.ease,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Flashcard(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('tags: $tags, ')
          ..write('ease: $ease, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('dueAt: $dueAt, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    subjectId,
    front,
    back,
    tags,
    ease,
    intervalDays,
    repetitions,
    dueAt,
    archived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Flashcard &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.subjectId == this.subjectId &&
          other.front == this.front &&
          other.back == this.back &&
          other.tags == this.tags &&
          other.ease == this.ease &&
          other.intervalDays == this.intervalDays &&
          other.repetitions == this.repetitions &&
          other.dueAt == this.dueAt &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FlashcardsCompanion extends UpdateCompanion<Flashcard> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> subjectId;
  final Value<String> front;
  final Value<String> back;
  final Value<String?> tags;
  final Value<double> ease;
  final Value<int> intervalDays;
  final Value<int> repetitions;
  final Value<DateTime> dueAt;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.tags = const Value.absent(),
    this.ease = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    required String id,
    required String profileId,
    this.subjectId = const Value.absent(),
    required String front,
    required String back,
    this.tags = const Value.absent(),
    this.ease = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    required DateTime dueAt,
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       front = Value(front),
       back = Value(back),
       dueAt = Value(dueAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Flashcard> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? subjectId,
    Expression<String>? front,
    Expression<String>? back,
    Expression<String>? tags,
    Expression<double>? ease,
    Expression<int>? intervalDays,
    Expression<int>? repetitions,
    Expression<DateTime>? dueAt,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (subjectId != null) 'subject_id': subjectId,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (tags != null) 'tags': tags,
      if (ease != null) 'ease': ease,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (repetitions != null) 'repetitions': repetitions,
      if (dueAt != null) 'due_at': dueAt,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? subjectId,
    Value<String>? front,
    Value<String>? back,
    Value<String?>? tags,
    Value<double>? ease,
    Value<int>? intervalDays,
    Value<int>? repetitions,
    Value<DateTime>? dueAt,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      subjectId: subjectId ?? this.subjectId,
      front: front ?? this.front,
      back: back ?? this.back,
      tags: tags ?? this.tags,
      ease: ease ?? this.ease,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      dueAt: dueAt ?? this.dueAt,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (ease.present) {
      map['ease'] = Variable<double>(ease.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('subjectId: $subjectId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('tags: $tags, ')
          ..write('ease: $ease, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('dueAt: $dueAt, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardReviewsTable extends FlashcardReviews
    with TableInfo<$FlashcardReviewsTable, FlashcardReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flashcards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<String> rating = GeneratedColumn<String>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalAfterDaysMeta = const VerificationMeta(
    'intervalAfterDays',
  );
  @override
  late final GeneratedColumn<int> intervalAfterDays = GeneratedColumn<int>(
    'interval_after_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _easeAfterMeta = const VerificationMeta(
    'easeAfter',
  );
  @override
  late final GeneratedColumn<double> easeAfter = GeneratedColumn<double>(
    'ease_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    cardId,
    rating,
    reviewedAt,
    intervalAfterDays,
    easeAfter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcard_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashcardReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('interval_after_days')) {
      context.handle(
        _intervalAfterDaysMeta,
        intervalAfterDays.isAcceptableOrUnknown(
          data['interval_after_days']!,
          _intervalAfterDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalAfterDaysMeta);
    }
    if (data.containsKey('ease_after')) {
      context.handle(
        _easeAfterMeta,
        easeAfter.isAcceptableOrUnknown(data['ease_after']!, _easeAfterMeta),
      );
    } else if (isInserting) {
      context.missing(_easeAfterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashcardReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardReview(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rating'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
      intervalAfterDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_after_days'],
      )!,
      easeAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_after'],
      )!,
    );
  }

  @override
  $FlashcardReviewsTable createAlias(String alias) {
    return $FlashcardReviewsTable(attachedDatabase, alias);
  }
}

class FlashcardReview extends DataClass implements Insertable<FlashcardReview> {
  final String id;
  final String profileId;
  final String cardId;
  final String rating;
  final DateTime reviewedAt;
  final int intervalAfterDays;
  final double easeAfter;
  const FlashcardReview({
    required this.id,
    required this.profileId,
    required this.cardId,
    required this.rating,
    required this.reviewedAt,
    required this.intervalAfterDays,
    required this.easeAfter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['card_id'] = Variable<String>(cardId);
    map['rating'] = Variable<String>(rating);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    map['interval_after_days'] = Variable<int>(intervalAfterDays);
    map['ease_after'] = Variable<double>(easeAfter);
    return map;
  }

  FlashcardReviewsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardReviewsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      cardId: Value(cardId),
      rating: Value(rating),
      reviewedAt: Value(reviewedAt),
      intervalAfterDays: Value(intervalAfterDays),
      easeAfter: Value(easeAfter),
    );
  }

  factory FlashcardReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardReview(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      rating: serializer.fromJson<String>(json['rating']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
      intervalAfterDays: serializer.fromJson<int>(json['intervalAfterDays']),
      easeAfter: serializer.fromJson<double>(json['easeAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'cardId': serializer.toJson<String>(cardId),
      'rating': serializer.toJson<String>(rating),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
      'intervalAfterDays': serializer.toJson<int>(intervalAfterDays),
      'easeAfter': serializer.toJson<double>(easeAfter),
    };
  }

  FlashcardReview copyWith({
    String? id,
    String? profileId,
    String? cardId,
    String? rating,
    DateTime? reviewedAt,
    int? intervalAfterDays,
    double? easeAfter,
  }) => FlashcardReview(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    cardId: cardId ?? this.cardId,
    rating: rating ?? this.rating,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    intervalAfterDays: intervalAfterDays ?? this.intervalAfterDays,
    easeAfter: easeAfter ?? this.easeAfter,
  );
  FlashcardReview copyWithCompanion(FlashcardReviewsCompanion data) {
    return FlashcardReview(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      intervalAfterDays: data.intervalAfterDays.present
          ? data.intervalAfterDays.value
          : this.intervalAfterDays,
      easeAfter: data.easeAfter.present ? data.easeAfter.value : this.easeAfter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardReview(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('intervalAfterDays: $intervalAfterDays, ')
          ..write('easeAfter: $easeAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    cardId,
    rating,
    reviewedAt,
    intervalAfterDays,
    easeAfter,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardReview &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.cardId == this.cardId &&
          other.rating == this.rating &&
          other.reviewedAt == this.reviewedAt &&
          other.intervalAfterDays == this.intervalAfterDays &&
          other.easeAfter == this.easeAfter);
}

class FlashcardReviewsCompanion extends UpdateCompanion<FlashcardReview> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> cardId;
  final Value<String> rating;
  final Value<DateTime> reviewedAt;
  final Value<int> intervalAfterDays;
  final Value<double> easeAfter;
  final Value<int> rowid;
  const FlashcardReviewsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.intervalAfterDays = const Value.absent(),
    this.easeAfter = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardReviewsCompanion.insert({
    required String id,
    required String profileId,
    required String cardId,
    required String rating,
    required DateTime reviewedAt,
    required int intervalAfterDays,
    required double easeAfter,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       cardId = Value(cardId),
       rating = Value(rating),
       reviewedAt = Value(reviewedAt),
       intervalAfterDays = Value(intervalAfterDays),
       easeAfter = Value(easeAfter);
  static Insertable<FlashcardReview> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? cardId,
    Expression<String>? rating,
    Expression<DateTime>? reviewedAt,
    Expression<int>? intervalAfterDays,
    Expression<double>? easeAfter,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (cardId != null) 'card_id': cardId,
      if (rating != null) 'rating': rating,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (intervalAfterDays != null) 'interval_after_days': intervalAfterDays,
      if (easeAfter != null) 'ease_after': easeAfter,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardReviewsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? cardId,
    Value<String>? rating,
    Value<DateTime>? reviewedAt,
    Value<int>? intervalAfterDays,
    Value<double>? easeAfter,
    Value<int>? rowid,
  }) {
    return FlashcardReviewsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      cardId: cardId ?? this.cardId,
      rating: rating ?? this.rating,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      intervalAfterDays: intervalAfterDays ?? this.intervalAfterDays,
      easeAfter: easeAfter ?? this.easeAfter,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (intervalAfterDays.present) {
      map['interval_after_days'] = Variable<int>(intervalAfterDays.value);
    }
    if (easeAfter.present) {
      map['ease_after'] = Variable<double>(easeAfter.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardReviewsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('intervalAfterDays: $intervalAfterDays, ')
          ..write('easeAfter: $easeAfter, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WaterLogsTable extends WaterLogs
    with TableInfo<$WaterLogsTable, WaterLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMlMeta = const VerificationMeta(
    'amountMl',
  );
  @override
  late final GeneratedColumn<int> amountMl = GeneratedColumn<int>(
    'amount_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    amountMl,
    loggedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('amount_ml')) {
      context.handle(
        _amountMlMeta,
        amountMl.isAcceptableOrUnknown(data['amount_ml']!, _amountMlMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMlMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      amountMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_ml'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WaterLogsTable createAlias(String alias) {
    return $WaterLogsTable(attachedDatabase, alias);
  }
}

class WaterLog extends DataClass implements Insertable<WaterLog> {
  final String id;
  final String profileId;
  final int amountMl;
  final DateTime loggedAt;
  final DateTime createdAt;
  const WaterLog({
    required this.id,
    required this.profileId,
    required this.amountMl,
    required this.loggedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['amount_ml'] = Variable<int>(amountMl);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WaterLogsCompanion toCompanion(bool nullToAbsent) {
    return WaterLogsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      amountMl: Value(amountMl),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
    );
  }

  factory WaterLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterLog(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      amountMl: serializer.fromJson<int>(json['amountMl']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'amountMl': serializer.toJson<int>(amountMl),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WaterLog copyWith({
    String? id,
    String? profileId,
    int? amountMl,
    DateTime? loggedAt,
    DateTime? createdAt,
  }) => WaterLog(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    amountMl: amountMl ?? this.amountMl,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  WaterLog copyWithCompanion(WaterLogsCompanion data) {
    return WaterLog(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      amountMl: data.amountMl.present ? data.amountMl.value : this.amountMl,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterLog(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('amountMl: $amountMl, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, amountMl, loggedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterLog &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.amountMl == this.amountMl &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt);
}

class WaterLogsCompanion extends UpdateCompanion<WaterLog> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<int> amountMl;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WaterLogsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.amountMl = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaterLogsCompanion.insert({
    required String id,
    required String profileId,
    required int amountMl,
    required DateTime loggedAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       amountMl = Value(amountMl),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt);
  static Insertable<WaterLog> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<int>? amountMl,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (amountMl != null) 'amount_ml': amountMl,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaterLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<int>? amountMl,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WaterLogsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      amountMl: amountMl ?? this.amountMl,
      loggedAt: loggedAt ?? this.loggedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (amountMl.present) {
      map['amount_ml'] = Variable<int>(amountMl.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterLogsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('amountMl: $amountMl, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FastingSessionsTable extends FastingSessions
    with TableInfo<$FastingSessionsTable, FastingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FastingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedSecondsMeta = const VerificationMeta(
    'plannedSeconds',
  );
  @override
  late final GeneratedColumn<int> plannedSeconds = GeneratedColumn<int>(
    'planned_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    startedAt,
    plannedSeconds,
    endedAt,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fasting_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FastingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('planned_seconds')) {
      context.handle(
        _plannedSecondsMeta,
        plannedSeconds.isAcceptableOrUnknown(
          data['planned_seconds']!,
          _plannedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FastingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FastingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      plannedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_seconds'],
      ),
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FastingSessionsTable createAlias(String alias) {
    return $FastingSessionsTable(attachedDatabase, alias);
  }
}

class FastingSession extends DataClass implements Insertable<FastingSession> {
  final String id;
  final String profileId;
  final DateTime startedAt;
  final int? plannedSeconds;
  final DateTime? endedAt;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FastingSession({
    required this.id,
    required this.profileId,
    required this.startedAt,
    this.plannedSeconds,
    this.endedAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || plannedSeconds != null) {
      map['planned_seconds'] = Variable<int>(plannedSeconds);
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FastingSessionsCompanion toCompanion(bool nullToAbsent) {
    return FastingSessionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      startedAt: Value(startedAt),
      plannedSeconds: plannedSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedSeconds),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FastingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FastingSession(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      plannedSeconds: serializer.fromJson<int?>(json['plannedSeconds']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'plannedSeconds': serializer.toJson<int?>(plannedSeconds),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FastingSession copyWith({
    String? id,
    String? profileId,
    DateTime? startedAt,
    Value<int?> plannedSeconds = const Value.absent(),
    Value<DateTime?> endedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FastingSession(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    startedAt: startedAt ?? this.startedAt,
    plannedSeconds: plannedSeconds.present
        ? plannedSeconds.value
        : this.plannedSeconds,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FastingSession copyWithCompanion(FastingSessionsCompanion data) {
    return FastingSession(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      plannedSeconds: data.plannedSeconds.present
          ? data.plannedSeconds.value
          : this.plannedSeconds,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FastingSession(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    startedAt,
    plannedSeconds,
    endedAt,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FastingSession &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.startedAt == this.startedAt &&
          other.plannedSeconds == this.plannedSeconds &&
          other.endedAt == this.endedAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FastingSessionsCompanion extends UpdateCompanion<FastingSession> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<DateTime> startedAt;
  final Value<int?> plannedSeconds;
  final Value<DateTime?> endedAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FastingSessionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.plannedSeconds = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FastingSessionsCompanion.insert({
    required String id,
    required String profileId,
    required DateTime startedAt,
    this.plannedSeconds = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FastingSession> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<DateTime>? startedAt,
    Expression<int>? plannedSeconds,
    Expression<DateTime>? endedAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (startedAt != null) 'started_at': startedAt,
      if (plannedSeconds != null) 'planned_seconds': plannedSeconds,
      if (endedAt != null) 'ended_at': endedAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FastingSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<DateTime>? startedAt,
    Value<int?>? plannedSeconds,
    Value<DateTime?>? endedAt,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FastingSessionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      startedAt: startedAt ?? this.startedAt,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      endedAt: endedAt ?? this.endedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (plannedSeconds.present) {
      map['planned_seconds'] = Variable<int>(plannedSeconds.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FastingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _workoutKeyMeta = const VerificationMeta(
    'workoutKey',
  );
  @override
  late final GeneratedColumn<String> workoutKey = GeneratedColumn<String>(
    'workout_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutNameMeta = const VerificationMeta(
    'workoutName',
  );
  @override
  late final GeneratedColumn<String> workoutName = GeneratedColumn<String>(
    'workout_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exercisesCompletedMeta =
      const VerificationMeta('exercisesCompleted');
  @override
  late final GeneratedColumn<int> exercisesCompleted = GeneratedColumn<int>(
    'exercises_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exercisesTotalMeta = const VerificationMeta(
    'exercisesTotal',
  );
  @override
  late final GeneratedColumn<int> exercisesTotal = GeneratedColumn<int>(
    'exercises_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    workoutKey,
    workoutName,
    startedAt,
    endedAt,
    exercisesCompleted,
    exercisesTotal,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('workout_key')) {
      context.handle(
        _workoutKeyMeta,
        workoutKey.isAcceptableOrUnknown(data['workout_key']!, _workoutKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutKeyMeta);
    }
    if (data.containsKey('workout_name')) {
      context.handle(
        _workoutNameMeta,
        workoutName.isAcceptableOrUnknown(
          data['workout_name']!,
          _workoutNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutNameMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('exercises_completed')) {
      context.handle(
        _exercisesCompletedMeta,
        exercisesCompleted.isAcceptableOrUnknown(
          data['exercises_completed']!,
          _exercisesCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exercisesCompletedMeta);
    }
    if (data.containsKey('exercises_total')) {
      context.handle(
        _exercisesTotalMeta,
        exercisesTotal.isAcceptableOrUnknown(
          data['exercises_total']!,
          _exercisesTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exercisesTotalMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      workoutKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_key'],
      )!,
      workoutName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_name'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      exercisesCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercises_completed'],
      )!,
      exercisesTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercises_total'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final String id;
  final String profileId;
  final String workoutKey;
  final String workoutName;
  final DateTime startedAt;
  final DateTime endedAt;
  final int exercisesCompleted;
  final int exercisesTotal;
  final String? notes;
  final DateTime createdAt;
  const WorkoutSession({
    required this.id,
    required this.profileId,
    required this.workoutKey,
    required this.workoutName,
    required this.startedAt,
    required this.endedAt,
    required this.exercisesCompleted,
    required this.exercisesTotal,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['workout_key'] = Variable<String>(workoutKey);
    map['workout_name'] = Variable<String>(workoutName);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['exercises_completed'] = Variable<int>(exercisesCompleted);
    map['exercises_total'] = Variable<int>(exercisesTotal);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      workoutKey: Value(workoutKey),
      workoutName: Value(workoutName),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      exercisesCompleted: Value(exercisesCompleted),
      exercisesTotal: Value(exercisesTotal),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      workoutKey: serializer.fromJson<String>(json['workoutKey']),
      workoutName: serializer.fromJson<String>(json['workoutName']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      exercisesCompleted: serializer.fromJson<int>(json['exercisesCompleted']),
      exercisesTotal: serializer.fromJson<int>(json['exercisesTotal']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'workoutKey': serializer.toJson<String>(workoutKey),
      'workoutName': serializer.toJson<String>(workoutName),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'exercisesCompleted': serializer.toJson<int>(exercisesCompleted),
      'exercisesTotal': serializer.toJson<int>(exercisesTotal),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkoutSession copyWith({
    String? id,
    String? profileId,
    String? workoutKey,
    String? workoutName,
    DateTime? startedAt,
    DateTime? endedAt,
    int? exercisesCompleted,
    int? exercisesTotal,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => WorkoutSession(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    workoutKey: workoutKey ?? this.workoutKey,
    workoutName: workoutName ?? this.workoutName,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
    exercisesTotal: exercisesTotal ?? this.exercisesTotal,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      workoutKey: data.workoutKey.present
          ? data.workoutKey.value
          : this.workoutKey,
      workoutName: data.workoutName.present
          ? data.workoutName.value
          : this.workoutName,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      exercisesCompleted: data.exercisesCompleted.present
          ? data.exercisesCompleted.value
          : this.exercisesCompleted,
      exercisesTotal: data.exercisesTotal.present
          ? data.exercisesTotal.value
          : this.exercisesTotal,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('workoutKey: $workoutKey, ')
          ..write('workoutName: $workoutName, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('exercisesCompleted: $exercisesCompleted, ')
          ..write('exercisesTotal: $exercisesTotal, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    workoutKey,
    workoutName,
    startedAt,
    endedAt,
    exercisesCompleted,
    exercisesTotal,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.workoutKey == this.workoutKey &&
          other.workoutName == this.workoutName &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.exercisesCompleted == this.exercisesCompleted &&
          other.exercisesTotal == this.exercisesTotal &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> workoutKey;
  final Value<String> workoutName;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> exercisesCompleted;
  final Value<int> exercisesTotal;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.workoutKey = const Value.absent(),
    this.workoutName = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.exercisesCompleted = const Value.absent(),
    this.exercisesTotal = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required String profileId,
    required String workoutKey,
    required String workoutName,
    required DateTime startedAt,
    required DateTime endedAt,
    required int exercisesCompleted,
    required int exercisesTotal,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       workoutKey = Value(workoutKey),
       workoutName = Value(workoutName),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       exercisesCompleted = Value(exercisesCompleted),
       exercisesTotal = Value(exercisesTotal),
       createdAt = Value(createdAt);
  static Insertable<WorkoutSession> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? workoutKey,
    Expression<String>? workoutName,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? exercisesCompleted,
    Expression<int>? exercisesTotal,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (workoutKey != null) 'workout_key': workoutKey,
      if (workoutName != null) 'workout_name': workoutName,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (exercisesCompleted != null) 'exercises_completed': exercisesCompleted,
      if (exercisesTotal != null) 'exercises_total': exercisesTotal,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? workoutKey,
    Value<String>? workoutName,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? exercisesCompleted,
    Value<int>? exercisesTotal,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      workoutKey: workoutKey ?? this.workoutKey,
      workoutName: workoutName ?? this.workoutName,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
      exercisesTotal: exercisesTotal ?? this.exercisesTotal,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (workoutKey.present) {
      map['workout_key'] = Variable<String>(workoutKey.value);
    }
    if (workoutName.present) {
      map['workout_name'] = Variable<String>(workoutName.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (exercisesCompleted.present) {
      map['exercises_completed'] = Variable<int>(exercisesCompleted.value);
    }
    if (exercisesTotal.present) {
      map['exercises_total'] = Variable<int>(exercisesTotal.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('workoutKey: $workoutKey, ')
          ..write('workoutName: $workoutName, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('exercisesCompleted: $exercisesCompleted, ')
          ..write('exercisesTotal: $exercisesTotal, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wentWellMeta = const VerificationMeta(
    'wentWell',
  );
  @override
  late final GeneratedColumn<String> wentWell = GeneratedColumn<String>(
    'went_well',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _learnedMeta = const VerificationMeta(
    'learned',
  );
  @override
  late final GeneratedColumn<String> learned = GeneratedColumn<String>(
    'learned',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _improveMeta = const VerificationMeta(
    'improve',
  );
  @override
  late final GeneratedColumn<String> improve = GeneratedColumn<String>(
    'improve',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _gratefulMeta = const VerificationMeta(
    'grateful',
  );
  @override
  late final GeneratedColumn<String> grateful = GeneratedColumn<String>(
    'grateful',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    day,
    wentWell,
    learned,
    improve,
    grateful,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('went_well')) {
      context.handle(
        _wentWellMeta,
        wentWell.isAcceptableOrUnknown(data['went_well']!, _wentWellMeta),
      );
    }
    if (data.containsKey('learned')) {
      context.handle(
        _learnedMeta,
        learned.isAcceptableOrUnknown(data['learned']!, _learnedMeta),
      );
    }
    if (data.containsKey('improve')) {
      context.handle(
        _improveMeta,
        improve.isAcceptableOrUnknown(data['improve']!, _improveMeta),
      );
    }
    if (data.containsKey('grateful')) {
      context.handle(
        _gratefulMeta,
        grateful.isAcceptableOrUnknown(data['grateful']!, _gratefulMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, day},
  ];
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      wentWell: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well'],
      )!,
      learned: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learned'],
      )!,
      improve: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}improve'],
      )!,
      grateful: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grateful'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final String id;
  final String profileId;
  final String day;
  final String wentWell;
  final String learned;
  final String improve;
  final String grateful;
  final DateTime createdAt;
  final DateTime updatedAt;
  const JournalEntry({
    required this.id,
    required this.profileId,
    required this.day,
    required this.wentWell,
    required this.learned,
    required this.improve,
    required this.grateful,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['day'] = Variable<String>(day);
    map['went_well'] = Variable<String>(wentWell);
    map['learned'] = Variable<String>(learned);
    map['improve'] = Variable<String>(improve);
    map['grateful'] = Variable<String>(grateful);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      day: Value(day),
      wentWell: Value(wentWell),
      learned: Value(learned),
      improve: Value(improve),
      grateful: Value(grateful),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      day: serializer.fromJson<String>(json['day']),
      wentWell: serializer.fromJson<String>(json['wentWell']),
      learned: serializer.fromJson<String>(json['learned']),
      improve: serializer.fromJson<String>(json['improve']),
      grateful: serializer.fromJson<String>(json['grateful']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'day': serializer.toJson<String>(day),
      'wentWell': serializer.toJson<String>(wentWell),
      'learned': serializer.toJson<String>(learned),
      'improve': serializer.toJson<String>(improve),
      'grateful': serializer.toJson<String>(grateful),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  JournalEntry copyWith({
    String? id,
    String? profileId,
    String? day,
    String? wentWell,
    String? learned,
    String? improve,
    String? grateful,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => JournalEntry(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    day: day ?? this.day,
    wentWell: wentWell ?? this.wentWell,
    learned: learned ?? this.learned,
    improve: improve ?? this.improve,
    grateful: grateful ?? this.grateful,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      day: data.day.present ? data.day.value : this.day,
      wentWell: data.wentWell.present ? data.wentWell.value : this.wentWell,
      learned: data.learned.present ? data.learned.value : this.learned,
      improve: data.improve.present ? data.improve.value : this.improve,
      grateful: data.grateful.present ? data.grateful.value : this.grateful,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('wentWell: $wentWell, ')
          ..write('learned: $learned, ')
          ..write('improve: $improve, ')
          ..write('grateful: $grateful, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    day,
    wentWell,
    learned,
    improve,
    grateful,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.day == this.day &&
          other.wentWell == this.wentWell &&
          other.learned == this.learned &&
          other.improve == this.improve &&
          other.grateful == this.grateful &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> day;
  final Value<String> wentWell;
  final Value<String> learned;
  final Value<String> improve;
  final Value<String> grateful;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.day = const Value.absent(),
    this.wentWell = const Value.absent(),
    this.learned = const Value.absent(),
    this.improve = const Value.absent(),
    this.grateful = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String profileId,
    required String day,
    this.wentWell = const Value.absent(),
    this.learned = const Value.absent(),
    this.improve = const Value.absent(),
    this.grateful = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       day = Value(day),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<JournalEntry> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? day,
    Expression<String>? wentWell,
    Expression<String>? learned,
    Expression<String>? improve,
    Expression<String>? grateful,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (day != null) 'day': day,
      if (wentWell != null) 'went_well': wentWell,
      if (learned != null) 'learned': learned,
      if (improve != null) 'improve': improve,
      if (grateful != null) 'grateful': grateful,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? day,
    Value<String>? wentWell,
    Value<String>? learned,
    Value<String>? improve,
    Value<String>? grateful,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      day: day ?? this.day,
      wentWell: wentWell ?? this.wentWell,
      learned: learned ?? this.learned,
      improve: improve ?? this.improve,
      grateful: grateful ?? this.grateful,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (wentWell.present) {
      map['went_well'] = Variable<String>(wentWell.value);
    }
    if (learned.present) {
      map['learned'] = Variable<String>(learned.value);
    }
    if (improve.present) {
      map['improve'] = Variable<String>(improve.value);
    }
    if (grateful.present) {
      map['grateful'] = Variable<String>(grateful.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('wentWell: $wentWell, ')
          ..write('learned: $learned, ')
          ..write('improve: $improve, ')
          ..write('grateful: $grateful, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementAwardsTable extends AchievementAwards
    with TableInfo<$AchievementAwardsTable, AchievementAward> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementAwardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awardedAtMeta = const VerificationMeta(
    'awardedAt',
  );
  @override
  late final GeneratedColumn<DateTime> awardedAt = GeneratedColumn<DateTime>(
    'awarded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    achievementId,
    awardedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievement_awards';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementAward> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('awarded_at')) {
      context.handle(
        _awardedAtMeta,
        awardedAt.isAcceptableOrUnknown(data['awarded_at']!, _awardedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_awardedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, achievementId},
  ];
  @override
  AchievementAward map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementAward(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      achievementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_id'],
      )!,
      awardedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}awarded_at'],
      )!,
    );
  }

  @override
  $AchievementAwardsTable createAlias(String alias) {
    return $AchievementAwardsTable(attachedDatabase, alias);
  }
}

class AchievementAward extends DataClass
    implements Insertable<AchievementAward> {
  final String id;
  final String profileId;
  final String achievementId;
  final DateTime awardedAt;
  const AchievementAward({
    required this.id,
    required this.profileId,
    required this.achievementId,
    required this.awardedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['achievement_id'] = Variable<String>(achievementId);
    map['awarded_at'] = Variable<DateTime>(awardedAt);
    return map;
  }

  AchievementAwardsCompanion toCompanion(bool nullToAbsent) {
    return AchievementAwardsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      achievementId: Value(achievementId),
      awardedAt: Value(awardedAt),
    );
  }

  factory AchievementAward.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementAward(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      achievementId: serializer.fromJson<String>(json['achievementId']),
      awardedAt: serializer.fromJson<DateTime>(json['awardedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'achievementId': serializer.toJson<String>(achievementId),
      'awardedAt': serializer.toJson<DateTime>(awardedAt),
    };
  }

  AchievementAward copyWith({
    String? id,
    String? profileId,
    String? achievementId,
    DateTime? awardedAt,
  }) => AchievementAward(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    achievementId: achievementId ?? this.achievementId,
    awardedAt: awardedAt ?? this.awardedAt,
  );
  AchievementAward copyWithCompanion(AchievementAwardsCompanion data) {
    return AchievementAward(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      achievementId: data.achievementId.present
          ? data.achievementId.value
          : this.achievementId,
      awardedAt: data.awardedAt.present ? data.awardedAt.value : this.awardedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementAward(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('achievementId: $achievementId, ')
          ..write('awardedAt: $awardedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, achievementId, awardedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementAward &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.achievementId == this.achievementId &&
          other.awardedAt == this.awardedAt);
}

class AchievementAwardsCompanion extends UpdateCompanion<AchievementAward> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> achievementId;
  final Value<DateTime> awardedAt;
  final Value<int> rowid;
  const AchievementAwardsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.achievementId = const Value.absent(),
    this.awardedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementAwardsCompanion.insert({
    required String id,
    required String profileId,
    required String achievementId,
    required DateTime awardedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       achievementId = Value(achievementId),
       awardedAt = Value(awardedAt);
  static Insertable<AchievementAward> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? achievementId,
    Expression<DateTime>? awardedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (achievementId != null) 'achievement_id': achievementId,
      if (awardedAt != null) 'awarded_at': awardedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementAwardsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? achievementId,
    Value<DateTime>? awardedAt,
    Value<int>? rowid,
  }) {
    return AchievementAwardsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      achievementId: achievementId ?? this.achievementId,
      awardedAt: awardedAt ?? this.awardedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (awardedAt.present) {
      map['awarded_at'] = Variable<DateTime>(awardedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementAwardsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('achievementId: $achievementId, ')
          ..write('awardedAt: $awardedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyPlansTable extends DailyPlans
    with TableInfo<$DailyPlansTable, DailyPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileId, day, generatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, day},
  ];
  @override
  DailyPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $DailyPlansTable createAlias(String alias) {
    return $DailyPlansTable(attachedDatabase, alias);
  }
}

class DailyPlan extends DataClass implements Insertable<DailyPlan> {
  final String id;
  final String profileId;
  final String day;
  final DateTime generatedAt;
  const DailyPlan({
    required this.id,
    required this.profileId,
    required this.day,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['day'] = Variable<String>(day);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  DailyPlansCompanion toCompanion(bool nullToAbsent) {
    return DailyPlansCompanion(
      id: Value(id),
      profileId: Value(profileId),
      day: Value(day),
      generatedAt: Value(generatedAt),
    );
  }

  factory DailyPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyPlan(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      day: serializer.fromJson<String>(json['day']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'day': serializer.toJson<String>(day),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  DailyPlan copyWith({
    String? id,
    String? profileId,
    String? day,
    DateTime? generatedAt,
  }) => DailyPlan(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    day: day ?? this.day,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  DailyPlan copyWithCompanion(DailyPlansCompanion data) {
    return DailyPlan(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      day: data.day.present ? data.day.value : this.day,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlan(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, day, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyPlan &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.day == this.day &&
          other.generatedAt == this.generatedAt);
}

class DailyPlansCompanion extends UpdateCompanion<DailyPlan> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> day;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const DailyPlansCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.day = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyPlansCompanion.insert({
    required String id,
    required String profileId,
    required String day,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       day = Value(day),
       generatedAt = Value(generatedAt);
  static Insertable<DailyPlan> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? day,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (day != null) 'day': day,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? day,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return DailyPlansCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      day: day ?? this.day,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlansCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('day: $day, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlannedActivitiesTable extends PlannedActivities
    with TableInfo<$PlannedActivitiesTable, PlannedActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannedActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
    'pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    planId,
    kind,
    title,
    startAt,
    endAt,
    status,
    pinned,
    reason,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planned_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlannedActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('pinned')) {
      context.handle(
        _pinnedMeta,
        pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannedActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannedActivity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      pinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pinned'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlannedActivitiesTable createAlias(String alias) {
    return $PlannedActivitiesTable(attachedDatabase, alias);
  }
}

class PlannedActivity extends DataClass implements Insertable<PlannedActivity> {
  final String id;
  final String profileId;
  final String planId;
  final String kind;
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final bool pinned;
  final String? reason;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlannedActivity({
    required this.id,
    required this.profileId,
    required this.planId,
    required this.kind,
    required this.title,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.pinned,
    this.reason,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['plan_id'] = Variable<String>(planId);
    map['kind'] = Variable<String>(kind);
    map['title'] = Variable<String>(title);
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['status'] = Variable<String>(status);
    map['pinned'] = Variable<bool>(pinned);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlannedActivitiesCompanion toCompanion(bool nullToAbsent) {
    return PlannedActivitiesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      planId: Value(planId),
      kind: Value(kind),
      title: Value(title),
      startAt: Value(startAt),
      endAt: Value(endAt),
      status: Value(status),
      pinned: Value(pinned),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlannedActivity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannedActivity(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      planId: serializer.fromJson<String>(json['planId']),
      kind: serializer.fromJson<String>(json['kind']),
      title: serializer.fromJson<String>(json['title']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      status: serializer.fromJson<String>(json['status']),
      pinned: serializer.fromJson<bool>(json['pinned']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'planId': serializer.toJson<String>(planId),
      'kind': serializer.toJson<String>(kind),
      'title': serializer.toJson<String>(title),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'status': serializer.toJson<String>(status),
      'pinned': serializer.toJson<bool>(pinned),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlannedActivity copyWith({
    String? id,
    String? profileId,
    String? planId,
    String? kind,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? status,
    bool? pinned,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlannedActivity(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    planId: planId ?? this.planId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    pinned: pinned ?? this.pinned,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlannedActivity copyWithCompanion(PlannedActivitiesCompanion data) {
    return PlannedActivity(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      planId: data.planId.present ? data.planId.value : this.planId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      status: data.status.present ? data.status.value : this.status,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannedActivity(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('planId: $planId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('status: $status, ')
          ..write('pinned: $pinned, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    planId,
    kind,
    title,
    startAt,
    endAt,
    status,
    pinned,
    reason,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannedActivity &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.planId == this.planId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.status == this.status &&
          other.pinned == this.pinned &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlannedActivitiesCompanion extends UpdateCompanion<PlannedActivity> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> planId;
  final Value<String> kind;
  final Value<String> title;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<String> status;
  final Value<bool> pinned;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PlannedActivitiesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.planId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.status = const Value.absent(),
    this.pinned = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlannedActivitiesCompanion.insert({
    required String id,
    required String profileId,
    required String planId,
    required String kind,
    required String title,
    required DateTime startAt,
    required DateTime endAt,
    this.status = const Value.absent(),
    this.pinned = const Value.absent(),
    this.reason = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       planId = Value(planId),
       kind = Value(kind),
       title = Value(title),
       startAt = Value(startAt),
       endAt = Value(endAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PlannedActivity> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? planId,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<String>? status,
    Expression<bool>? pinned,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (planId != null) 'plan_id': planId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (status != null) 'status': status,
      if (pinned != null) 'pinned': pinned,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlannedActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? planId,
    Value<String>? kind,
    Value<String>? title,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<String>? status,
    Value<bool>? pinned,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PlannedActivitiesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      planId: planId ?? this.planId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      status: status ?? this.status,
      pinned: pinned ?? this.pinned,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannedActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('planId: $planId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('status: $status, ')
          ..write('pinned: $pinned, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncSettingsTable extends SyncSettings
    with TableInfo<$SyncSettingsTable, SyncSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncPrayerMeta = const VerificationMeta(
    'syncPrayer',
  );
  @override
  late final GeneratedColumn<bool> syncPrayer = GeneratedColumn<bool>(
    'sync_prayer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_prayer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncStudyMeta = const VerificationMeta(
    'syncStudy',
  );
  @override
  late final GeneratedColumn<bool> syncStudy = GeneratedColumn<bool>(
    'sync_study',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_study" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncFitnessMeta = const VerificationMeta(
    'syncFitness',
  );
  @override
  late final GeneratedColumn<bool> syncFitness = GeneratedColumn<bool>(
    'sync_fitness',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_fitness" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncJournalMeta = const VerificationMeta(
    'syncJournal',
  );
  @override
  late final GeneratedColumn<bool> syncJournal = GeneratedColumn<bool>(
    'sync_journal',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_journal" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSyncAtMeta = const VerificationMeta(
    'lastSyncAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
    'last_sync_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    enabled,
    syncPrayer,
    syncStudy,
    syncFitness,
    syncJournal,
    lastSyncAt,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('sync_prayer')) {
      context.handle(
        _syncPrayerMeta,
        syncPrayer.isAcceptableOrUnknown(data['sync_prayer']!, _syncPrayerMeta),
      );
    }
    if (data.containsKey('sync_study')) {
      context.handle(
        _syncStudyMeta,
        syncStudy.isAcceptableOrUnknown(data['sync_study']!, _syncStudyMeta),
      );
    }
    if (data.containsKey('sync_fitness')) {
      context.handle(
        _syncFitnessMeta,
        syncFitness.isAcceptableOrUnknown(
          data['sync_fitness']!,
          _syncFitnessMeta,
        ),
      );
    }
    if (data.containsKey('sync_journal')) {
      context.handle(
        _syncJournalMeta,
        syncJournal.isAcceptableOrUnknown(
          data['sync_journal']!,
          _syncJournalMeta,
        ),
      );
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
        _lastSyncAtMeta,
        lastSyncAt.isAcceptableOrUnknown(
          data['last_sync_at']!,
          _lastSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  SyncSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncSetting(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      syncPrayer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_prayer'],
      )!,
      syncStudy: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_study'],
      )!,
      syncFitness: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_fitness'],
      )!,
      syncJournal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_journal'],
      )!,
      lastSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncSettingsTable createAlias(String alias) {
    return $SyncSettingsTable(attachedDatabase, alias);
  }
}

class SyncSetting extends DataClass implements Insertable<SyncSetting> {
  final String profileId;
  final bool enabled;
  final bool syncPrayer;
  final bool syncStudy;
  final bool syncFitness;
  final bool syncJournal;
  final DateTime? lastSyncAt;
  final String? lastError;
  const SyncSetting({
    required this.profileId,
    required this.enabled,
    required this.syncPrayer,
    required this.syncStudy,
    required this.syncFitness,
    required this.syncJournal,
    this.lastSyncAt,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['enabled'] = Variable<bool>(enabled);
    map['sync_prayer'] = Variable<bool>(syncPrayer);
    map['sync_study'] = Variable<bool>(syncStudy);
    map['sync_fitness'] = Variable<bool>(syncFitness);
    map['sync_journal'] = Variable<bool>(syncJournal);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncSettingsCompanion toCompanion(bool nullToAbsent) {
    return SyncSettingsCompanion(
      profileId: Value(profileId),
      enabled: Value(enabled),
      syncPrayer: Value(syncPrayer),
      syncStudy: Value(syncStudy),
      syncFitness: Value(syncFitness),
      syncJournal: Value(syncJournal),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncSetting(
      profileId: serializer.fromJson<String>(json['profileId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      syncPrayer: serializer.fromJson<bool>(json['syncPrayer']),
      syncStudy: serializer.fromJson<bool>(json['syncStudy']),
      syncFitness: serializer.fromJson<bool>(json['syncFitness']),
      syncJournal: serializer.fromJson<bool>(json['syncJournal']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'enabled': serializer.toJson<bool>(enabled),
      'syncPrayer': serializer.toJson<bool>(syncPrayer),
      'syncStudy': serializer.toJson<bool>(syncStudy),
      'syncFitness': serializer.toJson<bool>(syncFitness),
      'syncJournal': serializer.toJson<bool>(syncJournal),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncSetting copyWith({
    String? profileId,
    bool? enabled,
    bool? syncPrayer,
    bool? syncStudy,
    bool? syncFitness,
    bool? syncJournal,
    Value<DateTime?> lastSyncAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
  }) => SyncSetting(
    profileId: profileId ?? this.profileId,
    enabled: enabled ?? this.enabled,
    syncPrayer: syncPrayer ?? this.syncPrayer,
    syncStudy: syncStudy ?? this.syncStudy,
    syncFitness: syncFitness ?? this.syncFitness,
    syncJournal: syncJournal ?? this.syncJournal,
    lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncSetting copyWithCompanion(SyncSettingsCompanion data) {
    return SyncSetting(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      syncPrayer: data.syncPrayer.present
          ? data.syncPrayer.value
          : this.syncPrayer,
      syncStudy: data.syncStudy.present ? data.syncStudy.value : this.syncStudy,
      syncFitness: data.syncFitness.present
          ? data.syncFitness.value
          : this.syncFitness,
      syncJournal: data.syncJournal.present
          ? data.syncJournal.value
          : this.syncJournal,
      lastSyncAt: data.lastSyncAt.present
          ? data.lastSyncAt.value
          : this.lastSyncAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncSetting(')
          ..write('profileId: $profileId, ')
          ..write('enabled: $enabled, ')
          ..write('syncPrayer: $syncPrayer, ')
          ..write('syncStudy: $syncStudy, ')
          ..write('syncFitness: $syncFitness, ')
          ..write('syncJournal: $syncJournal, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    enabled,
    syncPrayer,
    syncStudy,
    syncFitness,
    syncJournal,
    lastSyncAt,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncSetting &&
          other.profileId == this.profileId &&
          other.enabled == this.enabled &&
          other.syncPrayer == this.syncPrayer &&
          other.syncStudy == this.syncStudy &&
          other.syncFitness == this.syncFitness &&
          other.syncJournal == this.syncJournal &&
          other.lastSyncAt == this.lastSyncAt &&
          other.lastError == this.lastError);
}

class SyncSettingsCompanion extends UpdateCompanion<SyncSetting> {
  final Value<String> profileId;
  final Value<bool> enabled;
  final Value<bool> syncPrayer;
  final Value<bool> syncStudy;
  final Value<bool> syncFitness;
  final Value<bool> syncJournal;
  final Value<DateTime?> lastSyncAt;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncSettingsCompanion({
    this.profileId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.syncPrayer = const Value.absent(),
    this.syncStudy = const Value.absent(),
    this.syncFitness = const Value.absent(),
    this.syncJournal = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncSettingsCompanion.insert({
    required String profileId,
    this.enabled = const Value.absent(),
    this.syncPrayer = const Value.absent(),
    this.syncStudy = const Value.absent(),
    this.syncFitness = const Value.absent(),
    this.syncJournal = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId);
  static Insertable<SyncSetting> custom({
    Expression<String>? profileId,
    Expression<bool>? enabled,
    Expression<bool>? syncPrayer,
    Expression<bool>? syncStudy,
    Expression<bool>? syncFitness,
    Expression<bool>? syncJournal,
    Expression<DateTime>? lastSyncAt,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (enabled != null) 'enabled': enabled,
      if (syncPrayer != null) 'sync_prayer': syncPrayer,
      if (syncStudy != null) 'sync_study': syncStudy,
      if (syncFitness != null) 'sync_fitness': syncFitness,
      if (syncJournal != null) 'sync_journal': syncJournal,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncSettingsCompanion copyWith({
    Value<String>? profileId,
    Value<bool>? enabled,
    Value<bool>? syncPrayer,
    Value<bool>? syncStudy,
    Value<bool>? syncFitness,
    Value<bool>? syncJournal,
    Value<DateTime?>? lastSyncAt,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncSettingsCompanion(
      profileId: profileId ?? this.profileId,
      enabled: enabled ?? this.enabled,
      syncPrayer: syncPrayer ?? this.syncPrayer,
      syncStudy: syncStudy ?? this.syncStudy,
      syncFitness: syncFitness ?? this.syncFitness,
      syncJournal: syncJournal ?? this.syncJournal,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (syncPrayer.present) {
      map['sync_prayer'] = Variable<bool>(syncPrayer.value);
    }
    if (syncStudy.present) {
      map['sync_study'] = Variable<bool>(syncStudy.value);
    }
    if (syncFitness.present) {
      map['sync_fitness'] = Variable<bool>(syncFitness.value);
    }
    if (syncJournal.present) {
      map['sync_journal'] = Variable<bool>(syncJournal.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncSettingsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('enabled: $enabled, ')
          ..write('syncPrayer: $syncPrayer, ')
          ..write('syncStudy: $syncStudy, ')
          ..write('syncFitness: $syncFitness, ')
          ..write('syncJournal: $syncJournal, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncTombstonesTable extends SyncTombstones
    with TableInfo<$SyncTombstonesTable, SyncTombstone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncTombstonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
    'row_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    targetTable,
    rowId,
    profileId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_tombstones';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncTombstone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_deletedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {targetTable, rowId, profileId};
  @override
  SyncTombstone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncTombstone(
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      )!,
    );
  }

  @override
  $SyncTombstonesTable createAlias(String alias) {
    return $SyncTombstonesTable(attachedDatabase, alias);
  }
}

class SyncTombstone extends DataClass implements Insertable<SyncTombstone> {
  final String targetTable;
  final String rowId;
  final String profileId;
  final DateTime deletedAt;
  const SyncTombstone({
    required this.targetTable,
    required this.rowId,
    required this.profileId,
    required this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['target_table'] = Variable<String>(targetTable);
    map['row_id'] = Variable<String>(rowId);
    map['profile_id'] = Variable<String>(profileId);
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    return map;
  }

  SyncTombstonesCompanion toCompanion(bool nullToAbsent) {
    return SyncTombstonesCompanion(
      targetTable: Value(targetTable),
      rowId: Value(rowId),
      profileId: Value(profileId),
      deletedAt: Value(deletedAt),
    );
  }

  factory SyncTombstone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncTombstone(
      targetTable: serializer.fromJson<String>(json['targetTable']),
      rowId: serializer.fromJson<String>(json['rowId']),
      profileId: serializer.fromJson<String>(json['profileId']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'targetTable': serializer.toJson<String>(targetTable),
      'rowId': serializer.toJson<String>(rowId),
      'profileId': serializer.toJson<String>(profileId),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
    };
  }

  SyncTombstone copyWith({
    String? targetTable,
    String? rowId,
    String? profileId,
    DateTime? deletedAt,
  }) => SyncTombstone(
    targetTable: targetTable ?? this.targetTable,
    rowId: rowId ?? this.rowId,
    profileId: profileId ?? this.profileId,
    deletedAt: deletedAt ?? this.deletedAt,
  );
  SyncTombstone copyWithCompanion(SyncTombstonesCompanion data) {
    return SyncTombstone(
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncTombstone(')
          ..write('targetTable: $targetTable, ')
          ..write('rowId: $rowId, ')
          ..write('profileId: $profileId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(targetTable, rowId, profileId, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncTombstone &&
          other.targetTable == this.targetTable &&
          other.rowId == this.rowId &&
          other.profileId == this.profileId &&
          other.deletedAt == this.deletedAt);
}

class SyncTombstonesCompanion extends UpdateCompanion<SyncTombstone> {
  final Value<String> targetTable;
  final Value<String> rowId;
  final Value<String> profileId;
  final Value<DateTime> deletedAt;
  final Value<int> rowid;
  const SyncTombstonesCompanion({
    this.targetTable = const Value.absent(),
    this.rowId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncTombstonesCompanion.insert({
    required String targetTable,
    required String rowId,
    required String profileId,
    required DateTime deletedAt,
    this.rowid = const Value.absent(),
  }) : targetTable = Value(targetTable),
       rowId = Value(rowId),
       profileId = Value(profileId),
       deletedAt = Value(deletedAt);
  static Insertable<SyncTombstone> custom({
    Expression<String>? targetTable,
    Expression<String>? rowId,
    Expression<String>? profileId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (targetTable != null) 'target_table': targetTable,
      if (rowId != null) 'row_id': rowId,
      if (profileId != null) 'profile_id': profileId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncTombstonesCompanion copyWith({
    Value<String>? targetTable,
    Value<String>? rowId,
    Value<String>? profileId,
    Value<DateTime>? deletedAt,
    Value<int>? rowid,
  }) {
    return SyncTombstonesCompanion(
      targetTable: targetTable ?? this.targetTable,
      rowId: rowId ?? this.rowId,
      profileId: profileId ?? this.profileId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (rowId.present) {
      map['row_id'] = Variable<String>(rowId.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncTombstonesCompanion(')
          ..write('targetTable: $targetTable, ')
          ..write('rowId: $rowId, ')
          ..write('profileId: $profileId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [profileId, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, key};
  @override
  SyncStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateData(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }
}

class SyncStateData extends DataClass implements Insertable<SyncStateData> {
  final String profileId;
  final String key;
  final String value;
  const SyncStateData({
    required this.profileId,
    required this.key,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      profileId: Value(profileId),
      key: Value(key),
      value: Value(value),
    );
  }

  factory SyncStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateData(
      profileId: serializer.fromJson<String>(json['profileId']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncStateData copyWith({String? profileId, String? key, String? value}) =>
      SyncStateData(
        profileId: profileId ?? this.profileId,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SyncStateData copyWithCompanion(SyncStateCompanion data) {
    return SyncStateData(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateData(')
          ..write('profileId: $profileId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateData &&
          other.profileId == this.profileId &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateData> {
  final Value<String> profileId;
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncStateCompanion({
    this.profileId = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateCompanion.insert({
    required String profileId,
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       key = Value(key),
       value = Value(value);
  static Insertable<SyncStateData> custom({
    Expression<String>? profileId,
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateCompanion copyWith({
    Value<String>? profileId,
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SyncStateCompanion(
      profileId: profileId ?? this.profileId,
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('profileId: $profileId, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiMessagesTable extends AiMessages
    with TableInfo<$AiMessagesTable, AiMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    role,
    kind,
    body,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiMessagesTable createAlias(String alias) {
    return $AiMessagesTable(attachedDatabase, alias);
  }
}

class AiMessage extends DataClass implements Insertable<AiMessage> {
  final String id;
  final String profileId;
  final String role;
  final String kind;
  final String body;
  final DateTime createdAt;
  const AiMessage({
    required this.id,
    required this.profileId,
    required this.role,
    required this.kind,
    required this.body,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['role'] = Variable<String>(role);
    map['kind'] = Variable<String>(kind);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiMessagesCompanion toCompanion(bool nullToAbsent) {
    return AiMessagesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      role: Value(role),
      kind: Value(kind),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory AiMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiMessage(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      role: serializer.fromJson<String>(json['role']),
      kind: serializer.fromJson<String>(json['kind']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'role': serializer.toJson<String>(role),
      'kind': serializer.toJson<String>(kind),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiMessage copyWith({
    String? id,
    String? profileId,
    String? role,
    String? kind,
    String? body,
    DateTime? createdAt,
  }) => AiMessage(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    role: role ?? this.role,
    kind: kind ?? this.kind,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  AiMessage copyWithCompanion(AiMessagesCompanion data) {
    return AiMessage(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      role: data.role.present ? data.role.value : this.role,
      kind: data.kind.present ? data.kind.value : this.kind,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiMessage(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('role: $role, ')
          ..write('kind: $kind, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, role, kind, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiMessage &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.role == this.role &&
          other.kind == this.kind &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class AiMessagesCompanion extends UpdateCompanion<AiMessage> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> role;
  final Value<String> kind;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AiMessagesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.role = const Value.absent(),
    this.kind = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiMessagesCompanion.insert({
    required String id,
    required String profileId,
    required String role,
    required String kind,
    required String body,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       role = Value(role),
       kind = Value(kind),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<AiMessage> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? role,
    Expression<String>? kind,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (role != null) 'role': role,
      if (kind != null) 'kind': kind,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? role,
    Value<String>? kind,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AiMessagesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      role: role ?? this.role,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiMessagesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('role: $role, ')
          ..write('kind: $kind, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $NotificationPreferencesTable notificationPreferences =
      $NotificationPreferencesTable(this);
  late final $PrivacyPreferencesTable privacyPreferences =
      $PrivacyPreferencesTable(this);
  late final $PrayerSettingsTable prayerSettings = $PrayerSettingsTable(this);
  late final $PrayerRecordsTable prayerRecords = $PrayerRecordsTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $SyllabusTopicsTable syllabusTopics = $SyllabusTopicsTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $FlashcardReviewsTable flashcardReviews = $FlashcardReviewsTable(
    this,
  );
  late final $WaterLogsTable waterLogs = $WaterLogsTable(this);
  late final $FastingSessionsTable fastingSessions = $FastingSessionsTable(
    this,
  );
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $AchievementAwardsTable achievementAwards =
      $AchievementAwardsTable(this);
  late final $DailyPlansTable dailyPlans = $DailyPlansTable(this);
  late final $PlannedActivitiesTable plannedActivities =
      $PlannedActivitiesTable(this);
  late final $SyncSettingsTable syncSettings = $SyncSettingsTable(this);
  late final $SyncTombstonesTable syncTombstones = $SyncTombstonesTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
  late final $AiMessagesTable aiMessages = $AiMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    userPreferences,
    notificationPreferences,
    privacyPreferences,
    prayerSettings,
    prayerRecords,
    subjects,
    syllabusTopics,
    exams,
    studySessions,
    flashcards,
    flashcardReviews,
    waterLogs,
    fastingSessions,
    workoutSessions,
    journalEntries,
    achievementAwards,
    dailyPlans,
    plannedActivities,
    syncSettings,
    syncTombstones,
    syncState,
    aiMessages,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_preferences', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('notification_preferences', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('privacy_preferences', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('prayer_settings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('prayer_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('syllabus_topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('syllabus_topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exams', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exams', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcards', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcard_reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'flashcards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcard_reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('water_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fasting_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('achievement_awards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('daily_plans', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('planned_activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('planned_activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_settings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_state', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ai_messages', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  required String id,
  required String displayName,
  Value<String> mode,
  Value<String?> cloudUserId,
  Value<String?> recoveryQuestion,
  Value<String?> recoveryHash,
  Value<String?> recoverySalt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<String> id,
  Value<String> displayName,
  Value<String> mode,
  Value<String?> cloudUserId,
  Value<String?> recoveryQuestion,
  Value<String?> recoveryHash,
  Value<String?> recoverySalt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserPreferencesTable, List<UserPreference>>
  _userPreferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPreferences,
    aliasName: 'profiles__id__user_preferences__profile_id',
  );

  $$UserPreferencesTableProcessedTableManager get userPreferencesRefs {
    final manager = $$UserPreferencesTableTableManager(
      $_db,
      $_db.userPreferences,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $NotificationPreferencesTable,
    List<NotificationPreference>
  >
  _notificationPreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.notificationPreferences,
        aliasName: 'profiles__id__notification_preferences__profile_id',
      );

  $$NotificationPreferencesTableProcessedTableManager
  get notificationPreferencesRefs {
    final manager = $$NotificationPreferencesTableTableManager(
      $_db,
      $_db.notificationPreferences,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _notificationPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrivacyPreferencesTable, List<PrivacyPreference>>
  _privacyPreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.privacyPreferences,
        aliasName: 'profiles__id__privacy_preferences__profile_id',
      );

  $$PrivacyPreferencesTableProcessedTableManager get privacyPreferencesRefs {
    final manager = $$PrivacyPreferencesTableTableManager(
      $_db,
      $_db.privacyPreferences,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _privacyPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrayerSettingsTable, List<PrayerSetting>>
  _prayerSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.prayerSettings,
    aliasName: 'profiles__id__prayer_settings__profile_id',
  );

  $$PrayerSettingsTableProcessedTableManager get prayerSettingsRefs {
    final manager = $$PrayerSettingsTableTableManager(
      $_db,
      $_db.prayerSettings,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_prayerSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrayerRecordsTable, List<PrayerRecord>>
  _prayerRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.prayerRecords,
    aliasName: 'profiles__id__prayer_records__profile_id',
  );

  $$PrayerRecordsTableProcessedTableManager get prayerRecordsRefs {
    final manager = $$PrayerRecordsTableTableManager(
      $_db,
      $_db.prayerRecords,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_prayerRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'profiles__id__subjects__profile_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyllabusTopicsTable, List<SyllabusTopic>>
  _syllabusTopicsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syllabusTopics,
    aliasName: 'profiles__id__syllabus_topics__profile_id',
  );

  $$SyllabusTopicsTableProcessedTableManager get syllabusTopicsRefs {
    final manager = $$SyllabusTopicsTableTableManager(
      $_db,
      $_db.syllabusTopics,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syllabusTopicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamsTable, List<Exam>> _examsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.exams,
    aliasName: 'profiles__id__exams__profile_id',
  );

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager(
      $_db,
      $_db.exams,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'profiles__id__study_sessions__profile_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: 'profiles__id__flashcards__profile_id',
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardReviewsTable, List<FlashcardReview>>
  _flashcardReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardReviews,
    aliasName: 'profiles__id__flashcard_reviews__profile_id',
  );

  $$FlashcardReviewsTableProcessedTableManager get flashcardReviewsRefs {
    final manager = $$FlashcardReviewsTableTableManager(
      $_db,
      $_db.flashcardReviews,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _flashcardReviewsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WaterLogsTable, List<WaterLog>>
  _waterLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.waterLogs,
    aliasName: 'profiles__id__water_logs__profile_id',
  );

  $$WaterLogsTableProcessedTableManager get waterLogsRefs {
    final manager = $$WaterLogsTableTableManager(
      $_db,
      $_db.waterLogs,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_waterLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FastingSessionsTable, List<FastingSession>>
  _fastingSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fastingSessions,
    aliasName: 'profiles__id__fasting_sessions__profile_id',
  );

  $$FastingSessionsTableProcessedTableManager get fastingSessionsRefs {
    final manager = $$FastingSessionsTableTableManager(
      $_db,
      $_db.fastingSessions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fastingSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<WorkoutSession>>
  _workoutSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSessions,
    aliasName: 'profiles__id__workout_sessions__profile_id',
  );

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager = $$WorkoutSessionsTableTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntry>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: 'profiles__id__journal_entries__profile_id',
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AchievementAwardsTable, List<AchievementAward>>
  _achievementAwardsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.achievementAwards,
        aliasName: 'profiles__id__achievement_awards__profile_id',
      );

  $$AchievementAwardsTableProcessedTableManager get achievementAwardsRefs {
    final manager = $$AchievementAwardsTableTableManager(
      $_db,
      $_db.achievementAwards,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _achievementAwardsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyPlansTable, List<DailyPlan>>
  _dailyPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyPlans,
    aliasName: 'profiles__id__daily_plans__profile_id',
  );

  $$DailyPlansTableProcessedTableManager get dailyPlansRefs {
    final manager = $$DailyPlansTableTableManager(
      $_db,
      $_db.dailyPlans,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlannedActivitiesTable, List<PlannedActivity>>
  _plannedActivitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.plannedActivities,
        aliasName: 'profiles__id__planned_activities__profile_id',
      );

  $$PlannedActivitiesTableProcessedTableManager get plannedActivitiesRefs {
    final manager = $$PlannedActivitiesTableTableManager(
      $_db,
      $_db.plannedActivities,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _plannedActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncSettingsTable, List<SyncSetting>>
  _syncSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncSettings,
    aliasName: 'profiles__id__sync_settings__profile_id',
  );

  $$SyncSettingsTableProcessedTableManager get syncSettingsRefs {
    final manager = $$SyncSettingsTableTableManager(
      $_db,
      $_db.syncSettings,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncStateTable, List<SyncStateData>>
  _syncStateRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncState,
    aliasName: 'profiles__id__sync_state__profile_id',
  );

  $$SyncStateTableProcessedTableManager get syncStateRefs {
    final manager = $$SyncStateTableTableManager(
      $_db,
      $_db.syncState,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncStateRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiMessagesTable, List<AiMessage>>
  _aiMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiMessages,
    aliasName: 'profiles__id__ai_messages__profile_id',
  );

  $$AiMessagesTableProcessedTableManager get aiMessagesRefs {
    final manager = $$AiMessagesTableTableManager(
      $_db,
      $_db.aiMessages,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cloudUserId => $composableBuilder(
    column: $table.cloudUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryQuestion => $composableBuilder(
    column: $table.recoveryQuestion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryHash => $composableBuilder(
    column: $table.recoveryHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoverySalt => $composableBuilder(
    column: $table.recoverySalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userPreferencesRefs(
    Expression<bool> Function($$UserPreferencesTableFilterComposer f) f,
  ) {
    final $$UserPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notificationPreferencesRefs(
    Expression<bool> Function($$NotificationPreferencesTableFilterComposer f) f,
  ) {
    final $$NotificationPreferencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.notificationPreferences,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NotificationPreferencesTableFilterComposer(
                $db: $db,
                $table: $db.notificationPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> privacyPreferencesRefs(
    Expression<bool> Function($$PrivacyPreferencesTableFilterComposer f) f,
  ) {
    final $$PrivacyPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.privacyPreferences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrivacyPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.privacyPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> prayerSettingsRefs(
    Expression<bool> Function($$PrayerSettingsTableFilterComposer f) f,
  ) {
    final $$PrayerSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prayerSettings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrayerSettingsTableFilterComposer(
            $db: $db,
            $table: $db.prayerSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> prayerRecordsRefs(
    Expression<bool> Function($$PrayerRecordsTableFilterComposer f) f,
  ) {
    final $$PrayerRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prayerRecords,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrayerRecordsTableFilterComposer(
            $db: $db,
            $table: $db.prayerRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syllabusTopicsRefs(
    Expression<bool> Function($$SyllabusTopicsTableFilterComposer f) f,
  ) {
    final $$SyllabusTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syllabusTopics,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyllabusTopicsTableFilterComposer(
            $db: $db,
            $table: $db.syllabusTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examsRefs(
    Expression<bool> Function($$ExamsTableFilterComposer f) f,
  ) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableFilterComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardReviewsRefs(
    Expression<bool> Function($$FlashcardReviewsTableFilterComposer f) f,
  ) {
    final $$FlashcardReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableFilterComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waterLogsRefs(
    Expression<bool> Function($$WaterLogsTableFilterComposer f) f,
  ) {
    final $$WaterLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterLogs,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterLogsTableFilterComposer(
            $db: $db,
            $table: $db.waterLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fastingSessionsRefs(
    Expression<bool> Function($$FastingSessionsTableFilterComposer f) f,
  ) {
    final $$FastingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fastingSessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FastingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.fastingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutSessionsRefs(
    Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f,
  ) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> achievementAwardsRefs(
    Expression<bool> Function($$AchievementAwardsTableFilterComposer f) f,
  ) {
    final $$AchievementAwardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.achievementAwards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementAwardsTableFilterComposer(
            $db: $db,
            $table: $db.achievementAwards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyPlansRefs(
    Expression<bool> Function($$DailyPlansTableFilterComposer f) f,
  ) {
    final $$DailyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableFilterComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> plannedActivitiesRefs(
    Expression<bool> Function($$PlannedActivitiesTableFilterComposer f) f,
  ) {
    final $$PlannedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedActivities,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.plannedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncSettingsRefs(
    Expression<bool> Function($$SyncSettingsTableFilterComposer f) f,
  ) {
    final $$SyncSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSettings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSettingsTableFilterComposer(
            $db: $db,
            $table: $db.syncSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncStateRefs(
    Expression<bool> Function($$SyncStateTableFilterComposer f) f,
  ) {
    final $$SyncStateTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncState,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncStateTableFilterComposer(
            $db: $db,
            $table: $db.syncState,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiMessagesRefs(
    Expression<bool> Function($$AiMessagesTableFilterComposer f) f,
  ) {
    final $$AiMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiMessages,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiMessagesTableFilterComposer(
            $db: $db,
            $table: $db.aiMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cloudUserId => $composableBuilder(
    column: $table.cloudUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryQuestion => $composableBuilder(
    column: $table.recoveryQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryHash => $composableBuilder(
    column: $table.recoveryHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoverySalt => $composableBuilder(
    column: $table.recoverySalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get cloudUserId => $composableBuilder(
    column: $table.cloudUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoveryQuestion => $composableBuilder(
    column: $table.recoveryQuestion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoveryHash => $composableBuilder(
    column: $table.recoveryHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoverySalt => $composableBuilder(
    column: $table.recoverySalt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> userPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserPreferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notificationPreferencesRefs<T extends Object>(
    Expression<T> Function($$NotificationPreferencesTableAnnotationComposer a)
    f,
  ) {
    final $$NotificationPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.notificationPreferences,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NotificationPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.notificationPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> privacyPreferencesRefs<T extends Object>(
    Expression<T> Function($$PrivacyPreferencesTableAnnotationComposer a) f,
  ) {
    final $$PrivacyPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.privacyPreferences,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PrivacyPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.privacyPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> prayerSettingsRefs<T extends Object>(
    Expression<T> Function($$PrayerSettingsTableAnnotationComposer a) f,
  ) {
    final $$PrayerSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prayerSettings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrayerSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.prayerSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> prayerRecordsRefs<T extends Object>(
    Expression<T> Function($$PrayerRecordsTableAnnotationComposer a) f,
  ) {
    final $$PrayerRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prayerRecords,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrayerRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.prayerRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syllabusTopicsRefs<T extends Object>(
    Expression<T> Function($$SyllabusTopicsTableAnnotationComposer a) f,
  ) {
    final $$SyllabusTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syllabusTopics,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyllabusTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.syllabusTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
    Expression<T> Function($$ExamsTableAnnotationComposer a) f,
  ) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableAnnotationComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardReviewsRefs<T extends Object>(
    Expression<T> Function($$FlashcardReviewsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waterLogsRefs<T extends Object>(
    Expression<T> Function($$WaterLogsTableAnnotationComposer a) f,
  ) {
    final $$WaterLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterLogs,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.waterLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fastingSessionsRefs<T extends Object>(
    Expression<T> Function($$FastingSessionsTableAnnotationComposer a) f,
  ) {
    final $$FastingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fastingSessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FastingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fastingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutSessionsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> achievementAwardsRefs<T extends Object>(
    Expression<T> Function($$AchievementAwardsTableAnnotationComposer a) f,
  ) {
    final $$AchievementAwardsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.achievementAwards,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AchievementAwardsTableAnnotationComposer(
                $db: $db,
                $table: $db.achievementAwards,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> dailyPlansRefs<T extends Object>(
    Expression<T> Function($$DailyPlansTableAnnotationComposer a) f,
  ) {
    final $$DailyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> plannedActivitiesRefs<T extends Object>(
    Expression<T> Function($$PlannedActivitiesTableAnnotationComposer a) f,
  ) {
    final $$PlannedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.plannedActivities,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PlannedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.plannedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncSettingsRefs<T extends Object>(
    Expression<T> Function($$SyncSettingsTableAnnotationComposer a) f,
  ) {
    final $$SyncSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSettings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncStateRefs<T extends Object>(
    Expression<T> Function($$SyncStateTableAnnotationComposer a) f,
  ) {
    final $$SyncStateTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncState,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncStateTableAnnotationComposer(
            $db: $db,
            $table: $db.syncState,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiMessagesRefs<T extends Object>(
    Expression<T> Function($$AiMessagesTableAnnotationComposer a) f,
  ) {
    final $$AiMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiMessages,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, $$ProfilesTableReferences),
          Profile,
          PrefetchHooks Function({
            bool userPreferencesRefs,
            bool notificationPreferencesRefs,
            bool privacyPreferencesRefs,
            bool prayerSettingsRefs,
            bool prayerRecordsRefs,
            bool subjectsRefs,
            bool syllabusTopicsRefs,
            bool examsRefs,
            bool studySessionsRefs,
            bool flashcardsRefs,
            bool flashcardReviewsRefs,
            bool waterLogsRefs,
            bool fastingSessionsRefs,
            bool workoutSessionsRefs,
            bool journalEntriesRefs,
            bool achievementAwardsRefs,
            bool dailyPlansRefs,
            bool plannedActivitiesRefs,
            bool syncSettingsRefs,
            bool syncStateRefs,
            bool aiMessagesRefs,
          })
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> cloudUserId = const Value.absent(),
                Value<String?> recoveryQuestion = const Value.absent(),
                Value<String?> recoveryHash = const Value.absent(),
                Value<String?> recoverySalt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                displayName: displayName,
                mode: mode,
                cloudUserId: cloudUserId,
                recoveryQuestion: recoveryQuestion,
                recoveryHash: recoveryHash,
                recoverySalt: recoverySalt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                Value<String> mode = const Value.absent(),
                Value<String?> cloudUserId = const Value.absent(),
                Value<String?> recoveryQuestion = const Value.absent(),
                Value<String?> recoveryHash = const Value.absent(),
                Value<String?> recoverySalt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                mode: mode,
                cloudUserId: cloudUserId,
                recoveryQuestion: recoveryQuestion,
                recoveryHash: recoveryHash,
                recoverySalt: recoverySalt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, Profile>(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userPreferencesRefs = false,
                notificationPreferencesRefs = false,
                privacyPreferencesRefs = false,
                prayerSettingsRefs = false,
                prayerRecordsRefs = false,
                subjectsRefs = false,
                syllabusTopicsRefs = false,
                examsRefs = false,
                studySessionsRefs = false,
                flashcardsRefs = false,
                flashcardReviewsRefs = false,
                waterLogsRefs = false,
                fastingSessionsRefs = false,
                workoutSessionsRefs = false,
                journalEntriesRefs = false,
                achievementAwardsRefs = false,
                dailyPlansRefs = false,
                plannedActivitiesRefs = false,
                syncSettingsRefs = false,
                syncStateRefs = false,
                aiMessagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userPreferencesRefs) db.userPreferences,
                    if (notificationPreferencesRefs) db.notificationPreferences,
                    if (privacyPreferencesRefs) db.privacyPreferences,
                    if (prayerSettingsRefs) db.prayerSettings,
                    if (prayerRecordsRefs) db.prayerRecords,
                    if (subjectsRefs) db.subjects,
                    if (syllabusTopicsRefs) db.syllabusTopics,
                    if (examsRefs) db.exams,
                    if (studySessionsRefs) db.studySessions,
                    if (flashcardsRefs) db.flashcards,
                    if (flashcardReviewsRefs) db.flashcardReviews,
                    if (waterLogsRefs) db.waterLogs,
                    if (fastingSessionsRefs) db.fastingSessions,
                    if (workoutSessionsRefs) db.workoutSessions,
                    if (journalEntriesRefs) db.journalEntries,
                    if (achievementAwardsRefs) db.achievementAwards,
                    if (dailyPlansRefs) db.dailyPlans,
                    if (plannedActivitiesRefs) db.plannedActivities,
                    if (syncSettingsRefs) db.syncSettings,
                    if (syncStateRefs) db.syncState,
                    if (aiMessagesRefs) db.aiMessages,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userPreferencesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          UserPreference
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._userPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).userPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notificationPreferencesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          NotificationPreference
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._notificationPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).notificationPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (privacyPreferencesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          PrivacyPreference
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._privacyPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).privacyPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (prayerSettingsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          PrayerSetting
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._prayerSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).prayerSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (prayerRecordsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          PrayerRecord
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._prayerRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).prayerRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (subjectsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          Subject
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syllabusTopicsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          SyllabusTopic
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._syllabusTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).syllabusTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          Exam
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._examsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).examsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          StudySession
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardReviewsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          FlashcardReview
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._flashcardReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waterLogsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          WaterLog
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._waterLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).waterLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fastingSessionsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          FastingSession
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._fastingSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).fastingSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSessionsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          WorkoutSession
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._workoutSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          JournalEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (achievementAwardsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          AchievementAward
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._achievementAwardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).achievementAwardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dailyPlansRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          DailyPlan
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._dailyPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (plannedActivitiesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          PlannedActivity
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._plannedActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).plannedActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncSettingsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          SyncSetting
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._syncSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncStateRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          SyncStateData
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._syncStateRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncStateRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (aiMessagesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          AiMessage
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._aiMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, $$ProfilesTableReferences),
      Profile,
      PrefetchHooks Function({
        bool userPreferencesRefs,
        bool notificationPreferencesRefs,
        bool privacyPreferencesRefs,
        bool prayerSettingsRefs,
        bool prayerRecordsRefs,
        bool subjectsRefs,
        bool syllabusTopicsRefs,
        bool examsRefs,
        bool studySessionsRefs,
        bool flashcardsRefs,
        bool flashcardReviewsRefs,
        bool waterLogsRefs,
        bool fastingSessionsRefs,
        bool workoutSessionsRefs,
        bool journalEntriesRefs,
        bool achievementAwardsRefs,
        bool dailyPlansRefs,
        bool plannedActivitiesRefs,
        bool syncSettingsRefs,
        bool syncStateRefs,
        bool aiMessagesRefs,
      })
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String profileId,
      Value<String> themeMode,
      Value<String> languageCode,
      Value<String> fitnessLevel,
      Value<int> workoutMinutes,
      Value<int> studyGoalMinutes,
      Value<int> waterGoalMl,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> profileId,
      Value<String> themeMode,
      Value<String> languageCode,
      Value<String> fitnessLevel,
      Value<int> workoutMinutes,
      Value<int> studyGoalMinutes,
      Value<int> waterGoalMl,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserPreferencesTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference> {
  $$UserPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('user_preferences__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workoutMinutes => $composableBuilder(
    column: $table.workoutMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyGoalMinutes => $composableBuilder(
    column: $table.studyGoalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterGoalMl => $composableBuilder(
    column: $table.waterGoalMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workoutMinutes => $composableBuilder(
    column: $table.workoutMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studyGoalMinutes => $composableBuilder(
    column: $table.studyGoalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterGoalMl => $composableBuilder(
    column: $table.waterGoalMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fitnessLevel => $composableBuilder(
    column: $table.fitnessLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workoutMinutes => $composableBuilder(
    column: $table.workoutMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studyGoalMinutes => $composableBuilder(
    column: $table.studyGoalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterGoalMl => $composableBuilder(
    column: $table.waterGoalMl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (UserPreference, $$UserPreferencesTableReferences),
          UserPreference,
          PrefetchHooks Function({bool profileId})
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> fitnessLevel = const Value.absent(),
                Value<int> workoutMinutes = const Value.absent(),
                Value<int> studyGoalMinutes = const Value.absent(),
                Value<int> waterGoalMl = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                profileId: profileId,
                themeMode: themeMode,
                languageCode: languageCode,
                fitnessLevel: fitnessLevel,
                workoutMinutes: workoutMinutes,
                studyGoalMinutes: studyGoalMinutes,
                waterGoalMl: waterGoalMl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                Value<String> themeMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> fitnessLevel = const Value.absent(),
                Value<int> workoutMinutes = const Value.absent(),
                Value<int> studyGoalMinutes = const Value.absent(),
                Value<int> waterGoalMl = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                profileId: profileId,
                themeMode: themeMode,
                languageCode: languageCode,
                fitnessLevel: fitnessLevel,
                workoutMinutes: workoutMinutes,
                studyGoalMinutes: studyGoalMinutes,
                waterGoalMl: waterGoalMl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTable, UserPreference>(table),
                  $$UserPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$UserPreferencesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$UserPreferencesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (UserPreference, $$UserPreferencesTableReferences),
      UserPreference,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$NotificationPreferencesTableCreateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      required String profileId,
      Value<bool> prayer,
      Value<bool> study,
      Value<bool> workout,
      Value<bool> hydration,
      Value<bool> reflection,
      Value<int?> quietStartMinute,
      Value<int?> quietEndMinute,
      Value<int> prayerMask,
      Value<int> prayerOffsetMinutes,
      Value<int> studyMinute,
      Value<int> workoutMinute,
      Value<int> hydrationIntervalMinutes,
      Value<int> reflectionMinute,
      Value<bool> flashcards,
      Value<int> flashcardsMinute,
      Value<bool> weeklyReport,
      Value<int> weeklyReportDay,
      Value<bool> showDetails,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationPreferencesTableUpdateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      Value<String> profileId,
      Value<bool> prayer,
      Value<bool> study,
      Value<bool> workout,
      Value<bool> hydration,
      Value<bool> reflection,
      Value<int?> quietStartMinute,
      Value<int?> quietEndMinute,
      Value<int> prayerMask,
      Value<int> prayerOffsetMinutes,
      Value<int> studyMinute,
      Value<int> workoutMinute,
      Value<int> hydrationIntervalMinutes,
      Value<int> reflectionMinute,
      Value<bool> flashcards,
      Value<int> flashcardsMinute,
      Value<bool> weeklyReport,
      Value<int> weeklyReportDay,
      Value<bool> showDetails,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$NotificationPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreference
        > {
  $$NotificationPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) => db.profiles
      .createAlias('notification_preferences__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotificationPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get study => $composableBuilder(
    column: $table.study,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get workout => $composableBuilder(
    column: $table.workout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hydration => $composableBuilder(
    column: $table.hydration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quietStartMinute => $composableBuilder(
    column: $table.quietStartMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quietEndMinute => $composableBuilder(
    column: $table.quietEndMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prayerMask => $composableBuilder(
    column: $table.prayerMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prayerOffsetMinutes => $composableBuilder(
    column: $table.prayerOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyMinute => $composableBuilder(
    column: $table.studyMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workoutMinute => $composableBuilder(
    column: $table.workoutMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hydrationIntervalMinutes => $composableBuilder(
    column: $table.hydrationIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reflectionMinute => $composableBuilder(
    column: $table.reflectionMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get flashcards => $composableBuilder(
    column: $table.flashcards,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get flashcardsMinute => $composableBuilder(
    column: $table.flashcardsMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get weeklyReport => $composableBuilder(
    column: $table.weeklyReport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyReportDay => $composableBuilder(
    column: $table.weeklyReportDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showDetails => $composableBuilder(
    column: $table.showDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get study => $composableBuilder(
    column: $table.study,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get workout => $composableBuilder(
    column: $table.workout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hydration => $composableBuilder(
    column: $table.hydration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quietStartMinute => $composableBuilder(
    column: $table.quietStartMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quietEndMinute => $composableBuilder(
    column: $table.quietEndMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prayerMask => $composableBuilder(
    column: $table.prayerMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prayerOffsetMinutes => $composableBuilder(
    column: $table.prayerOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studyMinute => $composableBuilder(
    column: $table.studyMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workoutMinute => $composableBuilder(
    column: $table.workoutMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hydrationIntervalMinutes => $composableBuilder(
    column: $table.hydrationIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reflectionMinute => $composableBuilder(
    column: $table.reflectionMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get flashcards => $composableBuilder(
    column: $table.flashcards,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get flashcardsMinute => $composableBuilder(
    column: $table.flashcardsMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get weeklyReport => $composableBuilder(
    column: $table.weeklyReport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyReportDay => $composableBuilder(
    column: $table.weeklyReportDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showDetails => $composableBuilder(
    column: $table.showDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get prayer =>
      $composableBuilder(column: $table.prayer, builder: (column) => column);

  GeneratedColumn<bool> get study =>
      $composableBuilder(column: $table.study, builder: (column) => column);

  GeneratedColumn<bool> get workout =>
      $composableBuilder(column: $table.workout, builder: (column) => column);

  GeneratedColumn<bool> get hydration =>
      $composableBuilder(column: $table.hydration, builder: (column) => column);

  GeneratedColumn<bool> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quietStartMinute => $composableBuilder(
    column: $table.quietStartMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quietEndMinute => $composableBuilder(
    column: $table.quietEndMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prayerMask => $composableBuilder(
    column: $table.prayerMask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prayerOffsetMinutes => $composableBuilder(
    column: $table.prayerOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studyMinute => $composableBuilder(
    column: $table.studyMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workoutMinute => $composableBuilder(
    column: $table.workoutMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hydrationIntervalMinutes => $composableBuilder(
    column: $table.hydrationIntervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reflectionMinute => $composableBuilder(
    column: $table.reflectionMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get flashcards => $composableBuilder(
    column: $table.flashcards,
    builder: (column) => column,
  );

  GeneratedColumn<int> get flashcardsMinute => $composableBuilder(
    column: $table.flashcardsMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get weeklyReport => $composableBuilder(
    column: $table.weeklyReport,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeklyReportDay => $composableBuilder(
    column: $table.weeklyReportDay,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showDetails => $composableBuilder(
    column: $table.showDetails,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreference,
          $$NotificationPreferencesTableFilterComposer,
          $$NotificationPreferencesTableOrderingComposer,
          $$NotificationPreferencesTableAnnotationComposer,
          $$NotificationPreferencesTableCreateCompanionBuilder,
          $$NotificationPreferencesTableUpdateCompanionBuilder,
          (NotificationPreference, $$NotificationPreferencesTableReferences),
          NotificationPreference,
          PrefetchHooks Function({bool profileId})
        > {
  $$NotificationPreferencesTableTableManager(
    _$AppDatabase db,
    $NotificationPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<bool> prayer = const Value.absent(),
                Value<bool> study = const Value.absent(),
                Value<bool> workout = const Value.absent(),
                Value<bool> hydration = const Value.absent(),
                Value<bool> reflection = const Value.absent(),
                Value<int?> quietStartMinute = const Value.absent(),
                Value<int?> quietEndMinute = const Value.absent(),
                Value<int> prayerMask = const Value.absent(),
                Value<int> prayerOffsetMinutes = const Value.absent(),
                Value<int> studyMinute = const Value.absent(),
                Value<int> workoutMinute = const Value.absent(),
                Value<int> hydrationIntervalMinutes = const Value.absent(),
                Value<int> reflectionMinute = const Value.absent(),
                Value<bool> flashcards = const Value.absent(),
                Value<int> flashcardsMinute = const Value.absent(),
                Value<bool> weeklyReport = const Value.absent(),
                Value<int> weeklyReportDay = const Value.absent(),
                Value<bool> showDetails = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesCompanion(
                profileId: profileId,
                prayer: prayer,
                study: study,
                workout: workout,
                hydration: hydration,
                reflection: reflection,
                quietStartMinute: quietStartMinute,
                quietEndMinute: quietEndMinute,
                prayerMask: prayerMask,
                prayerOffsetMinutes: prayerOffsetMinutes,
                studyMinute: studyMinute,
                workoutMinute: workoutMinute,
                hydrationIntervalMinutes: hydrationIntervalMinutes,
                reflectionMinute: reflectionMinute,
                flashcards: flashcards,
                flashcardsMinute: flashcardsMinute,
                weeklyReport: weeklyReport,
                weeklyReportDay: weeklyReportDay,
                showDetails: showDetails,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                Value<bool> prayer = const Value.absent(),
                Value<bool> study = const Value.absent(),
                Value<bool> workout = const Value.absent(),
                Value<bool> hydration = const Value.absent(),
                Value<bool> reflection = const Value.absent(),
                Value<int?> quietStartMinute = const Value.absent(),
                Value<int?> quietEndMinute = const Value.absent(),
                Value<int> prayerMask = const Value.absent(),
                Value<int> prayerOffsetMinutes = const Value.absent(),
                Value<int> studyMinute = const Value.absent(),
                Value<int> workoutMinute = const Value.absent(),
                Value<int> hydrationIntervalMinutes = const Value.absent(),
                Value<int> reflectionMinute = const Value.absent(),
                Value<bool> flashcards = const Value.absent(),
                Value<int> flashcardsMinute = const Value.absent(),
                Value<bool> weeklyReport = const Value.absent(),
                Value<int> weeklyReportDay = const Value.absent(),
                Value<bool> showDetails = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesCompanion.insert(
                profileId: profileId,
                prayer: prayer,
                study: study,
                workout: workout,
                hydration: hydration,
                reflection: reflection,
                quietStartMinute: quietStartMinute,
                quietEndMinute: quietEndMinute,
                prayerMask: prayerMask,
                prayerOffsetMinutes: prayerOffsetMinutes,
                studyMinute: studyMinute,
                workoutMinute: workoutMinute,
                hydrationIntervalMinutes: hydrationIntervalMinutes,
                reflectionMinute: reflectionMinute,
                flashcards: flashcards,
                flashcardsMinute: flashcardsMinute,
                weeklyReport: weeklyReport,
                weeklyReportDay: weeklyReportDay,
                showDetails: showDetails,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $NotificationPreferencesTable,
                    NotificationPreference
                  >(table),
                  $$NotificationPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable:
                            $$NotificationPreferencesTableReferences
                                ._profileIdTable(db),
                        referencedColumn:
                            $$NotificationPreferencesTableReferences
                                ._profileIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotificationPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationPreferencesTable,
      NotificationPreference,
      $$NotificationPreferencesTableFilterComposer,
      $$NotificationPreferencesTableOrderingComposer,
      $$NotificationPreferencesTableAnnotationComposer,
      $$NotificationPreferencesTableCreateCompanionBuilder,
      $$NotificationPreferencesTableUpdateCompanionBuilder,
      (NotificationPreference, $$NotificationPreferencesTableReferences),
      NotificationPreference,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$PrivacyPreferencesTableCreateCompanionBuilder =
    PrivacyPreferencesCompanion Function({
      required String profileId,
      Value<bool> cloudSyncEnabled,
      Value<bool> aiConsent,
      Value<bool> aiShareStudy,
      Value<bool> aiShareFitness,
      Value<bool> aiSharePrayer,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PrivacyPreferencesTableUpdateCompanionBuilder =
    PrivacyPreferencesCompanion Function({
      Value<String> profileId,
      Value<bool> cloudSyncEnabled,
      Value<bool> aiConsent,
      Value<bool> aiShareStudy,
      Value<bool> aiShareFitness,
      Value<bool> aiSharePrayer,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PrivacyPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PrivacyPreferencesTable,
          PrivacyPreference
        > {
  $$PrivacyPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('privacy_preferences__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrivacyPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $PrivacyPreferencesTable> {
  $$PrivacyPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get cloudSyncEnabled => $composableBuilder(
    column: $table.cloudSyncEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiConsent => $composableBuilder(
    column: $table.aiConsent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiShareStudy => $composableBuilder(
    column: $table.aiShareStudy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiShareFitness => $composableBuilder(
    column: $table.aiShareFitness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiSharePrayer => $composableBuilder(
    column: $table.aiSharePrayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrivacyPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrivacyPreferencesTable> {
  $$PrivacyPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get cloudSyncEnabled => $composableBuilder(
    column: $table.cloudSyncEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiConsent => $composableBuilder(
    column: $table.aiConsent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiShareStudy => $composableBuilder(
    column: $table.aiShareStudy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiShareFitness => $composableBuilder(
    column: $table.aiShareFitness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiSharePrayer => $composableBuilder(
    column: $table.aiSharePrayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrivacyPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrivacyPreferencesTable> {
  $$PrivacyPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get cloudSyncEnabled => $composableBuilder(
    column: $table.cloudSyncEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aiConsent =>
      $composableBuilder(column: $table.aiConsent, builder: (column) => column);

  GeneratedColumn<bool> get aiShareStudy => $composableBuilder(
    column: $table.aiShareStudy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aiShareFitness => $composableBuilder(
    column: $table.aiShareFitness,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aiSharePrayer => $composableBuilder(
    column: $table.aiSharePrayer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrivacyPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrivacyPreferencesTable,
          PrivacyPreference,
          $$PrivacyPreferencesTableFilterComposer,
          $$PrivacyPreferencesTableOrderingComposer,
          $$PrivacyPreferencesTableAnnotationComposer,
          $$PrivacyPreferencesTableCreateCompanionBuilder,
          $$PrivacyPreferencesTableUpdateCompanionBuilder,
          (PrivacyPreference, $$PrivacyPreferencesTableReferences),
          PrivacyPreference,
          PrefetchHooks Function({bool profileId})
        > {
  $$PrivacyPreferencesTableTableManager(
    _$AppDatabase db,
    $PrivacyPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrivacyPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrivacyPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrivacyPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<bool> cloudSyncEnabled = const Value.absent(),
                Value<bool> aiConsent = const Value.absent(),
                Value<bool> aiShareStudy = const Value.absent(),
                Value<bool> aiShareFitness = const Value.absent(),
                Value<bool> aiSharePrayer = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrivacyPreferencesCompanion(
                profileId: profileId,
                cloudSyncEnabled: cloudSyncEnabled,
                aiConsent: aiConsent,
                aiShareStudy: aiShareStudy,
                aiShareFitness: aiShareFitness,
                aiSharePrayer: aiSharePrayer,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                Value<bool> cloudSyncEnabled = const Value.absent(),
                Value<bool> aiConsent = const Value.absent(),
                Value<bool> aiShareStudy = const Value.absent(),
                Value<bool> aiShareFitness = const Value.absent(),
                Value<bool> aiSharePrayer = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PrivacyPreferencesCompanion.insert(
                profileId: profileId,
                cloudSyncEnabled: cloudSyncEnabled,
                aiConsent: aiConsent,
                aiShareStudy: aiShareStudy,
                aiShareFitness: aiShareFitness,
                aiSharePrayer: aiSharePrayer,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrivacyPreferencesTable, PrivacyPreference>(
                    table,
                  ),
                  $$PrivacyPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$PrivacyPreferencesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$PrivacyPreferencesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrivacyPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrivacyPreferencesTable,
      PrivacyPreference,
      $$PrivacyPreferencesTableFilterComposer,
      $$PrivacyPreferencesTableOrderingComposer,
      $$PrivacyPreferencesTableAnnotationComposer,
      $$PrivacyPreferencesTableCreateCompanionBuilder,
      $$PrivacyPreferencesTableUpdateCompanionBuilder,
      (PrivacyPreference, $$PrivacyPreferencesTableReferences),
      PrivacyPreference,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$PrayerSettingsTableCreateCompanionBuilder =
    PrayerSettingsCompanion Function({
      required String profileId,
      Value<String> method,
      Value<String> asrMethod,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> locationLabel,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PrayerSettingsTableUpdateCompanionBuilder =
    PrayerSettingsCompanion Function({
      Value<String> profileId,
      Value<String> method,
      Value<String> asrMethod,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> locationLabel,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PrayerSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $PrayerSettingsTable, PrayerSetting> {
  $$PrayerSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('prayer_settings__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrayerSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerSettingsTable> {
  $$PrayerSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get asrMethod => $composableBuilder(
    column: $table.asrMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerSettingsTable> {
  $$PrayerSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get asrMethod => $composableBuilder(
    column: $table.asrMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerSettingsTable> {
  $$PrayerSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get asrMethod =>
      $composableBuilder(column: $table.asrMethod, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerSettingsTable,
          PrayerSetting,
          $$PrayerSettingsTableFilterComposer,
          $$PrayerSettingsTableOrderingComposer,
          $$PrayerSettingsTableAnnotationComposer,
          $$PrayerSettingsTableCreateCompanionBuilder,
          $$PrayerSettingsTableUpdateCompanionBuilder,
          (PrayerSetting, $$PrayerSettingsTableReferences),
          PrayerSetting,
          PrefetchHooks Function({bool profileId})
        > {
  $$PrayerSettingsTableTableManager(
    _$AppDatabase db,
    $PrayerSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> asrMethod = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> locationLabel = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrayerSettingsCompanion(
                profileId: profileId,
                method: method,
                asrMethod: asrMethod,
                latitude: latitude,
                longitude: longitude,
                locationLabel: locationLabel,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                Value<String> method = const Value.absent(),
                Value<String> asrMethod = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> locationLabel = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PrayerSettingsCompanion.insert(
                profileId: profileId,
                method: method,
                asrMethod: asrMethod,
                latitude: latitude,
                longitude: longitude,
                locationLabel: locationLabel,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrayerSettingsTable, PrayerSetting>(table),
                  $$PrayerSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$PrayerSettingsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$PrayerSettingsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrayerSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerSettingsTable,
      PrayerSetting,
      $$PrayerSettingsTableFilterComposer,
      $$PrayerSettingsTableOrderingComposer,
      $$PrayerSettingsTableAnnotationComposer,
      $$PrayerSettingsTableCreateCompanionBuilder,
      $$PrayerSettingsTableUpdateCompanionBuilder,
      (PrayerSetting, $$PrayerSettingsTableReferences),
      PrayerSetting,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$PrayerRecordsTableCreateCompanionBuilder =
    PrayerRecordsCompanion Function({
      required String id,
      required String profileId,
      required String day,
      required String prayer,
      required String status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PrayerRecordsTableUpdateCompanionBuilder =
    PrayerRecordsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> day,
      Value<String> prayer,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PrayerRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $PrayerRecordsTable, PrayerRecord> {
  $$PrayerRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('prayer_records__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrayerRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerRecordsTable> {
  $$PrayerRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerRecordsTable> {
  $$PrayerRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerRecordsTable> {
  $$PrayerRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get prayer =>
      $composableBuilder(column: $table.prayer, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrayerRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerRecordsTable,
          PrayerRecord,
          $$PrayerRecordsTableFilterComposer,
          $$PrayerRecordsTableOrderingComposer,
          $$PrayerRecordsTableAnnotationComposer,
          $$PrayerRecordsTableCreateCompanionBuilder,
          $$PrayerRecordsTableUpdateCompanionBuilder,
          (PrayerRecord, $$PrayerRecordsTableReferences),
          PrayerRecord,
          PrefetchHooks Function({bool profileId})
        > {
  $$PrayerRecordsTableTableManager(_$AppDatabase db, $PrayerRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<String> prayer = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrayerRecordsCompanion(
                id: id,
                profileId: profileId,
                day: day,
                prayer: prayer,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String day,
                required String prayer,
                required String status,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PrayerRecordsCompanion.insert(
                id: id,
                profileId: profileId,
                day: day,
                prayer: prayer,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrayerRecordsTable, PrayerRecord>(table),
                  $$PrayerRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$PrayerRecordsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$PrayerRecordsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrayerRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerRecordsTable,
      PrayerRecord,
      $$PrayerRecordsTableFilterComposer,
      $$PrayerRecordsTableOrderingComposer,
      $$PrayerRecordsTableAnnotationComposer,
      $$PrayerRecordsTableCreateCompanionBuilder,
      $$PrayerRecordsTableUpdateCompanionBuilder,
      (PrayerRecord, $$PrayerRecordsTableReferences),
      PrayerRecord,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  required String id,
  required String profileId,
  required String name,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('subjects__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SyllabusTopicsTable, List<SyllabusTopic>>
  _syllabusTopicsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syllabusTopics,
    aliasName: 'subjects__id__syllabus_topics__subject_id',
  );

  $$SyllabusTopicsTableProcessedTableManager get syllabusTopicsRefs {
    final manager = $$SyllabusTopicsTableTableManager(
      $_db,
      $_db.syllabusTopics,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syllabusTopicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamsTable, List<Exam>> _examsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.exams,
    aliasName: 'subjects__id__exams__subject_id',
  );

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager(
      $_db,
      $_db.exams,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'subjects__id__study_sessions__subject_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: 'subjects__id__flashcards__subject_id',
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> syllabusTopicsRefs(
    Expression<bool> Function($$SyllabusTopicsTableFilterComposer f) f,
  ) {
    final $$SyllabusTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syllabusTopics,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyllabusTopicsTableFilterComposer(
            $db: $db,
            $table: $db.syllabusTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examsRefs(
    Expression<bool> Function($$ExamsTableFilterComposer f) f,
  ) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableFilterComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> syllabusTopicsRefs<T extends Object>(
    Expression<T> Function($$SyllabusTopicsTableAnnotationComposer a) f,
  ) {
    final $$SyllabusTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syllabusTopics,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyllabusTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.syllabusTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
    Expression<T> Function($$ExamsTableAnnotationComposer a) f,
  ) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableAnnotationComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({
            bool profileId,
            bool syllabusTopicsRefs,
            bool examsRefs,
            bool studySessionsRefs,
            bool flashcardsRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                profileId: profileId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubjectsTable, Subject>(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                syllabusTopicsRefs = false,
                examsRefs = false,
                studySessionsRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (syllabusTopicsRefs) db.syllabusTopics,
                    if (examsRefs) db.exams,
                    if (studySessionsRefs) db.studySessions,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.profileId,
                            referencedTable: $$SubjectsTableReferences
                                ._profileIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._profileIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (syllabusTopicsRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          SyllabusTopic
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._syllabusTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).syllabusTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examsRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          Exam
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._examsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).examsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          StudySession
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({
        bool profileId,
        bool syllabusTopicsRefs,
        bool examsRefs,
        bool studySessionsRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$SyllabusTopicsTableCreateCompanionBuilder =
    SyllabusTopicsCompanion Function({
      required String id,
      required String profileId,
      required String subjectId,
      required String title,
      Value<String?> description,
      Value<int> priority,
      Value<int?> estimateMinutes,
      Value<String> status,
      Value<DateTime?> dueDate,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SyllabusTopicsTableUpdateCompanionBuilder =
    SyllabusTopicsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> subjectId,
      Value<String> title,
      Value<String?> description,
      Value<int> priority,
      Value<int?> estimateMinutes,
      Value<String> status,
      Value<DateTime?> dueDate,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SyllabusTopicsTableReferences
    extends BaseReferences<_$AppDatabase, $SyllabusTopicsTable, SyllabusTopic> {
  $$SyllabusTopicsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('syllabus_topics__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('syllabus_topics__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyllabusTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $SyllabusTopicsTable> {
  $$SyllabusTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyllabusTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyllabusTopicsTable> {
  $$SyllabusTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyllabusTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyllabusTopicsTable> {
  $$SyllabusTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyllabusTopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyllabusTopicsTable,
          SyllabusTopic,
          $$SyllabusTopicsTableFilterComposer,
          $$SyllabusTopicsTableOrderingComposer,
          $$SyllabusTopicsTableAnnotationComposer,
          $$SyllabusTopicsTableCreateCompanionBuilder,
          $$SyllabusTopicsTableUpdateCompanionBuilder,
          (SyllabusTopic, $$SyllabusTopicsTableReferences),
          SyllabusTopic,
          PrefetchHooks Function({bool profileId, bool subjectId})
        > {
  $$SyllabusTopicsTableTableManager(
    _$AppDatabase db,
    $SyllabusTopicsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyllabusTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyllabusTopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyllabusTopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int?> estimateMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyllabusTopicsCompanion(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                title: title,
                description: description,
                priority: priority,
                estimateMinutes: estimateMinutes,
                status: status,
                dueDate: dueDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String subjectId,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int?> estimateMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyllabusTopicsCompanion.insert(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                title: title,
                description: description,
                priority: priority,
                estimateMinutes: estimateMinutes,
                status: status,
                dueDate: dueDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyllabusTopicsTable, SyllabusTopic>(table),
                  $$SyllabusTopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$SyllabusTopicsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$SyllabusTopicsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$SyllabusTopicsTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$SyllabusTopicsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyllabusTopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyllabusTopicsTable,
      SyllabusTopic,
      $$SyllabusTopicsTableFilterComposer,
      $$SyllabusTopicsTableOrderingComposer,
      $$SyllabusTopicsTableAnnotationComposer,
      $$SyllabusTopicsTableCreateCompanionBuilder,
      $$SyllabusTopicsTableUpdateCompanionBuilder,
      (SyllabusTopic, $$SyllabusTopicsTableReferences),
      SyllabusTopic,
      PrefetchHooks Function({bool profileId, bool subjectId})
    >;
typedef $$ExamsTableCreateCompanionBuilder = ExamsCompanion Function({
  required String id,
  required String profileId,
  Value<String?> subjectId,
  required String name,
  required DateTime examAt,
  Value<int> priority,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ExamsTableUpdateCompanionBuilder = ExamsCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<String?> subjectId,
  Value<String> name,
  Value<DateTime> examAt,
  Value<int> priority,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ExamsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamsTable, Exam> {
  $$ExamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('exams__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('exams__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<String>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExamsTableFilterComposer extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get examAt => $composableBuilder(
    column: $table.examAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get examAt => $composableBuilder(
    column: $table.examAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get examAt =>
      $composableBuilder(column: $table.examAt, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamsTable,
          Exam,
          $$ExamsTableFilterComposer,
          $$ExamsTableOrderingComposer,
          $$ExamsTableAnnotationComposer,
          $$ExamsTableCreateCompanionBuilder,
          $$ExamsTableUpdateCompanionBuilder,
          (Exam, $$ExamsTableReferences),
          Exam,
          PrefetchHooks Function({bool profileId, bool subjectId})
        > {
  $$ExamsTableTableManager(_$AppDatabase db, $ExamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> examAt = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                name: name,
                examAt: examAt,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> subjectId = const Value.absent(),
                required String name,
                required DateTime examAt,
                Value<int> priority = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion.insert(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                name: name,
                examAt: examAt,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamsTable, Exam>(table),
                  $$ExamsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$ExamsTableReferences._profileIdTable(
                          db,
                        ),
                        referencedColumn: $$ExamsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$ExamsTableReferences._subjectIdTable(
                          db,
                        ),
                        referencedColumn: $$ExamsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamsTable,
      Exam,
      $$ExamsTableFilterComposer,
      $$ExamsTableOrderingComposer,
      $$ExamsTableAnnotationComposer,
      $$ExamsTableCreateCompanionBuilder,
      $$ExamsTableUpdateCompanionBuilder,
      (Exam, $$ExamsTableReferences),
      Exam,
      PrefetchHooks Function({bool profileId, bool subjectId})
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      required String profileId,
      Value<String?> subjectId,
      required String kind,
      required int plannedSeconds,
      required DateTime startedAt,
      Value<DateTime?> pausedAt,
      Value<int> accumulatedPausedMs,
      Value<DateTime?> endedAt,
      Value<bool> cancelled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String?> subjectId,
      Value<String> kind,
      Value<int> plannedSeconds,
      Value<DateTime> startedAt,
      Value<DateTime?> pausedAt,
      Value<int> accumulatedPausedMs,
      Value<DateTime?> endedAt,
      Value<bool> cancelled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$StudySessionsTableReferences
    extends BaseReferences<_$AppDatabase, $StudySessionsTable, StudySession> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('study_sessions__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('study_sessions__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<String>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accumulatedPausedMs => $composableBuilder(
    column: $table.accumulatedPausedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accumulatedPausedMs => $composableBuilder(
    column: $table.accumulatedPausedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get pausedAt =>
      $composableBuilder(column: $table.pausedAt, builder: (column) => column);

  GeneratedColumn<int> get accumulatedPausedMs => $composableBuilder(
    column: $table.accumulatedPausedMs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<bool> get cancelled =>
      $composableBuilder(column: $table.cancelled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySession,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySession, $$StudySessionsTableReferences),
          StudySession,
          PrefetchHooks Function({bool profileId, bool subjectId})
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> plannedSeconds = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> pausedAt = const Value.absent(),
                Value<int> accumulatedPausedMs = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                kind: kind,
                plannedSeconds: plannedSeconds,
                startedAt: startedAt,
                pausedAt: pausedAt,
                accumulatedPausedMs: accumulatedPausedMs,
                endedAt: endedAt,
                cancelled: cancelled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> subjectId = const Value.absent(),
                required String kind,
                required int plannedSeconds,
                required DateTime startedAt,
                Value<DateTime?> pausedAt = const Value.absent(),
                Value<int> accumulatedPausedMs = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                kind: kind,
                plannedSeconds: plannedSeconds,
                startedAt: startedAt,
                pausedAt: pausedAt,
                accumulatedPausedMs: accumulatedPausedMs,
                endedAt: endedAt,
                cancelled: cancelled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionsTable, StudySession>(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$StudySessionsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$StudySessionsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$StudySessionsTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$StudySessionsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySession,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySession, $$StudySessionsTableReferences),
      StudySession,
      PrefetchHooks Function({bool profileId, bool subjectId})
    >;
typedef $$FlashcardsTableCreateCompanionBuilder = FlashcardsCompanion Function({
  required String id,
  required String profileId,
  Value<String?> subjectId,
  required String front,
  required String back,
  Value<String?> tags,
  Value<double> ease,
  Value<int> intervalDays,
  Value<int> repetitions,
  required DateTime dueAt,
  Value<bool> archived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$FlashcardsTableUpdateCompanionBuilder = FlashcardsCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<String?> subjectId,
  Value<String> front,
  Value<String> back,
  Value<String?> tags,
  Value<double> ease,
  Value<int> intervalDays,
  Value<int> repetitions,
  Value<DateTime> dueAt,
  Value<bool> archived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$FlashcardsTableReferences
    extends BaseReferences<_$AppDatabase, $FlashcardsTable, Flashcard> {
  $$FlashcardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('flashcards__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('flashcards__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<String>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlashcardReviewsTable, List<FlashcardReview>>
  _flashcardReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardReviews,
    aliasName: 'flashcards__id__flashcard_reviews__card_id',
  );

  $$FlashcardReviewsTableProcessedTableManager get flashcardReviewsRefs {
    final manager = $$FlashcardReviewsTableTableManager(
      $_db,
      $_db.flashcardReviews,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _flashcardReviewsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlashcardsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ease => $composableBuilder(
    column: $table.ease,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardReviewsRefs(
    Expression<bool> Function($$FlashcardReviewsTableFilterComposer f) f,
  ) {
    final $$FlashcardReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableFilterComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ease => $composableBuilder(
    column: $table.ease,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get front =>
      $composableBuilder(column: $table.front, builder: (column) => column);

  GeneratedColumn<String> get back =>
      $composableBuilder(column: $table.back, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<double> get ease =>
      $composableBuilder(column: $table.ease, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardReviewsRefs<T extends Object>(
    Expression<T> Function($$FlashcardReviewsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardsTable,
          Flashcard,
          $$FlashcardsTableFilterComposer,
          $$FlashcardsTableOrderingComposer,
          $$FlashcardsTableAnnotationComposer,
          $$FlashcardsTableCreateCompanionBuilder,
          $$FlashcardsTableUpdateCompanionBuilder,
          (Flashcard, $$FlashcardsTableReferences),
          Flashcard,
          PrefetchHooks Function({
            bool profileId,
            bool subjectId,
            bool flashcardReviewsRefs,
          })
        > {
  $$FlashcardsTableTableManager(_$AppDatabase db, $FlashcardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashcardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashcardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashcardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> subjectId = const Value.absent(),
                Value<String> front = const Value.absent(),
                Value<String> back = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<double> ease = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                front: front,
                back: back,
                tags: tags,
                ease: ease,
                intervalDays: intervalDays,
                repetitions: repetitions,
                dueAt: dueAt,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> subjectId = const Value.absent(),
                required String front,
                required String back,
                Value<String?> tags = const Value.absent(),
                Value<double> ease = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                required DateTime dueAt,
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion.insert(
                id: id,
                profileId: profileId,
                subjectId: subjectId,
                front: front,
                back: back,
                tags: tags,
                ease: ease,
                intervalDays: intervalDays,
                repetitions: repetitions,
                dueAt: dueAt,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FlashcardsTable, Flashcard>(table),
                  $$FlashcardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                subjectId = false,
                flashcardReviewsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (flashcardReviewsRefs) db.flashcardReviews,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.profileId,
                            referencedTable: $$FlashcardsTableReferences
                                ._profileIdTable(db),
                            referencedColumn: $$FlashcardsTableReferences
                                ._profileIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$FlashcardsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$FlashcardsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (flashcardReviewsRefs)
                        await $_getPrefetchedData<
                          Flashcard,
                          $FlashcardsTable,
                          FlashcardReview
                        >(
                          currentTable: table,
                          referencedTable: $$FlashcardsTableReferences
                              ._flashcardReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FlashcardsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FlashcardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardsTable,
      Flashcard,
      $$FlashcardsTableFilterComposer,
      $$FlashcardsTableOrderingComposer,
      $$FlashcardsTableAnnotationComposer,
      $$FlashcardsTableCreateCompanionBuilder,
      $$FlashcardsTableUpdateCompanionBuilder,
      (Flashcard, $$FlashcardsTableReferences),
      Flashcard,
      PrefetchHooks Function({
        bool profileId,
        bool subjectId,
        bool flashcardReviewsRefs,
      })
    >;
typedef $$FlashcardReviewsTableCreateCompanionBuilder =
    FlashcardReviewsCompanion Function({
      required String id,
      required String profileId,
      required String cardId,
      required String rating,
      required DateTime reviewedAt,
      required int intervalAfterDays,
      required double easeAfter,
      Value<int> rowid,
    });
typedef $$FlashcardReviewsTableUpdateCompanionBuilder =
    FlashcardReviewsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> cardId,
      Value<String> rating,
      Value<DateTime> reviewedAt,
      Value<int> intervalAfterDays,
      Value<double> easeAfter,
      Value<int> rowid,
    });

final class $$FlashcardReviewsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FlashcardReviewsTable, FlashcardReview> {
  $$FlashcardReviewsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('flashcard_reviews__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FlashcardsTable _cardIdTable(_$AppDatabase db) =>
      db.flashcards.createAlias('flashcard_reviews__card_id__flashcards__id');

  $$FlashcardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlashcardReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalAfterDays => $composableBuilder(
    column: $table.intervalAfterDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeAfter => $composableBuilder(
    column: $table.easeAfter,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableFilterComposer get cardId {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalAfterDays => $composableBuilder(
    column: $table.intervalAfterDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeAfter => $composableBuilder(
    column: $table.easeAfter,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableOrderingComposer get cardId {
    final $$FlashcardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableOrderingComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalAfterDays => $composableBuilder(
    column: $table.intervalAfterDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeAfter =>
      $composableBuilder(column: $table.easeAfter, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FlashcardsTableAnnotationComposer get cardId {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardReviewsTable,
          FlashcardReview,
          $$FlashcardReviewsTableFilterComposer,
          $$FlashcardReviewsTableOrderingComposer,
          $$FlashcardReviewsTableAnnotationComposer,
          $$FlashcardReviewsTableCreateCompanionBuilder,
          $$FlashcardReviewsTableUpdateCompanionBuilder,
          (FlashcardReview, $$FlashcardReviewsTableReferences),
          FlashcardReview,
          PrefetchHooks Function({bool profileId, bool cardId})
        > {
  $$FlashcardReviewsTableTableManager(
    _$AppDatabase db,
    $FlashcardReviewsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashcardReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashcardReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashcardReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> rating = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
                Value<int> intervalAfterDays = const Value.absent(),
                Value<double> easeAfter = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardReviewsCompanion(
                id: id,
                profileId: profileId,
                cardId: cardId,
                rating: rating,
                reviewedAt: reviewedAt,
                intervalAfterDays: intervalAfterDays,
                easeAfter: easeAfter,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String cardId,
                required String rating,
                required DateTime reviewedAt,
                required int intervalAfterDays,
                required double easeAfter,
                Value<int> rowid = const Value.absent(),
              }) => FlashcardReviewsCompanion.insert(
                id: id,
                profileId: profileId,
                cardId: cardId,
                rating: rating,
                reviewedAt: reviewedAt,
                intervalAfterDays: intervalAfterDays,
                easeAfter: easeAfter,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FlashcardReviewsTable, FlashcardReview>(table),
                  $$FlashcardReviewsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$FlashcardReviewsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$FlashcardReviewsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$FlashcardReviewsTableReferences
                            ._cardIdTable(db),
                        referencedColumn: $$FlashcardReviewsTableReferences
                            ._cardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FlashcardReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardReviewsTable,
      FlashcardReview,
      $$FlashcardReviewsTableFilterComposer,
      $$FlashcardReviewsTableOrderingComposer,
      $$FlashcardReviewsTableAnnotationComposer,
      $$FlashcardReviewsTableCreateCompanionBuilder,
      $$FlashcardReviewsTableUpdateCompanionBuilder,
      (FlashcardReview, $$FlashcardReviewsTableReferences),
      FlashcardReview,
      PrefetchHooks Function({bool profileId, bool cardId})
    >;
typedef $$WaterLogsTableCreateCompanionBuilder = WaterLogsCompanion Function({
  required String id,
  required String profileId,
  required int amountMl,
  required DateTime loggedAt,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$WaterLogsTableUpdateCompanionBuilder = WaterLogsCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<int> amountMl,
  Value<DateTime> loggedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$WaterLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WaterLogsTable, WaterLog> {
  $$WaterLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('water_logs__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaterLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WaterLogsTable> {
  $$WaterLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterLogsTable> {
  $$WaterLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterLogsTable> {
  $$WaterLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountMl =>
      $composableBuilder(column: $table.amountMl, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterLogsTable,
          WaterLog,
          $$WaterLogsTableFilterComposer,
          $$WaterLogsTableOrderingComposer,
          $$WaterLogsTableAnnotationComposer,
          $$WaterLogsTableCreateCompanionBuilder,
          $$WaterLogsTableUpdateCompanionBuilder,
          (WaterLog, $$WaterLogsTableReferences),
          WaterLog,
          PrefetchHooks Function({bool profileId})
        > {
  $$WaterLogsTableTableManager(_$AppDatabase db, $WaterLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<int> amountMl = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WaterLogsCompanion(
                id: id,
                profileId: profileId,
                amountMl: amountMl,
                loggedAt: loggedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required int amountMl,
                required DateTime loggedAt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => WaterLogsCompanion.insert(
                id: id,
                profileId: profileId,
                amountMl: amountMl,
                loggedAt: loggedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WaterLogsTable, WaterLog>(table),
                  $$WaterLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$WaterLogsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$WaterLogsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaterLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterLogsTable,
      WaterLog,
      $$WaterLogsTableFilterComposer,
      $$WaterLogsTableOrderingComposer,
      $$WaterLogsTableAnnotationComposer,
      $$WaterLogsTableCreateCompanionBuilder,
      $$WaterLogsTableUpdateCompanionBuilder,
      (WaterLog, $$WaterLogsTableReferences),
      WaterLog,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$FastingSessionsTableCreateCompanionBuilder =
    FastingSessionsCompanion Function({
      required String id,
      required String profileId,
      required DateTime startedAt,
      Value<int?> plannedSeconds,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FastingSessionsTableUpdateCompanionBuilder =
    FastingSessionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<DateTime> startedAt,
      Value<int?> plannedSeconds,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FastingSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FastingSessionsTable, FastingSession> {
  $$FastingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('fasting_sessions__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FastingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FastingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FastingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FastingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FastingSessionsTable,
          FastingSession,
          $$FastingSessionsTableFilterComposer,
          $$FastingSessionsTableOrderingComposer,
          $$FastingSessionsTableAnnotationComposer,
          $$FastingSessionsTableCreateCompanionBuilder,
          $$FastingSessionsTableUpdateCompanionBuilder,
          (FastingSession, $$FastingSessionsTableReferences),
          FastingSession,
          PrefetchHooks Function({bool profileId})
        > {
  $$FastingSessionsTableTableManager(
    _$AppDatabase db,
    $FastingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FastingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FastingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FastingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<int?> plannedSeconds = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FastingSessionsCompanion(
                id: id,
                profileId: profileId,
                startedAt: startedAt,
                plannedSeconds: plannedSeconds,
                endedAt: endedAt,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required DateTime startedAt,
                Value<int?> plannedSeconds = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FastingSessionsCompanion.insert(
                id: id,
                profileId: profileId,
                startedAt: startedAt,
                plannedSeconds: plannedSeconds,
                endedAt: endedAt,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FastingSessionsTable, FastingSession>(table),
                  $$FastingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$FastingSessionsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$FastingSessionsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FastingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FastingSessionsTable,
      FastingSession,
      $$FastingSessionsTableFilterComposer,
      $$FastingSessionsTableOrderingComposer,
      $$FastingSessionsTableAnnotationComposer,
      $$FastingSessionsTableCreateCompanionBuilder,
      $$FastingSessionsTableUpdateCompanionBuilder,
      (FastingSession, $$FastingSessionsTableReferences),
      FastingSession,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      required String id,
      required String profileId,
      required String workoutKey,
      required String workoutName,
      required DateTime startedAt,
      required DateTime endedAt,
      required int exercisesCompleted,
      required int exercisesTotal,
      Value<String?> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> workoutKey,
      Value<String> workoutName,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<int> exercisesCompleted,
      Value<int> exercisesTotal,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WorkoutSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession> {
  $$WorkoutSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('workout_sessions__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutKey => $composableBuilder(
    column: $table.workoutKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutName => $composableBuilder(
    column: $table.workoutName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exercisesTotal => $composableBuilder(
    column: $table.exercisesTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutKey => $composableBuilder(
    column: $table.workoutKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutName => $composableBuilder(
    column: $table.workoutName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exercisesTotal => $composableBuilder(
    column: $table.exercisesTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutKey => $composableBuilder(
    column: $table.workoutKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workoutName => $composableBuilder(
    column: $table.workoutName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exercisesTotal => $composableBuilder(
    column: $table.exercisesTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (WorkoutSession, $$WorkoutSessionsTableReferences),
          WorkoutSession,
          PrefetchHooks Function({bool profileId})
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> workoutKey = const Value.absent(),
                Value<String> workoutName = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> exercisesCompleted = const Value.absent(),
                Value<int> exercisesTotal = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                profileId: profileId,
                workoutKey: workoutKey,
                workoutName: workoutName,
                startedAt: startedAt,
                endedAt: endedAt,
                exercisesCompleted: exercisesCompleted,
                exercisesTotal: exercisesTotal,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String workoutKey,
                required String workoutName,
                required DateTime startedAt,
                required DateTime endedAt,
                required int exercisesCompleted,
                required int exercisesTotal,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                profileId: profileId,
                workoutKey: workoutKey,
                workoutName: workoutName,
                startedAt: startedAt,
                endedAt: endedAt,
                exercisesCompleted: exercisesCompleted,
                exercisesTotal: exercisesTotal,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutSessionsTable, WorkoutSession>(table),
                  $$WorkoutSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$WorkoutSessionsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$WorkoutSessionsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (WorkoutSession, $$WorkoutSessionsTableReferences),
      WorkoutSession,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      required String id,
      required String profileId,
      required String day,
      Value<String> wentWell,
      Value<String> learned,
      Value<String> improve,
      Value<String> grateful,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> day,
      Value<String> wentWell,
      Value<String> learned,
      Value<String> improve,
      Value<String> grateful,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$JournalEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('journal_entries__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWell => $composableBuilder(
    column: $table.wentWell,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get learned => $composableBuilder(
    column: $table.learned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get improve => $composableBuilder(
    column: $table.improve,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grateful => $composableBuilder(
    column: $table.grateful,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWell => $composableBuilder(
    column: $table.wentWell,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get learned => $composableBuilder(
    column: $table.learned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get improve => $composableBuilder(
    column: $table.improve,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grateful => $composableBuilder(
    column: $table.grateful,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get wentWell =>
      $composableBuilder(column: $table.wentWell, builder: (column) => column);

  GeneratedColumn<String> get learned =>
      $composableBuilder(column: $table.learned, builder: (column) => column);

  GeneratedColumn<String> get improve =>
      $composableBuilder(column: $table.improve, builder: (column) => column);

  GeneratedColumn<String> get grateful =>
      $composableBuilder(column: $table.grateful, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntry, $$JournalEntriesTableReferences),
          JournalEntry,
          PrefetchHooks Function({bool profileId})
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<String> wentWell = const Value.absent(),
                Value<String> learned = const Value.absent(),
                Value<String> improve = const Value.absent(),
                Value<String> grateful = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                profileId: profileId,
                day: day,
                wentWell: wentWell,
                learned: learned,
                improve: improve,
                grateful: grateful,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String day,
                Value<String> wentWell = const Value.absent(),
                Value<String> learned = const Value.absent(),
                Value<String> improve = const Value.absent(),
                Value<String> grateful = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                profileId: profileId,
                day: day,
                wentWell: wentWell,
                learned: learned,
                improve: improve,
                grateful: grateful,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JournalEntriesTable, JournalEntry>(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$JournalEntriesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$JournalEntriesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntry, $$JournalEntriesTableReferences),
      JournalEntry,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$AchievementAwardsTableCreateCompanionBuilder =
    AchievementAwardsCompanion Function({
      required String id,
      required String profileId,
      required String achievementId,
      required DateTime awardedAt,
      Value<int> rowid,
    });
typedef $$AchievementAwardsTableUpdateCompanionBuilder =
    AchievementAwardsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> achievementId,
      Value<DateTime> awardedAt,
      Value<int> rowid,
    });

final class $$AchievementAwardsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AchievementAwardsTable,
          AchievementAward
        > {
  $$AchievementAwardsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('achievement_awards__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AchievementAwardsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementAwardsTable> {
  $$AchievementAwardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get awardedAt => $composableBuilder(
    column: $table.awardedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AchievementAwardsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementAwardsTable> {
  $$AchievementAwardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get awardedAt => $composableBuilder(
    column: $table.awardedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AchievementAwardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementAwardsTable> {
  $$AchievementAwardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get awardedAt =>
      $composableBuilder(column: $table.awardedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AchievementAwardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementAwardsTable,
          AchievementAward,
          $$AchievementAwardsTableFilterComposer,
          $$AchievementAwardsTableOrderingComposer,
          $$AchievementAwardsTableAnnotationComposer,
          $$AchievementAwardsTableCreateCompanionBuilder,
          $$AchievementAwardsTableUpdateCompanionBuilder,
          (AchievementAward, $$AchievementAwardsTableReferences),
          AchievementAward,
          PrefetchHooks Function({bool profileId})
        > {
  $$AchievementAwardsTableTableManager(
    _$AppDatabase db,
    $AchievementAwardsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementAwardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementAwardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementAwardsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> achievementId = const Value.absent(),
                Value<DateTime> awardedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementAwardsCompanion(
                id: id,
                profileId: profileId,
                achievementId: achievementId,
                awardedAt: awardedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String achievementId,
                required DateTime awardedAt,
                Value<int> rowid = const Value.absent(),
              }) => AchievementAwardsCompanion.insert(
                id: id,
                profileId: profileId,
                achievementId: achievementId,
                awardedAt: awardedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementAwardsTable, AchievementAward>(table),
                  $$AchievementAwardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$AchievementAwardsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$AchievementAwardsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AchievementAwardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementAwardsTable,
      AchievementAward,
      $$AchievementAwardsTableFilterComposer,
      $$AchievementAwardsTableOrderingComposer,
      $$AchievementAwardsTableAnnotationComposer,
      $$AchievementAwardsTableCreateCompanionBuilder,
      $$AchievementAwardsTableUpdateCompanionBuilder,
      (AchievementAward, $$AchievementAwardsTableReferences),
      AchievementAward,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$DailyPlansTableCreateCompanionBuilder = DailyPlansCompanion Function({
  required String id,
  required String profileId,
  required String day,
  required DateTime generatedAt,
  Value<int> rowid,
});
typedef $$DailyPlansTableUpdateCompanionBuilder = DailyPlansCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<String> day,
  Value<DateTime> generatedAt,
  Value<int> rowid,
});

final class $$DailyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $DailyPlansTable, DailyPlan> {
  $$DailyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('daily_plans__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlannedActivitiesTable, List<PlannedActivity>>
  _plannedActivitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.plannedActivities,
        aliasName: 'daily_plans__id__planned_activities__plan_id',
      );

  $$PlannedActivitiesTableProcessedTableManager get plannedActivitiesRefs {
    final manager = $$PlannedActivitiesTableTableManager(
      $_db,
      $_db.plannedActivities,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _plannedActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DailyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> plannedActivitiesRefs(
    Expression<bool> Function($$PlannedActivitiesTableFilterComposer f) f,
  ) {
    final $$PlannedActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannedActivities,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannedActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.plannedActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> plannedActivitiesRefs<T extends Object>(
    Expression<T> Function($$PlannedActivitiesTableAnnotationComposer a) f,
  ) {
    final $$PlannedActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.plannedActivities,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PlannedActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.plannedActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DailyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyPlansTable,
          DailyPlan,
          $$DailyPlansTableFilterComposer,
          $$DailyPlansTableOrderingComposer,
          $$DailyPlansTableAnnotationComposer,
          $$DailyPlansTableCreateCompanionBuilder,
          $$DailyPlansTableUpdateCompanionBuilder,
          (DailyPlan, $$DailyPlansTableReferences),
          DailyPlan,
          PrefetchHooks Function({bool profileId, bool plannedActivitiesRefs})
        > {
  $$DailyPlansTableTableManager(_$AppDatabase db, $DailyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansCompanion(
                id: id,
                profileId: profileId,
                day: day,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String day,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansCompanion.insert(
                id: id,
                profileId: profileId,
                day: day,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyPlansTable, DailyPlan>(table),
                  $$DailyPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({profileId = false, plannedActivitiesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (plannedActivitiesRefs) db.plannedActivities,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.profileId,
                            referencedTable: $$DailyPlansTableReferences
                                ._profileIdTable(db),
                            referencedColumn: $$DailyPlansTableReferences
                                ._profileIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (plannedActivitiesRefs)
                        await $_getPrefetchedData<
                          DailyPlan,
                          $DailyPlansTable,
                          PlannedActivity
                        >(
                          currentTable: table,
                          referencedTable: $$DailyPlansTableReferences
                              ._plannedActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).plannedActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DailyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyPlansTable,
      DailyPlan,
      $$DailyPlansTableFilterComposer,
      $$DailyPlansTableOrderingComposer,
      $$DailyPlansTableAnnotationComposer,
      $$DailyPlansTableCreateCompanionBuilder,
      $$DailyPlansTableUpdateCompanionBuilder,
      (DailyPlan, $$DailyPlansTableReferences),
      DailyPlan,
      PrefetchHooks Function({bool profileId, bool plannedActivitiesRefs})
    >;
typedef $$PlannedActivitiesTableCreateCompanionBuilder =
    PlannedActivitiesCompanion Function({
      required String id,
      required String profileId,
      required String planId,
      required String kind,
      required String title,
      required DateTime startAt,
      required DateTime endAt,
      Value<String> status,
      Value<bool> pinned,
      Value<String?> reason,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PlannedActivitiesTableUpdateCompanionBuilder =
    PlannedActivitiesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> planId,
      Value<String> kind,
      Value<String> title,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<String> status,
      Value<bool> pinned,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PlannedActivitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PlannedActivitiesTable,
          PlannedActivity
        > {
  $$PlannedActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('planned_activities__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DailyPlansTable _planIdTable(_$AppDatabase db) =>
      db.dailyPlans.createAlias('planned_activities__plan_id__daily_plans__id');

  $$DailyPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$DailyPlansTableTableManager(
      $_db,
      $_db.dailyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlannedActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PlannedActivitiesTable> {
  $$PlannedActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DailyPlansTableFilterComposer get planId {
    final $$DailyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableFilterComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannedActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlannedActivitiesTable> {
  $$PlannedActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DailyPlansTableOrderingComposer get planId {
    final $$DailyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannedActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlannedActivitiesTable> {
  $$PlannedActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DailyPlansTableAnnotationComposer get planId {
    final $$DailyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannedActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlannedActivitiesTable,
          PlannedActivity,
          $$PlannedActivitiesTableFilterComposer,
          $$PlannedActivitiesTableOrderingComposer,
          $$PlannedActivitiesTableAnnotationComposer,
          $$PlannedActivitiesTableCreateCompanionBuilder,
          $$PlannedActivitiesTableUpdateCompanionBuilder,
          (PlannedActivity, $$PlannedActivitiesTableReferences),
          PlannedActivity,
          PrefetchHooks Function({bool profileId, bool planId})
        > {
  $$PlannedActivitiesTableTableManager(
    _$AppDatabase db,
    $PlannedActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannedActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannedActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannedActivitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannedActivitiesCompanion(
                id: id,
                profileId: profileId,
                planId: planId,
                kind: kind,
                title: title,
                startAt: startAt,
                endAt: endAt,
                status: status,
                pinned: pinned,
                reason: reason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String planId,
                required String kind,
                required String title,
                required DateTime startAt,
                required DateTime endAt,
                Value<String> status = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PlannedActivitiesCompanion.insert(
                id: id,
                profileId: profileId,
                planId: planId,
                kind: kind,
                title: title,
                startAt: startAt,
                endAt: endAt,
                status: status,
                pinned: pinned,
                reason: reason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlannedActivitiesTable, PlannedActivity>(table),
                  $$PlannedActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$PlannedActivitiesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$PlannedActivitiesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (planId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.planId,
                        referencedTable: $$PlannedActivitiesTableReferences
                            ._planIdTable(db),
                        referencedColumn: $$PlannedActivitiesTableReferences
                            ._planIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlannedActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlannedActivitiesTable,
      PlannedActivity,
      $$PlannedActivitiesTableFilterComposer,
      $$PlannedActivitiesTableOrderingComposer,
      $$PlannedActivitiesTableAnnotationComposer,
      $$PlannedActivitiesTableCreateCompanionBuilder,
      $$PlannedActivitiesTableUpdateCompanionBuilder,
      (PlannedActivity, $$PlannedActivitiesTableReferences),
      PlannedActivity,
      PrefetchHooks Function({bool profileId, bool planId})
    >;
typedef $$SyncSettingsTableCreateCompanionBuilder =
    SyncSettingsCompanion Function({
      required String profileId,
      Value<bool> enabled,
      Value<bool> syncPrayer,
      Value<bool> syncStudy,
      Value<bool> syncFitness,
      Value<bool> syncJournal,
      Value<DateTime?> lastSyncAt,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SyncSettingsTableUpdateCompanionBuilder =
    SyncSettingsCompanion Function({
      Value<String> profileId,
      Value<bool> enabled,
      Value<bool> syncPrayer,
      Value<bool> syncStudy,
      Value<bool> syncFitness,
      Value<bool> syncJournal,
      Value<DateTime?> lastSyncAt,
      Value<String?> lastError,
      Value<int> rowid,
    });

final class $$SyncSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $SyncSettingsTable, SyncSetting> {
  $$SyncSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('sync_settings__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncPrayer => $composableBuilder(
    column: $table.syncPrayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncStudy => $composableBuilder(
    column: $table.syncStudy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncFitness => $composableBuilder(
    column: $table.syncFitness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncJournal => $composableBuilder(
    column: $table.syncJournal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncPrayer => $composableBuilder(
    column: $table.syncPrayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncStudy => $composableBuilder(
    column: $table.syncStudy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncFitness => $composableBuilder(
    column: $table.syncFitness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncJournal => $composableBuilder(
    column: $table.syncJournal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<bool> get syncPrayer => $composableBuilder(
    column: $table.syncPrayer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get syncStudy =>
      $composableBuilder(column: $table.syncStudy, builder: (column) => column);

  GeneratedColumn<bool> get syncFitness => $composableBuilder(
    column: $table.syncFitness,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get syncJournal => $composableBuilder(
    column: $table.syncJournal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncSettingsTable,
          SyncSetting,
          $$SyncSettingsTableFilterComposer,
          $$SyncSettingsTableOrderingComposer,
          $$SyncSettingsTableAnnotationComposer,
          $$SyncSettingsTableCreateCompanionBuilder,
          $$SyncSettingsTableUpdateCompanionBuilder,
          (SyncSetting, $$SyncSettingsTableReferences),
          SyncSetting,
          PrefetchHooks Function({bool profileId})
        > {
  $$SyncSettingsTableTableManager(_$AppDatabase db, $SyncSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> syncPrayer = const Value.absent(),
                Value<bool> syncStudy = const Value.absent(),
                Value<bool> syncFitness = const Value.absent(),
                Value<bool> syncJournal = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncSettingsCompanion(
                profileId: profileId,
                enabled: enabled,
                syncPrayer: syncPrayer,
                syncStudy: syncStudy,
                syncFitness: syncFitness,
                syncJournal: syncJournal,
                lastSyncAt: lastSyncAt,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                Value<bool> enabled = const Value.absent(),
                Value<bool> syncPrayer = const Value.absent(),
                Value<bool> syncStudy = const Value.absent(),
                Value<bool> syncFitness = const Value.absent(),
                Value<bool> syncJournal = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncSettingsCompanion.insert(
                profileId: profileId,
                enabled: enabled,
                syncPrayer: syncPrayer,
                syncStudy: syncStudy,
                syncFitness: syncFitness,
                syncJournal: syncJournal,
                lastSyncAt: lastSyncAt,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncSettingsTable, SyncSetting>(table),
                  $$SyncSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$SyncSettingsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$SyncSettingsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncSettingsTable,
      SyncSetting,
      $$SyncSettingsTableFilterComposer,
      $$SyncSettingsTableOrderingComposer,
      $$SyncSettingsTableAnnotationComposer,
      $$SyncSettingsTableCreateCompanionBuilder,
      $$SyncSettingsTableUpdateCompanionBuilder,
      (SyncSetting, $$SyncSettingsTableReferences),
      SyncSetting,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$SyncTombstonesTableCreateCompanionBuilder =
    SyncTombstonesCompanion Function({
      required String targetTable,
      required String rowId,
      required String profileId,
      required DateTime deletedAt,
      Value<int> rowid,
    });
typedef $$SyncTombstonesTableUpdateCompanionBuilder =
    SyncTombstonesCompanion Function({
      Value<String> targetTable,
      Value<String> rowId,
      Value<String> profileId,
      Value<DateTime> deletedAt,
      Value<int> rowid,
    });

class $$SyncTombstonesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncTombstonesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncTombstonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$SyncTombstonesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncTombstonesTable,
          SyncTombstone,
          $$SyncTombstonesTableFilterComposer,
          $$SyncTombstonesTableOrderingComposer,
          $$SyncTombstonesTableAnnotationComposer,
          $$SyncTombstonesTableCreateCompanionBuilder,
          $$SyncTombstonesTableUpdateCompanionBuilder,
          (
            SyncTombstone,
            BaseReferences<_$AppDatabase, $SyncTombstonesTable, SyncTombstone>,
          ),
          SyncTombstone,
          PrefetchHooks Function()
        > {
  $$SyncTombstonesTableTableManager(
    _$AppDatabase db,
    $SyncTombstonesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncTombstonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncTombstonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncTombstonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> targetTable = const Value.absent(),
                Value<String> rowId = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<DateTime> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncTombstonesCompanion(
                targetTable: targetTable,
                rowId: rowId,
                profileId: profileId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String targetTable,
                required String rowId,
                required String profileId,
                required DateTime deletedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncTombstonesCompanion.insert(
                targetTable: targetTable,
                rowId: rowId,
                profileId: profileId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncTombstonesTable, SyncTombstone>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncTombstonesTable,
                    SyncTombstone
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncTombstonesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncTombstonesTable,
      SyncTombstone,
      $$SyncTombstonesTableFilterComposer,
      $$SyncTombstonesTableOrderingComposer,
      $$SyncTombstonesTableAnnotationComposer,
      $$SyncTombstonesTableCreateCompanionBuilder,
      $$SyncTombstonesTableUpdateCompanionBuilder,
      (
        SyncTombstone,
        BaseReferences<_$AppDatabase, $SyncTombstonesTable, SyncTombstone>,
      ),
      SyncTombstone,
      PrefetchHooks Function()
    >;
typedef $$SyncStateTableCreateCompanionBuilder = SyncStateCompanion Function({
  required String profileId,
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SyncStateTableUpdateCompanionBuilder = SyncStateCompanion Function({
  Value<String> profileId,
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

final class $$SyncStateTableReferences
    extends BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateData> {
  $$SyncStateTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('sync_state__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTable,
          SyncStateData,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (SyncStateData, $$SyncStateTableReferences),
          SyncStateData,
          PrefetchHooks Function({bool profileId})
        > {
  $$SyncStateTableTableManager(_$AppDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion(
                profileId: profileId,
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion.insert(
                profileId: profileId,
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncStateTable, SyncStateData>(table),
                  $$SyncStateTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$SyncStateTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$SyncStateTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTable,
      SyncStateData,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (SyncStateData, $$SyncStateTableReferences),
      SyncStateData,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$AiMessagesTableCreateCompanionBuilder = AiMessagesCompanion Function({
  required String id,
  required String profileId,
  required String role,
  required String kind,
  required String body,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AiMessagesTableUpdateCompanionBuilder = AiMessagesCompanion Function({
  Value<String> id,
  Value<String> profileId,
  Value<String> role,
  Value<String> kind,
  Value<String> body,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$AiMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $AiMessagesTable, AiMessage> {
  $$AiMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('ai_messages__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiMessagesTable> {
  $$AiMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiMessagesTable,
          AiMessage,
          $$AiMessagesTableFilterComposer,
          $$AiMessagesTableOrderingComposer,
          $$AiMessagesTableAnnotationComposer,
          $$AiMessagesTableCreateCompanionBuilder,
          $$AiMessagesTableUpdateCompanionBuilder,
          (AiMessage, $$AiMessagesTableReferences),
          AiMessage,
          PrefetchHooks Function({bool profileId})
        > {
  $$AiMessagesTableTableManager(_$AppDatabase db, $AiMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiMessagesCompanion(
                id: id,
                profileId: profileId,
                role: role,
                kind: kind,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String role,
                required String kind,
                required String body,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AiMessagesCompanion.insert(
                id: id,
                profileId: profileId,
                role: role,
                kind: kind,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AiMessagesTable, AiMessage>(table),
                  $$AiMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$AiMessagesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$AiMessagesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AiMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiMessagesTable,
      AiMessage,
      $$AiMessagesTableFilterComposer,
      $$AiMessagesTableOrderingComposer,
      $$AiMessagesTableAnnotationComposer,
      $$AiMessagesTableCreateCompanionBuilder,
      $$AiMessagesTableUpdateCompanionBuilder,
      (AiMessage, $$AiMessagesTableReferences),
      AiMessage,
      PrefetchHooks Function({bool profileId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$NotificationPreferencesTableTableManager get notificationPreferences =>
      $$NotificationPreferencesTableTableManager(
        _db,
        _db.notificationPreferences,
      );
  $$PrivacyPreferencesTableTableManager get privacyPreferences =>
      $$PrivacyPreferencesTableTableManager(_db, _db.privacyPreferences);
  $$PrayerSettingsTableTableManager get prayerSettings =>
      $$PrayerSettingsTableTableManager(_db, _db.prayerSettings);
  $$PrayerRecordsTableTableManager get prayerRecords =>
      $$PrayerRecordsTableTableManager(_db, _db.prayerRecords);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$SyllabusTopicsTableTableManager get syllabusTopics =>
      $$SyllabusTopicsTableTableManager(_db, _db.syllabusTopics);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db, _db.flashcards);
  $$FlashcardReviewsTableTableManager get flashcardReviews =>
      $$FlashcardReviewsTableTableManager(_db, _db.flashcardReviews);
  $$WaterLogsTableTableManager get waterLogs =>
      $$WaterLogsTableTableManager(_db, _db.waterLogs);
  $$FastingSessionsTableTableManager get fastingSessions =>
      $$FastingSessionsTableTableManager(_db, _db.fastingSessions);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$AchievementAwardsTableTableManager get achievementAwards =>
      $$AchievementAwardsTableTableManager(_db, _db.achievementAwards);
  $$DailyPlansTableTableManager get dailyPlans =>
      $$DailyPlansTableTableManager(_db, _db.dailyPlans);
  $$PlannedActivitiesTableTableManager get plannedActivities =>
      $$PlannedActivitiesTableTableManager(_db, _db.plannedActivities);
  $$SyncSettingsTableTableManager get syncSettings =>
      $$SyncSettingsTableTableManager(_db, _db.syncSettings);
  $$SyncTombstonesTableTableManager get syncTombstones =>
      $$SyncTombstonesTableTableManager(_db, _db.syncTombstones);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
  $$AiMessagesTableTableManager get aiMessages =>
      $$AiMessagesTableTableManager(_db, _db.aiMessages);
}
