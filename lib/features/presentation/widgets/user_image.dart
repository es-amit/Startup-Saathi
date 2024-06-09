import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Widget? child;

  const UserImage.small({
    super.key,
    this.url,
    this.height = 60,
    this.width = 60,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  const UserImage.medium({
    super.key,
    this.url,
    this.height = 200,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  const UserImage.large({
    super.key,
    this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.cover,
            image: (url == null)
                ? const AssetImage('assets/pic.jpeg') as ImageProvider
                : NetworkImage(url!)),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: border,
        boxShadow: boxShadow,
        color: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }
}




// const [
//         const BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 4,
//           blurRadius: 4,
//           offset: Offset(3, 3),
//         )