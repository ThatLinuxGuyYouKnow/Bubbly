import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardTextEditingField extends StatefulWidget {
  const StandardTextEditingField({
    super.key,
    required this.valueValidator,
    required this.hintText,
    this.autofillHints,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.controller,
    this.trailingWidget,
  });

  final Function(String) valueValidator;
  final List<String>? autofillHints;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final Widget? trailingWidget;

  @override
  State<StandardTextEditingField> createState() =>
      _StandardTextEditingFieldState();
}

class _StandardTextEditingFieldState extends State<StandardTextEditingField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    final validationResult = widget.valueValidator(_controller.text);
    setState(() {
      _hasError = validationResult != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white)],
        border: Border.all(
          color: _getFieldColor(),
          width: 2.5,
        ),
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.trailingWidget ?? SizedBox.shrink(),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: Colors.grey[400],
              fontSize: 18,
            ),
            border: InputBorder.none,
            errorStyle: const TextStyle(height: 0),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          autofillHints: widget.autofillHints,
        ),
      ),
    );
  }

  Color _getFieldColor() {
    if (_hasError) {
      return Colors.red;
    }
    if (_isFocused) {
      return Colors.purple;
    }
    return Colors.purple.withOpacity(0.5);
  }
}
