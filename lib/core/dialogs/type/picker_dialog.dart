import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';

import '../../../translations/locale_keys.g.dart';

class PickerDialog extends StatelessWidget {
  const PickerDialog(
      {super.key, required this.galleryPicker, required this.cameraPicker, this.deletePicker});

  final VoidCallback galleryPicker;
  final VoidCallback cameraPicker;
  final VoidCallback? deletePicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            tr(LocaleKeys.detected_face_pick_photo_text),
            style: StyleManager.font16SemiBold(),
          ),
        ),

        Visibility(
          visible: deletePicker!=null,
          child: ListTile(
            onTap: deletePicker,
            leading: Icon(Icons.delete),
            title: Text(tr(LocaleKeys.home_delete_photo_text)),
          ),
        ),
        ListTile(
          onTap: cameraPicker,
          leading: Icon(Icons.camera_alt_outlined),
          title: Text(tr(LocaleKeys.home_pick_from_camera_text)),
        ),
        ListTile(
          onTap: galleryPicker,
          leading: Icon(Icons.image_outlined),
          title: Text(tr(LocaleKeys.home_pick_from_gallery_text)),
        ),
      ],
    );
  }
}
