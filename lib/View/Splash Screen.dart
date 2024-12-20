import 'dart:async';

import 'package:covid_tracking_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

   late final AnimationController _controller = AnimationController(
       duration: const Duration(seconds: 3),
       vsync: this)..repeat();

  @override

  void dispose()
  {
    super.dispose();
    _controller.dispose();
  }

  void initState(){
    super.initState();
    Timer(const Duration(seconds: 5),
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStates()))
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _controller.value*2.0*math.pi,
                );
              }),


          SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
          const Align(
            alignment: Alignment.center,
            child: Text("Covid-19\nTracker App", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25
            ),),
          )
        ],
      ))
    );

  }
}
