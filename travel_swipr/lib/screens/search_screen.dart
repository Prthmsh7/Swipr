import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../viewmodels/travel_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  final Function onSearchComplete;

  const SearchScreen({
    Key? key,
    required this.onSearchComplete,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  double _budget = 1000;
  int _days = 5;
  String _selectedType = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'TravelSwipr',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'What are you looking for?',
                  style: AppTheme.subheadingStyle,
                ),
                SizedBox(height: 12),
                _buildTypeSelector(),
                SizedBox(height: 24),
                Text(
                  'What\'s your budget?',
                  style: AppTheme.subheadingStyle,
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${_budget.toInt()}',
                        style: AppTheme.priceStyle,
                      ),
                      Slider(
                        value: _budget,
                        min: 500,
                        max: 5000,
                        divisions: 45,
                        activeColor: AppTheme.primaryColor,
                        inactiveColor: AppTheme.borderColor,
                        onChanged: (value) {
                          setState(() {
                            _budget = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$500', style: AppTheme.captionStyle),
                          Text('\$5000', style: AppTheme.captionStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'How many days?',
                  style: AppTheme.subheadingStyle,
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_days.toInt()} days',
                        style: AppTheme.priceStyle,
                      ),
                      Slider(
                        value: _days.toDouble(),
                        min: 1,
                        max: 30,
                        divisions: 29,
                        activeColor: AppTheme.primaryColor,
                        inactiveColor: AppTheme.borderColor,
                        onChanged: (value) {
                          setState(() {
                            _days = value.toInt();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1 day', style: AppTheme.captionStyle),
                          Text('30 days', style: AppTheme.captionStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Set values in ViewModel
                      final viewModel = context.read<TravelViewModel>();
                      viewModel.setBudgetAndDays(_budget, _days);
                      viewModel.setSelectedType(_selectedType);
                      
                      // Call the callback to navigate to next screen
                      widget.onSearchComplete();
                    },
                    style: AppTheme.primaryButtonStyle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Find Destinations',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTypeOption('All', 'all'),
          _buildTypeOption('Hotels', 'hotel'),
          _buildTypeOption('Destinations', 'destination'),
        ],
      ),
    );
  }

  Widget _buildTypeOption(String label, String value) {
    final bool isSelected = _selectedType == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.secondaryTextColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
} 