import 'package:allerscan/ui/home/slicing/features/features.dart';
import 'package:allerscan/ui/home/slicing/header/header.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Header(),
            ),
          ),
          // Fitur
          SliverToBoxAdapter(
            child: FeatureSection(
            )),
          SliverToBoxAdapter(
            child: FeatureSection(
            )),
          SliverToBoxAdapter(
            child: FeatureSection(
            )),
          SliverToBoxAdapter(
            child: FeatureSection(
            )),
        ],
      ),
    );
  }
}
