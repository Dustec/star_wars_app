import 'package:flutter/material.dart';
import 'package:star_wars_app/core/presentation/widgets/texts/body_text.dart';
import 'package:star_wars_app/core/presentation/widgets/texts/title_text.dart';
import 'package:star_wars_app/features/star_wars_api/domain/models/star_wars_planet.dart';

class PlanetCard extends StatelessWidget {
  const PlanetCard({
    Key? key,
    required this.planet,
  }) : super(key: key);

  final StarWarsPlanet planet;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _props = {
      'Clima: ': planet.climate,
      'Tipo de terreno: ': planet.terrain,
      'Población: ': planet.population,
      'Diámetro: ': planet.diameter,
    };

    List<Widget> _widgets = List.empty(growable: true);

    _props.forEach((key, value) {
      _widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            BodyText(key),
            Expanded(child: BodyText(value.toUpperCase())),
          ],
        ),
      ));
    });

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleText(
              planet.name,
              textAlign: TextAlign.center,
            ),
            ..._widgets,
          ],
        ),
      ),
    );
  }
}
