import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/data/models/theater.dart';
import 'package:inkino/ui/theater_list/theater_list_view_model.dart';
import 'package:meta/meta.dart';

class TheaterList extends StatelessWidget {
  TheaterList({
    @required this.header,
    @required this.onTheaterTapped,
  });

  final Widget header;
  final VoidCallback onTheaterTapped;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.vertical;

    return new Transform(
      transform: new Matrix4.translationValues(0.0, -statusBarHeight, 0.0),
      child: new StoreConnector<AppState, TheaterListViewModel>(
        distinct: true,
        converter: (store) => TheaterListViewModel.fromStore(store),
        builder: (BuildContext context, TheaterListViewModel viewModel) {
          return new ListView.builder(
            itemCount: viewModel.theaters.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return header;
              }

              var theater = viewModel.theaters[index - 1];
              var isSelected = viewModel.currentTheater.id == theater.id;

              return new Material(
                color: isSelected
                    ? const Color(0xFFEEEEEE)
                    : Theme.of(context).canvasColor,
                child: new ListTile(
                  onTap: () {
                    viewModel.changeCurrentTheater(theater);
                    onTheaterTapped();
                  },
                  selected: isSelected,
                  title: new Text(theater.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
