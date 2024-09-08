import 'package:anggi_driweather/components/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Background(image: "assets/images/bg-onboard.png",),

          Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 35, right: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Never get caught in the rain again",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 20,),

                const Text(
                  "Stay ahead of the weather with our accurate forecasts",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 20,),

                Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      child: const Center(
                        child: Text("Get Started"),
                      ),
                    ),
                    onTap: () {
                      Get.offNamed("/home");
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}