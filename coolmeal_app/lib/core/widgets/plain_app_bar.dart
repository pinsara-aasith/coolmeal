import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const PlainAppBar(
      {Key? key,
      required this.title,
      required this.onBackPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      backgroundColor: Colors.transparent,
      leading: onBackPressed != null
          ? Transform.translate(
              offset: const Offset(10, 0),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Color(0xFFCDE2DE),
                      width: 1,
                    )),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_sharp),
                    color: Colors.black,
                    iconSize: 20,
                    onPressed: onBackPressed,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      elevation: 0,
    );
  }
}
