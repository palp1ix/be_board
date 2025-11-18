import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/res/app_colors.dart';
import 'package:be_board/core/project_setup.dart';
import 'package:flutter/material.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  RangeValues _currentRangeValues = const RangeValues(150, 750);
  String _selectedCondition = 'New';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              top: 80,
              bottom: 100,
            ), // Adjust top padding for search bar
            children: [
              _buildCategoryExpansionTile(
                'Electronics',
                initiallyExpanded: true,
              ),
              _buildCategoryExpansionTile('Furniture'),
              _buildCategoryExpansionTile('Vehicles'),
              _buildCategoryExpansionTile('Clothing & Accessories'),
            ],
          ),
          _buildDraggableSheet(context),
          _buildBottomCta(context),
        ],
      ),
    );
  }

  Widget _buildDraggableSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          color: AppColors.backgroundLight,
          child: Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textGreyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.backgroundLight,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search all items...',
          hintStyle: const TextStyle(color: AppColors.textGrey),
          prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textGrey),
            onPressed: () {
              sl<AppNavigator>().pop();
            },
          ),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryExpansionTile(
    String title, {
    bool initiallyExpanded = false,
  }) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.expand_more),
      children: [
        if (title == 'Electronics') _buildElectronicsFilters(),
        if (title != 'Electronics')
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Filter controls for $title would appear here.',
              style: const TextStyle(color: AppColors.textGrey),
            ),
          ),
      ],
    );
  }

  Widget _buildElectronicsFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Condition',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: ['New', 'Used', 'For Parts'].map((condition) {
              final isSelected = _selectedCondition == condition;
              return ChoiceChip(
                label: Text(
                  condition,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textBlack,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedCondition = condition;
                    });
                  }
                },
                backgroundColor: AppColors.white,
                selectedColor: AppColors.textBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.textGreyLight),
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000,
            activeColor: AppColors.textBlack,
            inactiveColor: AppColors.textGreyLight,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_currentRangeValues.start.round()}',
                style: const TextStyle(color: AppColors.textGrey),
              ),
              Text(
                '\$${_currentRangeValues.end.round()}',
                style: const TextStyle(color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundLight.withOpacity(0.0),
              AppColors.backgroundLight.withOpacity(1.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textBlack,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8, // Shadow-lg
          ),
          child: const Text(
            'Show 1,204 items',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
