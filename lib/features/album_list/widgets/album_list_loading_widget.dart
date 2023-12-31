import 'package:flutter/material.dart';

class AlbumListLoadingWidget extends StatelessWidget {
  const AlbumListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
