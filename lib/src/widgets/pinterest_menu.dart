// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({
    required this.onPressed, 
    required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final List<PinterestButton> items = [
    PinterestButton(onPressed: (){print('Icon pie_chart');}, icon: Icons.pie_chart),
    PinterestButton(onPressed: (){print('Icon search');}, icon: Icons.search),
    PinterestButton(onPressed: (){print('Icon notifications');}, icon: Icons.notifications),
    PinterestButton(onPressed: (){print('Icon supervised_user_circle');}, icon: Icons.supervised_user_circle),
  ];
  PinterestMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: avoid_unnecessary_containers
      child: Container(
        
        width: 250,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              spreadRadius: -5
            )            
          ] 
        ),
        
        child: _MenuItems(menuItems: items),
      )
    ); 
   }
}


class _MenuItems extends StatelessWidget {

  final List<PinterestButton> menuItems;
  const _MenuItems({
    required this.menuItems
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuButton( index: i, item: menuItems[i])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  
  final int index;
  final PinterestButton item;
  
  const _PinterestMenuButton({
    required this.index, 
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onPressed(),
    // ignore: avoid_unnecessary_containers
      child: Container(
        child: Icon(item.icon),
      ),
    );
  }
}