import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RandomImageDialog extends StatelessWidget {
  final String imageUrl;

  const RandomImageDialog(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.height * 0.33,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.clear)),
            ),
          ],
        ),
      ),
    );
  }
}
