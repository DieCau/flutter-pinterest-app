import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:pinterest_app/src/widgets/pinterest_menu.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({super.key});

  @override
  Widget build(BuildContext context) {
   
    return ChangeNotifierProvider(
      create:(_) => _MenuModel(), 
      child: Scaffold(
        body: Stack(children: [
          const PinterestGrid(),
          _PinterestMenuPosition(),
        ]
       ),
      ),
    );
  }
}

class _PinterestMenuPosition extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;
    final show = Provider.of<_MenuModel>(context).show;
    
    return Positioned(
      bottom: 30,
      child: SizedBox(
        width: widthScreen,
        child: Align(
          child: PinterestMenu(
            show: show,
          )
        )
      )
    );
  }
}


class PinterestGrid extends StatefulWidget {

  const PinterestGrid({super.key});

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  
  final List<int> items = List.generate(200, (index) => index);
  ScrollController controller = ScrollController();
  double scrollPrevius = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if ( controller.offset > scrollPrevius ) {
        Provider.of<_MenuModel>(context, listen: false).show = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).show = true;
      }

      scrollPrevius = controller.offset;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      )
    );
  }
}


class _MenuModel with ChangeNotifier {
  bool _show = true;

  // ignore: unnecessary_getters_setters
  bool get show => _show;

  set show( bool value ){
    _show = value;
    notifyListeners();
  }
}