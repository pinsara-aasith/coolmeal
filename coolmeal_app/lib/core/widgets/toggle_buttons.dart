import 'package:flutter/material.dart';

class CMToggleButtons extends StatelessWidget {
  final String? selectedKey;
  final void Function(String) onSelected;
  final Map<String, List<dynamic>> keyValueMap;
  final bool hideIcon;

  const CMToggleButtons({
    super.key,
    required this.selectedKey,
    required this.onSelected,
    required this.keyValueMap,
    this.hideIcon = false,
  });

  void toggleSelection(String key) {
    onSelected(key);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keyValueMap.entries.map((entry) {
        final String key = entry.key;
        final String label = entry.value[0] as String;

        IconData? icon;
        if (!hideIcon) icon = entry.value[1] as IconData;

        return Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: buildToggleButton(context, key, label, icon),
        ));
      }).toList(),
    );
  }

  Widget buildToggleButton(
      BuildContext context, String key, String label, IconData? icon) {
    return InkWell(
      onTap: () => toggleSelection(key),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedKey == key
                ? Theme.of(context).primaryColor
                : Colors.grey,
            width: 1,
          ),
          color: selectedKey == key
              ? Theme.of(context).primaryColor.withAlpha(70)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (!hideIcon) Icon(icon, color: Theme.of(context).primaryColor),
            if (!hideIcon) const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    selectedKey == key ? FontWeight.bold : FontWeight.normal,
                color: selectedKey == key
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
