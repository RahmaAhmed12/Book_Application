
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        title:Padding(
          padding: const EdgeInsets.only(left: 60,),
          child: Text("Favorite", style:TextStyle(color: Colors.teal , fontSize: 20,fontWeight: FontWeight.bold)),
        ),


      ),
    );
  }
}
