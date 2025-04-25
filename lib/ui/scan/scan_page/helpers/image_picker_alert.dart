import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

Widget imagePickAlert({
  void Function()? onCameraPressed,
  void Function()? onGalleryPressed,
}) {
  return AlertDialog(
    backgroundColor: colorWhite,
    title: const Text("Ambil dari"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text("Camera"),
          onTap: onCameraPressed,
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text("Gallery"),
          onTap: onGalleryPressed,
        ),
      ],
    ),
  );
}
