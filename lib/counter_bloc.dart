
import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;

    _eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        if(counter == 0){
          CounterAction.Reset;
        }else {
          counter--;
        }

      } else if (event == CounterAction.Reset) {
        counter = 0;
      }

      _counterSink.add(counter);
    });
  }
}
