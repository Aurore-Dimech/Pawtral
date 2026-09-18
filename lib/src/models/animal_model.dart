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
      name: json['name'] as String,
      taxonomy: Taxonomy.fromJson(json['taxonomy'] as Map<String, dynamic>),
      locations: List<String>.from(json['locations'] as List<dynamic>),
      characteristics: Characteristics.fromJson(
        json['characteristics'] as Map<String, dynamic>,
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
      kingdom: json['kingdom'] as String,
      phylum: json['phylum'] as String,
      animalClass: json['class'] as String,
      order: json['order'] as String,
      family: json['family'] as String,
      genus: json['genus'] as String,
      scientificName: json['scientific_name'] as String,
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
      prey: json['prey'] as String,
      nameOfYoung: json['name_of_young'] as String,
      groupBehavior: json['group_behavior'] as String,
      estimatedPopulationSize: json['estimated_population_size'] as String,
      biggestThreat: json['biggest_threat'] as String,
      mostDistinctiveFeature: json['most_distinctive_feature'] as String,
      gestationPeriod: json['gestation_period'] as String,
      habitat: json['habitat'] as String,
      diet: json['diet'] as String,
      averageLitterSize: json['average_litter_size'] as String,
      lifestyle: json['lifestyle'] as String,
      commonName: json['common_name'] as String,
      numberOfSpecies: json['number_of_species'] as String,
      location: json['location'] as String,
      slogan: json['slogan'] as String,
      group: json['group'] as String,
      color: json['color'] as String,
      skinType: json['skin_type'] as String,
      topSpeed: json['top_speed'] as String,
      lifespan: json['lifespan'] as String,
      weight: json['weight'] as String,
      height: json['height'] as String,
      ageOfSexualMaturity: json['age_of_sexual_maturity'] as String,
      ageOfWeaning: json['age_of_weaning'] as String,
    );
  }
}