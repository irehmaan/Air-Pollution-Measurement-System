import 'package:airmonitoring/SensorData/models/sensordata.dart';

import 'package:airmonitoring/SensorData/stream/stream.dart';
import 'package:airmonitoring/homescreen/widgets/ui.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SensorDataStream _sensorDataStream = SensorDataStream();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text(
          "Air Quality Data",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Note:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 0,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Data is being updated every 5 seconds.You can configure update interval time in Esp32 code or in stream file within the app."),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<SensorData>>(
              stream: _sensorDataStream.sensorDataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Sonmething went Wrong...."),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No data available"),
                  );
                } else {
                  final sensorDataList = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final sensorData = sensorDataList[index];
                        return uiLayout(sensorData: sensorData);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
