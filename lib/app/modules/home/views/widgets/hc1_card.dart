import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import 'card_group_widget.dart';

class HC1CardDesign extends BaseCardDesign {
  // Optional parameter to control width in horizontal scroll
  final bool isInHorizontalScroll;

  const HC1CardDesign({
    Key? key,
    required CardModel card,
    this.isInHorizontalScroll = false
  }) : super(key: key, card: card);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isInHorizontalScroll ? 250 : double.infinity, // Adjust width for horizontal scroll
      margin: const EdgeInsets.symmetric(horizontal: 4), // Add some spacing between cards
      child: Card(
        elevation: 0,
        color: Color(int.parse(card.bgColor!.replaceFirst('#', '0xFF'))),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimum space
          children: [
            // ListTile
            ListTile(
              leading: _buildLeadingIcon(),
              title: _buildTitle(),
              subtitle: _buildSubtitle(),
              trailing: _buildTrailingCTA(),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildLeadingIcon() {
    return card.icon?.imageUrl != null
        ? Image.network(
      card.icon!.imageUrl!,
      width: 30,
      height: 30,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/icons/hc1fallback.png', // Fallback image from assets
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        );
      },
    )
        : null;
  }
  Widget _buildTitle() {
    if (card.formattedTitle != null) {
      // If there are entities, use the first entity's text
      if (card.formattedTitle!.entities.isNotEmpty) {
        return Text(
          card.formattedTitle!.entities.first.text,
          style: TextStyle(
            color: card.formattedTitle!.entities.first.color != null
                ? Color(int.parse(card.formattedTitle!.entities.first.color!.replaceFirst('#', '0xFF')))
                : null,
            fontStyle: card.formattedTitle!.entities.first.fontStyle == 'italic'
                ? FontStyle.italic
                : FontStyle.normal,
          ),
        );
      }
      // Fallback to formatted title text
      return Text(card.formattedTitle!.text);
    }

    // Fallback to regular title or name
    return Text(card.title ?? card.name);
  }

  Widget? _buildSubtitle() {
    // Prefer formatted description, then fallback to regular description
    if (card.formattedDescription != null) {
      // If there are entities, use the first entity's text
      if (card.formattedDescription!.entities.isNotEmpty) {
        return Text(
          card.formattedDescription!.entities.first.text,
          style: TextStyle(
            color: card.formattedDescription!.entities.first.color != null
                ? Color(int.parse(card.formattedDescription!.entities.first.color!.replaceFirst('#', '0xFF')))
                : null,
          ),
        );
      }
      // Fallback to formatted description text
      return Text(card.formattedDescription!.text);
    }

    // Fallback to regular description
    return card.description != null ? Text(card.description!) : null;
  }

  Widget? _buildTrailingCTA() {
    // Check if CTAs exist
    if (card.cta != null && card.cta!.isNotEmpty) {
      final firstCTA = card.cta!.first;
      return ElevatedButton(
        onPressed: () {
          // TODO: Implement proper navigation or action
          print('HC1 Card CTA: ${firstCTA.text}');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: firstCTA.bgColor != null
              ? Color(int.parse(firstCTA.bgColor!.replaceFirst('#', '0xFF')))
              : null,
        ),
        child: Text(
          firstCTA.text,
          style: TextStyle(
            color: firstCTA.textColor != null
                ? Color(int.parse(firstCTA.textColor!.replaceFirst('#', '0xFF')))
                : null,
          ),
        ),
      );
    }
    return null;
  }
}
