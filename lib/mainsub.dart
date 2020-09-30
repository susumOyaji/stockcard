import 'package:flutter/material.dart';




void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Example',
      home: AnimationExampleView(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

/// `StatefulWidget`を作成します。
class AnimationExampleView extends StatefulWidget {
  @override
  _AnimationExampleViewState createState() => _AnimationExampleViewState();
}

/// `State`に対して`TickerProviderStateMixin`を適用します。
class _AnimationExampleViewState extends State<AnimationExampleView>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    /// `initState()`内にて`AnimationController`を初期化します。
    _animationController = AnimationController(

        /// アニメーションを何秒掛けて行うかを設定します。
        /// ここでは2000ms(=2秒間)かけてアニメーション処理を行うように設定しています。
        duration: const Duration(milliseconds: 2000),

        /// `vsync`には`this`を渡します。
        vsync: this);

    /// 初期化した`AnimationController`を再生します。
    /// `from`パラメーターはどの地点から再生するかを指定可能で、0.0 ~ 1.0 の間の値を指定します。
    _animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  void dispose() {
    /// `Widget`が`dispose()`されるタイミングで`AnimationController`の`dispose()`も必ずコールします。
    /// コールし忘れるとオブジェクトが開放されず、メモリリーク等の原因となります。
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildAnimation(),
    );
  }

  Widget _buildAnimation() {
    /// `AnimatedBuilder`はセットした`AnimationController`の状態が変化した際に
    /// `builder`に渡した関数をその都度実行することで再描画を行ってくれます。
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// `AnimationController`の現在の値は`AnimationController.value`にて取得出来ます。
                /// `AnimationController.value`の値は、0.0 ~ 1.0 の間で変動します。
                /// 今回の場合は初期化時に設定した通り、2秒間かけて、0.0 ~ 1.0 まで直線的に値が増加します。
                Text('Animation Controller Value: '),
                Text('${_animationController.value}')
              ],
            )
          ],
        );
      },
    );
  }
}
