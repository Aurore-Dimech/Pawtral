String readString(Map<String, dynamic> json, String key) {
  return json[key] as String? ?? '';
}

class Animal {
  final String name;
  final Taxonomy taxonomy;
  final List<String> locations;
  final Characteristics characteristics;

  Animal({
    required this.name,
    required this.taxonomy,
    required this.locations,
    required this.characteristics,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'] as String? ?? '',
      taxonomy: Taxonomy.fromJson(
        json['taxonomy'] as Map<String, dynamic>? ?? {},
      ),
      locations: List<String>.from(json['locations'] as List? ?? const []),
      characteristics: Characteristics.fromJson(
        json['characteristics'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class Taxonomy {
  final String kingdom;
  final String phylum;
  final String animalClass;
  final String order;
  final String family;
  final String genus;
  final String scientificName;

  Taxonomy({
    required this.kingdom,
    required this.phylum,
    required this.animalClass,
    required this.order,
    required this.family,
    required this.genus,
    required this.scientificName,
  });

  factory Taxonomy.fromJson(Map<String, dynamic> json) {
    return Taxonomy(
      kingdom: readString(json, 'kingdom'),
      phylum: readString(json, 'phylum'),
      animalClass: readString(json, 'class'),
      order: readString(json, 'order'),
      family: readString(json, 'family'),
      genus: readString(json, 'genus'),
      scientificName: readString(json, 'scientific_name'),
    );
  }
}

class Characteristics {
  final String prey;
  final String nameOfYoung;
  final String groupBehavior;
  final String estimatedPopulationSize;
  final String biggestThreat;
  final String mostDistinctiveFeature;
  final String gestationPeriod;
  final String habitat;
  final String diet;
  final String averageLitterSize;
  final String lifestyle;
  final String commonName;
  final String numberOfSpecies;
  final String location;
  final String slogan;
  final String group;
  final String color;
  final String skinType;
  final String topSpeed;
  final String lifespan;
  final String weight;
  final String height;
  final String ageOfSexualMaturity;
  final String ageOfWeaning;

  Characteristics({
    required this.prey,
    required this.nameOfYoung,
    required this.groupBehavior,
    required this.estimatedPopulationSize,
    required this.biggestThreat,
    required this.mostDistinctiveFeature,
    required this.gestationPeriod,
    required this.habitat,
    required this.diet,
    required this.averageLitterSize,
    required this.lifestyle,
    required this.commonName,
    required this.numberOfSpecies,
    required this.location,
    required this.slogan,
    required this.group,
    required this.color,
    required this.skinType,
    required this.topSpeed,
    required this.lifespan,
    required this.weight,
    required this.height,
    required this.ageOfSexualMaturity,
    required this.ageOfWeaning,
  });

  factory Characteristics.fromJson(Map<String, dynamic> json) {
    return Characteristics(
      prey: readString(json, 'prey'),
      nameOfYoung: readString(json, 'name_of_young'),
      groupBehavior: readString(json, 'group_behavior'),
      estimatedPopulationSize: readString(json, 'estimated_population_size'),
      biggestThreat: readString(json, 'biggest_threat'),
      mostDistinctiveFeature: readString(json, 'most_distinctive_feature'),
      gestationPeriod: readString(json, 'gestation_period'),
      habitat: readString(json, 'habitat'),
      diet: readString(json, 'diet'),
      averageLitterSize: readString(json, 'average_litter_size'),
      lifestyle: readString(json, 'lifestyle'),
      commonName: readString(json, 'common_name'),
      numberOfSpecies: readString(json, 'number_of_species'),
      location: readString(json, 'location'),
      slogan: readString(json, 'slogan'),
      group: readString(json, 'group'),
      color: readString(json, 'color'),
      skinType: readString(json, 'skin_type'),
      topSpeed: readString(json, 'top_speed'),
      lifespan: readString(json, 'lifespan'),
      weight: readString(json, 'weight'),
      height: readString(json, 'height'),
      ageOfSexualMaturity: readString(json, 'age_of_sexual_maturity'),
      ageOfWeaning: readString(json, 'age_of_weaning'),
    );
  }
}
