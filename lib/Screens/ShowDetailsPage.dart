import 'package:flutter/material.dart';
import 'package:movies_app/models/show_models.dart';

import '../utils/colors.dart';

class ShowDetailsPage extends StatefulWidget {
  final ShowModels movie;

  const ShowDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Container(
              width: MediaQuery.of(context).size.width - 2 * 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.movie.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.primary,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.movie.image),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              widget.movie!.name,
                              style: TextStyle(fontSize: 25),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            color: Colors.grey,
                            width: 1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.movie.status,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.movie.startDate,
                    style: TextStyle(color: Colors.white,)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 20),
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(10),
      //           child: Image.network(
      //             widget.movie.image,
      //             height: 200,
      //             width: double.infinity,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           widget.movie.name,
      //           style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         SizedBox(height: 10),
      //         Text(
      //           widget.movie.country,
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.grey[800],
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //         ElevatedButton(
      //           onPressed: () {
      //             // Perform an action or navigate
      //           },
      //           child: Text('Take Action'),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.blueAccent,
      //             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
