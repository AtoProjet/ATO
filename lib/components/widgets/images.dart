import 'package:flutter/material.dart';


Image atoAssetOfIcon(String name, {
  double width = 24,
  double height = 24,
  Color? color,
}) {
  return Image.asset(
    "assets/icons/$name",
    width: width,
    height: height,
    color: color,
  );
}

Image atoAssetOfImage(String name, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  alignment= Alignment.center,
}) {
  return
    Image.asset(
      "assets/images/$name",
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
}

Image atoNetworkImage(String link, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  alignment= Alignment.center,
}) {
  return
    Image.network(
      link,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
}

DecorationImage atoAssetOfCategory(String name) {
  return DecorationImage(
    image: AssetImage("assets/categories/$name"),
    fit: BoxFit.cover,
  );
}


Center atoProfileImage({String? url, double radius = 48}) {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: url != null
          ? atoNetworkImage(
              url,
              width: radius * 2,
              height: radius * 2,
            )
          : atoAssetOfImage(
              "ic_user_female.jpg",
              width: radius * 2,
              height: radius * 2,
            ),
    ),
  );
}

