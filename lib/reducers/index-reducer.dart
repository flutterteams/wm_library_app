import 'package:redux/redux.dart';
import 'package:wm_library_app/model/index.dart';

final IndexReducer = combineReducers<Index>([
  TypedReducer<Index, IndexAction>(_changeIndex),
]);

Index _changeIndex(Index index, action) {
  print(action.index);
  index = action.index;
  return index;
}

class IndexAction {
  Index index;
  IndexAction(this.index);
}