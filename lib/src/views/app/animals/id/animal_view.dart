import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/models/animal_model.dart';

import 'package:pawtrol/src/providers/animal_provider.dart';
import 'package:pawtrol/src/providers/local_observation_provider.dart';
import 'package:pawtrol/src/providers/observation_workflow_provider.dart';
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

class _AnimalContent extends ConsumerStatefulWidget {
  final String animalName;
  final Animal animal;
  final ObservationDraft? draft;

  const _AnimalContent({
    required this.animalName,
    required this.animal,
    this.draft,
  });

  @override
  ConsumerState<_AnimalContent> createState() => _AnimalContentState();
}

class _AnimalContentState extends ConsumerState<_AnimalContent> {
  bool _isSaving = false;

  Future<void> _saveAnimal() async {
    final user = FirebaseAuth.instance.currentUser;
    final draft = widget.draft;

    if (user == null || draft == null) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      final workflow = await ref.read(observationWorkflowProvider.future);
      await workflow.saveDraft(draft: draft, userId: user.uid);
      ref.invalidate(localObservationsProvider(user.uid));

      if (mounted) {
        context.go('/animals');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to save animal: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        _AnimalHeroImage(animalName: widget.animalName),

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
                          widget.animalName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        if (widget.animal.taxonomy.scientificName.isNotEmpty ||
                            widget.animal.characteristics.commonName.isNotEmpty)
                          Text(
                            "${widget.animal.taxonomy.scientificName} ${widget.animal.taxonomy.scientificName.isNotEmpty && widget.animal.characteristics.commonName.isNotEmpty ? ' - ' : ''} ${widget.animal.characteristics.commonName}",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                        if (widget.animal.characteristics.slogan.isNotEmpty) ... [
                          _divider(indent: 24, height: 60),

                          Text(
                            widget.animal.characteristics.slogan,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ]
                        
                      ],
                    ),

                    _divider(indent: 24, height: 60),

                    Row(
                      children: [
                        _infoBox("Diet: ", widget.animal.characteristics.diet),
                        SizedBox(width: 12),
                        _infoBox(
                          "Habitat: ",
                          widget.animal.characteristics.habitat,
                        ),
                        SizedBox(width: 12),
                        _infoBox(
                          "Population: ",
                          widget.animal.characteristics.estimatedPopulationSize,
                        ),
                        SizedBox(width: 12),
                      ],
                    ),

                    _divider(),

                    _infoLine("Prey: ", widget.animal.characteristics.prey),
                    _infoLine(
                      "Biggest threat: ",
                      widget.animal.characteristics.biggestThreat,
                    ),

                    _divider(),

                    Row(
                      children: [
                        _infoBox(
                          "Height: ",
                          widget.animal.characteristics.height,
                        ),
                        SizedBox(width: 12),
                        _infoBox(
                          "Weight: ",
                          widget.animal.characteristics.weight,
                        ),
                        SizedBox(width: 12),
                        _infoBox(
                          "Lifespan: ",
                          widget.animal.characteristics.lifespan,
                        ),
                        SizedBox(width: 12),
                      ],
                    ),

                    _divider(),

                    _infoLine(
                      "Top speed: ",
                      widget.animal.characteristics.topSpeed,
                    ),

                    _divider(),

                    _infoLine(
                      "Name of young: ",
                      widget.animal.characteristics.nameOfYoung,
                    ),
                    _infoLine(
                      "Average litter size: ",
                      widget.animal.characteristics.averageLitterSize,
                    ),
                    _infoLine(
                      "Gestation period: ",
                      widget.animal.characteristics.gestationPeriod,
                    ),
                    _infoLine(
                      "Age of weaning: ",
                      widget.animal.characteristics.ageOfWeaning,
                    ),
                    _infoLine(
                      "Age of sexual maturity: ",
                      widget.animal.characteristics.ageOfSexualMaturity,
                    ),

                    _divider(),

                    _infoLine(
                      "Most distinctive feature: ",
                      widget.animal.characteristics.mostDistinctiveFeature,
                    ),
                    _infoLine(
                      "Skin type: ",
                      widget.animal.characteristics.skinType,
                    ),
                    _infoLine("Color: ", widget.animal.characteristics.color),

                    _divider(),

                    _infoLine(
                      "Group behavior: ",
                      widget.animal.characteristics.groupBehavior,
                    ),

                    _infoLine(
                      "Lifestyle: ",
                      widget.animal.characteristics.lifestyle,
                    ),

                    _divider(),

                    _infoLine("Kingdom: ", widget.animal.taxonomy.kingdom),
                    _infoLine("Phylum: ", widget.animal.taxonomy.phylum),
                    _infoLine(
                      "Animal class: ",
                      widget.animal.taxonomy.animalClass,
                    ),
                    _infoLine("Order: ", widget.animal.taxonomy.order),
                    _infoLine("Family: ", widget.animal.taxonomy.family),
                    _infoLine("Genus: ", widget.animal.taxonomy.genus),
                    _infoLine("Group: ", widget.animal.characteristics.group),
                    _infoLine(
                      "Number of species: ",
                      widget.animal.characteristics.numberOfSpecies,
                    ),

                    const SizedBox(height: 24),
                    if (widget.draft != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isSaving ? null : _saveAnimal,
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.bookmark_add_rounded),
                          label: Text(_isSaving ? 'Saving...' : 'Save animal'),
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
    final imageUrl = await ref
        .read(animalServiceProvider)
        .fetchRandomImage(widget.animalName);

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
      SizedBox(width: 16,),
      Expanded(
        child: Text(
        characteristic.isNotEmpty ? characteristic : "unknow",
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),)
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
