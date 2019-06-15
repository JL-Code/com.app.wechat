import 'package:flutter/material.dart';
import 'package:com_app_wechat/constants.dart'
    show Constants, AppColors, AppStyles;
import 'package:com_app_wechat/widget_helper/avatar_helper.dart';

class Cell extends StatelessWidget {
  const Cell({
    @required this.title,
    this.desc,
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
    final _bodyWidgets = <Widget>[];
    final Border _divider = showDivider
        ? Border(
            bottom: BorderSide(
                color: const Color(AppColors.DividerColor),
                width: Constants.DividerWidth),
          )
        : null;

    if (this.valueWidget != null) {
      _bodyWidgets
        ..add(Text(title, style: AppStyles.TitleStyle))
        ..add(Expanded(
          child: valueWidget,
        ));
    } else if (this.desc != null) {
      _bodyWidgets
        ..add(Text(title, style: AppStyles.TitleStyle))
        ..add(Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Cell.descText(this.desc),
          ),
        ));
    } else {
      _bodyWidgets.add(Expanded(
        child: Text(title, style: AppStyles.TitleStyle),
      ));
    }

    /// 右箭头
    if (this.showArrow) {
      _bodyWidgets.add(_buildArrow());
    }

    final Widget _cell = Container(
      padding: EdgeInsets.all(CellPadding),
      decoration: BoxDecoration(
        border: _divider,
      ),
      child: Row(children: [
        /// left
        Container(
          padding: EdgeInsets.only(right: CellPadding),
          child:
              AvatarHelper.buildAvatar(avatar, CellAvatarSize, CellAvatarSize),
        ),

        /// right
        Expanded(
          child: Row(
            children: _bodyWidgets,
          ),
        )
      ]),
    );
    return _cell;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: _buildCore(this.iconPath, this.title, this.desc),
      onPressed: this.onPressed,
    );
  }

  /// 构建箭头
  Widget _buildArrow() {
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

  /// 按钮上的圆角文本标签控件
  /// * [content] 标签上的显示文本
  static Widget tag(final content) {
    return Container(
      height: 18.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 6.0),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
          color: const Color(AppColors.NewTagBg),
          borderRadius: BorderRadius.circular(10.0)),
      child: Text(content, style: AppStyles.NewTagTextStyle),
    );
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
