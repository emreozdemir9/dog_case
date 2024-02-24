import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs_case/constants/colors.dart';
import 'package:dogs_case/constants/string_utils.dart';
import 'package:dogs_case/models/dog.dart';
import 'package:dogs_case/screens/dog_details/bloc/details_bloc.dart';
import 'package:dogs_case/screens/dog_details/bloc/details_event.dart';
import 'package:dogs_case/screens/dog_details/bloc/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogDetails extends StatelessWidget {
  final DogModel dogModel;

  const DogDetails(this.dogModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        margin: const EdgeInsets.only(bottom: 90, right: 16, left: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: dogModel.imageUrl ?? '',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    )),
                Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(Icons.clear))),
                ),
              ],
            ),
            _title(StringUtils.breed),
            _divider(),
            _breed(dogModel.name ?? ''),
            _title(StringUtils.subBreed),
            _divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: SingleChildScrollView(
                child: dogModel.subBreeds == null || dogModel.subBreeds!.isEmpty
                    ? _breed(StringUtils.notFoundForThisDog)
                    : Column(
                        children: List.generate(
                          dogModel.subBreeds?.length ?? 0,
                          (index) => _breed(dogModel.subBreeds![index]),
                        ),
                      ),
              ),
            ),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            BlocProvider(
              create: (context) => DetailBlock(context),
              child: BlocConsumer<DetailBlock, DetailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (!state.isLoading) {
                    return Container(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonBlue,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          context
                              .read<DetailBlock>()
                              .add(RandImageEvent(dogModel.name!));
                        },
                        child: const Text(
                          StringUtils.generate,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.buttonBlue,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _title(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Color(0xFF0055D3),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _breed(String breed) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        breed,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        thickness: 2,
        height: 2,
        color: AppColors.bottombarBackground,
      ),
    );
  }
}
