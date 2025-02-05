import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double width;
  final double height;
  final Widget text;
  final Function onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: ElevatedButton(
        onPressed: () async {
          await widget.onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        onHover: (value) {},
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.248),
              color: isHovered
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.6)
                  : Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: widget.text,
            ),
          ),
        ),
      ),
    );
  }
}
