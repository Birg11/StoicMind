// lib/screens/teaching_detail_screen.dart
import 'package:flutter/material.dart';

class TeachingDetailScreen extends StatelessWidget {
  final String title;
  final List<String> quotes;
  final String reflection;

  const TeachingDetailScreen({
    required this.title,
    required this.quotes,
    required this.reflection,
    super.key,
  });

  static final Map<String, Map<String, dynamic>> teachingsData = {
    'Amor Fati': {
      'quotes': [
        'Amor Fati – “Love your fate”, which is in fact your life.',
        'Don’t seek for everything to happen as you wish it would, but rather wish that everything happens as it actually will — then your life will flow well.'
      ],
      'reflection': 'Embrace all things — not just the pleasant. To love your fate is to live without resistance, and in full acceptance of the now.'
    },
    'Memento Mori': {
      'quotes': [
        'You could leave life right now. Let that determine what you do and say and think.',
        'Death smiles at us all. All a man can do is smile back.'
      ],
      'reflection': 'Remembering death makes you live with urgency and grace. It strips away the unnecessary and prioritizes virtue.'
    },
    'Dichotomy of Control': {
      'quotes': [
        'Some things are in our control and others not.',
        'Make the best use of what is in your power, and take the rest as it happens.'
      ],
      'reflection': 'Peace comes when we stop trying to control what is not ours. Our mind is our domain — protect it.'
    },
    'Virtue is the Only Good': {
      'quotes': [
        'If it is not right, do not do it. If it is not true, do not say it.',
        'A man’s worth is no greater than his ambitions.'
      ],
      'reflection': 'All things fade. But virtue? That endures. Make it your aim and your compass.'
    },
    'The Obstacle is the Way': {
      'quotes': [
        'The impediment to action advances action. What stands in the way becomes the way.',
        'Difficulties show a person’s character — let yours be one of calm and strength.'
      ],
      'reflection': 'Hardship is fuel. The Stoic turns trials into triumphs. What blocks the path, becomes the path.'
    },
    'Premeditatio Malorum': {
      'quotes': [
        'He robs present ills of their power who has perceived their coming beforehand.',
        'Prepare yourself for the things which you dread and fear — and they’ll lose their sting.'
      ],
      'reflection': 'Visualizing hardship trains our mind to respond, not react. We are ready because we rehearse.'
    },
    'Sympatheia': {
      'quotes': [
        'What injures the hive injures the bee.',
        'We are made for cooperation, like feet, like hands, like eyelids, like the rows of the upper and lower teeth.'
      ],
      'reflection': 'You are not alone. Stoicism recognizes the unity of all — from the stars to the stranger beside you.'
    }
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key Quotes',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[100] : null,
              ),
            ),
            const SizedBox(height: 12),
            ...quotes.map((q) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                '"$q"',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.grey[300] : Colors.black87,
                ),
              ),
            )),
            const Divider(height: 40),
            Text('Reflection',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[100] : null,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              reflection,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: isDark ? Colors.grey[300] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
