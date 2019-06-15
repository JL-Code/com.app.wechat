import 'package:flutter/material.dart';
import 'package:com_app_wechat/constants.dart'
    show Constants, AppColors, AppStyles;
import 'package:com_app_wechat/widget_helper/avatar_helper.dart';

class Cell extends StatelessWidget {
  const Cell({
    @required this.title,
    this.desc: "",
    @required this.iconPath,
    @required this.onPressed,
    this.showArrow: true,
    this.showDivider: true,
    this.valueWidget,
  })  : assert(iconPath != null),
        assert(title != null),
        assert(onPressed != null);

  static const double CellPadding = 16.0;
  static const double CellAvatarSize = 20.0;
  static const DOT_RADIUS = 5.0;

  /// 显示分割线
  final bool showDivider;

  ///显示箭头
  final bool showArrow;
  final String title;
  final String desc;
  final String iconPath;
  final VoidCallback onPressed;

  /// 自定义Widget
  final Widget valueWidget;

  /// 构建单元
  Widget _buildCore(String avatar, String title, String desc) {
    final Border _divider = showDivider
        ? Border(
            bottom: BorderSide(
                color: const Color(AppColors.DividerColor),
                width: Constants.DividerWidth),
          )
        : null;
    final _children = <Widget>[
      /// 头像
      Container(
        padding: EdgeInsets.only(right: CellPadding),
        child: AvatarHelper.buildAvatar(avatar, CellAvatarSize, CellAvatarSize),
      ),

      /// 标题
      Expanded(
        child: Text(title),
      ),

      /// 说明文字
      Container(),

      /// 箭头
      Container(),
    ];

    if (desc.isNotEmpty) {
      final descWidget = Text(
        desc,
        style: TextStyle(color: Colors.grey),
      );
      _children[2] = descWidget;
    }

    if (this.showArrow) {
      _children[3] = buildArrow();
    }

    final Widget _cell = Container(
      padding: EdgeInsets.all(CellPadding),
      decoration: BoxDecoration(
        border: _divider,
      ),
      child: Row(children: _children),
    );
    return _cell;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(left: 0),
      color: Colors.white,
      child: _buildCore(this.iconPath, this.title, this.desc),
      onPressed: this.onPressed,
    );
  }

  /// 构建箭头
  Widget buildArrow() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: const Color(AppColors.ButtonArrowColor),
    );
  }

  /// 按钮上的描述性文字Widget
  /// * [desc] 显示在文本上的信息
  static Text descText(final desc) {
    return Text(desc, style: AppStyles.ButtonDesTextStyle);
  }

  /// 按钮上的图片标签，可以根据 [path] 的内容自动生成assets或者网络上的图片
  /// * [path] 图片在assets文件夹中的路径或者网络上的URL
  /// * [showDot] 是否需要显示图标右上角的原点
  /// * [isBig] 图标的大小
  static Widget iconTag(final String path,
      {bool showDot = false, bool isBig = false}) {
    var _icon = AvatarHelper.buildAvatar(path, CellAvatarSize, CellAvatarSize);
    if (showDot) {
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _icon,
          Positioned(
            right: isBig ? -3.0 : -7.0,
            top: isBig ? -3.0 : -7.0,
            child: Container(
              width: DOT_RADIUS * 2,
              height: DOT_RADIUS * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DOT_RADIUS),
                color: const Color(AppColors.NotifyDotBg),
              ),
            ),
          ),
        ],
      );
    }
    return _icon;
  }
}
