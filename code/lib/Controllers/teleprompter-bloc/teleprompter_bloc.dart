// File: teleprompter_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter/material.dart';

// BLoC Event
abstract class TeleprompterEvent {}

class StartScrolling extends TeleprompterEvent {}

class StopScrolling extends TeleprompterEvent {}

class UpdateScrollSpeed extends TeleprompterEvent {
  final double speed;

  UpdateScrollSpeed(this.speed);
}

// BLoC State
class TeleprompterState {
  final bool isScrolling;
  final double scrollSpeed;

  TeleprompterState({required this.isScrolling, required this.scrollSpeed});
}

// BLoC Implementation
class TeleprompterBloc extends Bloc<TeleprompterEvent, TeleprompterState> {
  final ScrollController scrollController;
  Timer? _scrollTimer;

  TeleprompterBloc(this.scrollController)
      : super(TeleprompterState(isScrolling: false, scrollSpeed: 20.0)) {
    on<StartScrolling>((event, emit) {
      _startScrolling();
      emit(TeleprompterState(isScrolling: true, scrollSpeed: state.scrollSpeed));
    });

    on<StopScrolling>((event, emit) {
      _stopScrolling();
      emit(TeleprompterState(isScrolling: false, scrollSpeed: state.scrollSpeed));
    });

    on<UpdateScrollSpeed>((event, emit) {
      emit(TeleprompterState(isScrolling: state.isScrolling, scrollSpeed: event.speed));
    });
  }

  void _startScrolling() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.offset + (state.scrollSpeed / 10),
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopScrolling() {
    _scrollTimer?.cancel();
  }

  @override
  Future<void> close() {
    _stopScrolling();
    return super.close();
  }
}

