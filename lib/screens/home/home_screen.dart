import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs_case/constants/string_utils.dart';
import 'package:dogs_case/models/dog.dart';
import 'package:dogs_case/screens/dog_details/dog_details_screen.dart';
import 'package:dogs_case/screens/home/bloc/home_bloc.dart';
import 'package:dogs_case/screens/home/bloc/home_event.dart';
import 'package:dogs_case/screens/home/home_widgets.dart';
import 'package:dogs_case/screens/home/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final List<DogModel> dogList;
  final String? searchText;
  const HomeScreen(this.dogList, this.searchText, {super.key});

  @override
  Widget build(BuildContext context) {
    DraggableScrollableController draggableController =
        DraggableScrollableController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          dogList.isEmpty
              ? const Center(
                  child: Text(StringUtils.trySearchingWithAnotherWord),
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      shrinkWrap: true,
                      itemCount: dogList.length,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              barrierColor: Colors.black45,
                              builder: (context) {
                                return DogDetails(dogList[i]);
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: dogList[i].imageUrl ?? '',
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(8))),
                                    child: Text(
                                      dogList[i].name ?? '',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
          BlocProvider(
            create: (context) => HomeBloc(context),
            child: HomeWidgets.searchBarUI(
              searchText ?? '',
              onTap: () {
                showBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        height: double.infinity,
                        child: DraggableScrollableActuator(
                          child: DraggableScrollableSheet(
                            controller: draggableController,
                            initialChildSize: 0.6,
                            minChildSize: 0.6,
                            maxChildSize: 1,
                            expand: false,
                            snap: true,
                            shouldCloseOnMinExtent: false,
                            builder: (context, scrollController) {
                              int searchLine = 1;
                              return HomeWidgets.searchBar(
                                  context, scrollController, (searchVal) {
                                if (Utils.updateTextLineCountForSearchHeight(
                                            context, searchVal) >
                                        searchLine &&
                                    searchLine < 5) {
                                  searchLine++;
                                  draggableController
                                      .jumpTo(draggableController.size + 0.03);
                                }
                              }, (searchVal) {
                                Navigator.pop(context);
                                if (searchVal.toString().length > 2) {
                                  context.read<HomeBloc>().add(SearchEvent(
                                      searchVal.toString().toLowerCase()));
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
