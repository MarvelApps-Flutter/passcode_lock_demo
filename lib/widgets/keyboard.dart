import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'keyboard.dart';

typedef KeyboardTapCallback = void Function(String text);

@immutable
class KeyboardUIConfig {
  //Digits have a round thin borders, [digitBorderWidth] define their thickness
  final double digitBorderWidth;
  final TextStyle digitTextStyle;
  final TextStyle deleteButtonTextStyle;
  final Color primaryColor;
  final Color digitFillColor;
  final EdgeInsetsGeometry keyboardRowMargin;
  final EdgeInsetsGeometry digitInnerMargin;

  //Size for the keyboard can be define and provided from the app.
  //If it will not be provided the size will be adjusted to a screen size.
  final Size? keyboardSize;

  const KeyboardUIConfig({
    this.digitBorderWidth = 1,
    this.keyboardRowMargin = const EdgeInsets.only(top: 15, left: 4, right: 4),
    this.digitInnerMargin = const EdgeInsets.all(24),
    this.primaryColor = Colors.white,
    this.digitFillColor = Colors.transparent,
    this.digitTextStyle = const TextStyle(fontSize: 30, color: Colors.white),
    this.deleteButtonTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
    this.keyboardSize,
  });
}

class Keyboard extends StatefulWidget {
  final KeyboardUIConfig keyboardUIConfig;
  final KeyboardTapCallback onKeyboardTap;
  static String deleteButton = 'keyboard_delete_button';

  //should have a proper order [1...9, 0]
  final List<String>? digits;

  Keyboard({
    Key? key,
    required this.keyboardUIConfig,
    required this.onKeyboardTap,
    this.digits,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final _focusNode = FocusNode();

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) => _buildKeyboard(context);

  Widget _buildKeyboard(BuildContext context) {
    List<String> keyboardItems = List.filled(11, '0');
    if (widget.digits == null || widget.digits!.isEmpty) {
      keyboardItems = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0',''];
    } else {
      keyboardItems = widget.digits!;
    }
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = screenSize.height > screenSize.width
        ? screenSize.height / 2
        : screenSize.height - 80;
    final keyboardWidth = keyboardHeight * 3 / 4;
    final keyboardSize = this.widget.keyboardUIConfig.keyboardSize != null
        ? this.widget.keyboardUIConfig.keyboardSize!
        : Size(keyboardWidth, keyboardHeight);
    return Container(
      width: keyboardSize.width,
      height: keyboardSize.height,
      margin: EdgeInsets.only(top: 16),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyUpEvent) {
            if (keyboardItems.contains(event.data.keyLabel)) {
              widget.onKeyboardTap(event.logicalKey.keyLabel);
              return;
            }
            // if (event.logicalKey.keyLabel == 'Backspace' ||
            //     event.logicalKey.keyLabel == 'Delete') {
            //   onKeyboardTap(Keyboard.deleteButton);
            //   return;
            // }
          }
        },
        child: AlignedGrid(
          keyboardSize: keyboardSize,
          children: List.generate(11, (index) {
            if(index == keyboardItems.length - 1)
            {
             return _buildKeyboardDigits(keyboardItems[index]);
            }
            else
            {
               return _buildKeyboardDigit(keyboardItems[index],index);
            }
            
          }),
        ),
      ),
    );
  }

  Widget _buildKeyboardDigits(String text) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: widget.keyboardUIConfig.primaryColor.withOpacity(0.4),
          onTap: () {
             widget.onKeyboardTap(Keyboard.deleteButton);
            //onKeyboardTap(text);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF292D32),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
            ),
            child: Icon(Icons.backspace_outlined,color: Colors.white,),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboardDigit(String text,int index) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          //splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
          onTap: () {
            
             setState(() => _selectedIndex = index);
            widget.onKeyboardTap(text);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedIndex != null && _selectedIndex == index
              ? 
              Color(0xff0943C9) : 
              Color(0xFF292D32),
              //
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: widget.keyboardUIConfig.digitTextStyle,
                semanticsLabel: text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlignedGrid extends StatelessWidget {
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize;
  final columns = 3;
  final List<Widget> children;
  final Size keyboardSize;

  const AlignedGrid(
      {Key? key, required this.children, required this.keyboardSize})
      : listSize = children.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primarySize = keyboardSize.width > keyboardSize.height
        ? keyboardSize.height
        : keyboardSize.width;
    final itemSize = (primarySize - runSpacing * (columns - 1)) / columns;
    return Wrap(
      runSpacing: runSpacing,
      spacing: spacing,
      alignment: WrapAlignment.end,
      children: children
          .map((item) => Container(
                width: itemSize,
                height: itemSize,
                child: item,
              ))
          .toList(growable: false),
    );
  }
}
