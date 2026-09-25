import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/models/animal_model.dart';

import 'package:pawtrol/src/providers/animal_provider.dart';
import 'package:pawtrol/src/controllers/observation_controller.dart';
import 'package:pawtrol/src/services/observation_workflow_service.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

class AnimalView extends ConsumerWidget {
  final String animalName;
  final ObservationDraft? draft;

  const AnimalView({super.key, required this.animalName, this.draft});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalProvider(animalName));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: animalAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Unable to load $animalName.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textColor),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(animalProvider(animalName)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (animal) => _AnimalContent(
          animalName: animalName,
          animal: animal,
          draft: draft,
        ),
      ),
    );
  }
}

class _AnimalContent extends ConsumerWidget {
  final String animalName;
  final Animal animal;
  final ObservationDraft? draft;

  const _AnimalContent({
    required this.animalName,
    required this.animal,
    this.draft,
  });

  Future<void> _saveAnimal(BuildContext context, WidgetRef ref) async {
    final draft = this.draft;
    if (draft == null) {
      return;
    }

    final saved = await ref
        .read(observationControllerProvider.notifier)
        .save(draft);

    if (!context.mounted) {
      return;
    }

    if (saved) {
      context.go('/animals');
      return;
    }

    final error = ref.read(observationControllerProvider).error;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Unable to save animal: $error')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(observationControllerProvider);
    final isSaving = saveState.when(
      loading: () => true,
      error: (_, _) => false,
      data: (_) => false,
    );
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        _AnimalHeroImage(animalName: animalName),

        Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenHeight * 0.55),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          animalName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        if (animal.taxonomy.scientificName.isNotEmpty ||
                            animal.characteristics.commonName.isNotEmpty)
                          Text(
                            "${animal.taxonomy.scientificName} ${animal.taxonomy.scientificName.isNotEmpty && animal.characteristics.commonName.isNotEmpty ? ' - ' : ''} ${animal.characteristics.commonName}",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                        if (animal.characteristics.slogan.isNotEmpty) ...[
                          _divider(indent: 24, height: 60),

                          Text(
                            animal.characteristics.slogan,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ],
                    ),

                    _divider(indent: 24, height: 60),

                    Row(
                      children: [
                        _infoBox("Diet: ", animal.characteristics.diet),
                        SizedBox(width: 12),
                        _infoBox("Habitat: ", animal.characteristics.habitat),
                        SizedBox(width: 12),
                        _infoBox(
                          "Population: ",
                          animal.characteristics.estimatedPopulationSize,
                        ),
                        SizedBox(width: 12),
                      ],
                    ),

                    _divider(),

                    _infoLine("Prey: ", animal.characteristics.prey),
                    _infoLine(
                      "Biggest threat: ",
                      animal.characteristics.biggestThreat,
                    ),

                    _divider(),

                    Row(
                      children: [
                        _infoBox("Height: ", animal.characteristics.height),
                        SizedBox(width: 12),
                        _infoBox("Weight: ", animal.characteristics.weight),
                        SizedBox(width: 12),
                        _infoBox("Lifespan: ", animal.characteristics.lifespan),
                        SizedBox(width: 12),
                      ],
                    ),

                    _divider(),

                    _infoLine("Top speed: ", animal.characteristics.topSpeed),

                    _divider(),

                    _infoLine(
                      "Name of young: ",
                      animal.characteristics.nameOfYoung,
                    ),
                    _infoLine(
                      "Average litter size: ",
                      animal.characteristics.averageLitterSize,
                    ),
                    _infoLine(
                      "Gestation period: ",
                      animal.characteristics.gestationPeriod,
                    ),
                    _infoLine(
                      "Age of weaning: ",
                      animal.characteristics.ageOfWeaning,
                    ),
                    _infoLine(
                      "Age of sexual maturity: ",
                      animal.characteristics.ageOfSexualMaturity,
                    ),

                    _divider(),

                    _infoLine(
                      "Most distinctive feature: ",
                      animal.characteristics.mostDistinctiveFeature,
                    ),
                    _infoLine("Skin type: ", animal.characteristics.skinType),
                    _infoLine("Color: ", animal.characteristics.color),

                    _divider(),

                    _infoLine(
                      "Group behavior: ",
                      animal.characteristics.groupBehavior,
                    ),

                    _infoLine("Lifestyle: ", animal.characteristics.lifestyle),

                    _divider(),

                    _infoLine("Kingdom: ", animal.taxonomy.kingdom),
                    _infoLine("Phylum: ", animal.taxonomy.phylum),
                    _infoLine("Animal class: ", animal.taxonomy.animalClass),
                    _infoLine("Order: ", animal.taxonomy.order),
                    _infoLine("Family: ", animal.taxonomy.family),
                    _infoLine("Genus: ", animal.taxonomy.genus),
                    _infoLine("Group: ", animal.characteristics.group),
                    _infoLine(
                      "Number of species: ",
                      animal.characteristics.numberOfSpecies,
                    ),

                    const SizedBox(height: 24),
                    if (draft != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isSaving
                              ? null
                              : () => _saveAnimal(context, ref),
                          icon: isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.bookmark_add_rounded),
                          label: Text(isSaving ? 'Saving...' : 'Save animal'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    return AppColors.backgroundColor;
                  }),
                  padding: WidgetStateProperty.resolveWith((states) {
                    return EdgeInsetsGeometry.only(right: 2);
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimalHeroImage extends ConsumerStatefulWidget {
  final String animalName;

  const _AnimalHeroImage({required this.animalName});

  @override
  ConsumerState<_AnimalHeroImage> createState() => _AnimalHeroImageState();
}

class _AnimalHeroImageState extends ConsumerState<_AnimalHeroImage> {
  String? _imageUrl;
  bool _requested = false;

  @override
  void initState() {
    super.initState();
    _requestImage();
  }

  Future<void> _requestImage() async {
    if (_requested) {
      return;
    }

    _requested = true;
    final animalService = await ref.read(animalServiceProvider.future);
    final imageUrl = await animalService.fetchRandomImage(widget.animalName);

    if (mounted && imageUrl != null) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageUrl == null) {
      return _buildFallback();
    }

    return Image.network(
      _imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: AppColors.secondaryColor.withValues(alpha: 0.15),
      child: const Center(
        child: Icon(
          Icons.pets_rounded,
          size: 64,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}

Widget _infoBox(String label, String characteristic) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: Text(
              characteristic.isNotEmpty ? characteristic : "unknow",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _infoLine(String label, String characteristic) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
      SizedBox(width: 16),
      Expanded(
        child: Text(
          characteristic.isNotEmpty ? characteristic : "unknow",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

Widget _divider({double? indent, double? height}) {
  return Divider(
    thickness: 1,
    height: height ?? 40,
    indent: indent ?? 80,
    endIndent: indent ?? 80,
    color: Colors.black12,
  );
}
