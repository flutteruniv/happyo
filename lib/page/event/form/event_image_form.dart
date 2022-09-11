import 'package:flutter/material.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/common/image_picker.dart'
    if (dart.library.io) 'package:happyo/common/image_picker_mobile.dart'
    if (dart.library.html) 'package:happyo/common/image_picker_web.dart'
    as image_picker;

class EventImageForm extends StatefulWidget {
  EventFormLabel? label;
  Image? _image;
  Function(Image?)? onCahnaged;

  EventImageForm({
    super.key,
    this.label,
  });

  @override
  State<StatefulWidget> createState() => _EventImageFormState();
}

class _EventImageFormState extends State<EventImageForm> {
  Future<Image?> _pickImage() async {
    logger.debug('pick image');
    return await image_picker.pickImage();
  }

  void _updateImage(Image? image) {
    setState(() {
      widget._image = image;
    });
    if (widget.onCahnaged != null) {
      widget.onCahnaged!(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null) widget.label!,
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 6,
          ),
          width: 200,
          height: 200,
          child: widget._image != null
              ? widget._image!
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Center(child: Text('イメージ画像')),
                ),
        ),
        TextButton(
          onPressed: () async {
            Image? image = await _pickImage();
            _updateImage(image);
          },
          child: const Text('画像を選択'),
        )
      ],
    );
  }
}
