
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/model.dart';
import '../utils/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  String initialLength = "10";
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        initialLength = (int.parse(initialLength) + 10).toString();
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Airline Details")),
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          PassengerDetails? details = snapshot.data as PassengerDetails?;
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong......"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                controller: _controller,
                itemCount: details!.data!.length,
                itemBuilder: (BuildContext context, index) {
                  Data passengerData = details.data![index];
                  if (index!=details!.data!.length-1) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                              color: Colors.indigo.withOpacity(0.5),
                              height: 60,
                              child: Center(
                                  child: Text(
                                passengerData.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))),
                          Expanded(
                            child: Card(
                              color: Colors.black12.withOpacity(0.1),
                              child: ListView.builder(
                                  itemCount: passengerData!.airline!.length,
                                  itemBuilder: (BuildContext context, index2) {
                                    Airline airlineData =
                                        passengerData!.airline![index2];
                                    return SizedBox(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                              airlineData.name.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                            Text(
                                              airlineData.slogan.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Image.network(
                                                  airlineData.logo.toString()),
                                            )
                                          ],
                                        ));
                                  }),
                            ),
                          )
                        ],
                      ));
                  } else {
                    return Shimmer.fromColors(
                      period: const Duration(milliseconds: 1500),
                      direction: ShimmerDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      baseColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.white);
                  }
                });
          } else {
            return ListView.builder(
                itemCount: int.parse(initialLength),
                itemBuilder: (BuildContext context, index) {
                  return Shimmer.fromColors(
                      period: const Duration(milliseconds: 1500),
                      direction: ShimmerDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      baseColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.white);
                });
          }
        },
        future: fetchPassengerDetails(initialLength),
      ),
    );
  }
}
