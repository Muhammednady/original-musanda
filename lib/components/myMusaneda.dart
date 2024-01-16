// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/myColor.dart';

Widget myMusanedaCard({context, name, image, age, country, about}) {
  return Container(
    height: 115,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      horizontal: 3,
    ),
    decoration: BoxDecoration(
      color: MYColor.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: MYColor.greyDeep.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: MYColor.primary,
                      strokeWidth: 0.1,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name.substring(0, name.length > 15 ? 15 : name.length),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      age,
                      style: TextStyle(
                        fontSize: 12,
                        color: MYColor.greyDeep,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       country,
                //       style: TextStyle(
                //         fontSize: 12,
                //         color: MYColor.greyDeep,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        about,
                        style: TextStyle(
                          fontSize: 10,
                          color: MYColor.greyDeep,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
