---
title: Snipaste使用文档
date: 2021-11-13 15:14:29
tags:
categories:
- 开发工具
---



> Snipaste使用文档-官网链接  [https://docs.snipaste.com/zh-cn/](https://docs.snipaste.com/zh-cn/)



<!-- more -->



# [基础操作](https://docs.snipaste.com/zh-cn/getting-started?id=基础操作)

Snipaste 是一个简单但强大的`贴图`工具，同时也可以执行`截屏`、`标注`等功能。

## [截屏](https://docs.snipaste.com/zh-cn/getting-started?id=截屏)

#### [开始截图](https://docs.snipaste.com/zh-cn/getting-started?id=开始截图)

- 快捷键（默认为 F1）
- 鼠标左键 单击托盘图标

#### [取消当前截图](https://docs.snipaste.com/zh-cn/getting-started?id=取消当前截图)

- 任何时刻按 Esc
- 任何时刻点击工具条上的关闭按钮
- 非编辑状态下，按下鼠标右键
- 任何时刻有其他程序的窗口被激活
  - 可在选项窗口关闭此行为

#### [回放截图记录](https://docs.snipaste.com/zh-cn/getting-started?id=回放截图记录)

- 进入截图后，按 , 或 .
- 只有 `成功的截图` 才会出现在截图记录中
- 截图记录的最大数量，可在选项窗口中设置

#### [逐像素控制光标移动](https://docs.snipaste.com/zh-cn/getting-started?id=逐像素控制光标移动)

- W A S D

#### [像素级控制截取区域](https://docs.snipaste.com/zh-cn/getting-started?id=像素级控制截取区域)

- 按住 鼠标左键 + W A S D（**推荐**，可实现移动、扩大、缩小区域）
- 移动区域： ↑ ← ↓ →
- 扩大区域：Ctrl + ↑ ← ↓ →
- 缩小区域：Shift + ↑ ← ↓ →

#### [放大镜](https://docs.snipaste.com/zh-cn/getting-started?id=放大镜)

- 放大镜会在合理的时机自动出现和隐藏，如果你需要它的时候它没在，请按 Alt 召唤它

#### [取色](https://docs.snipaste.com/zh-cn/getting-started?id=取色)

- 当放大镜可见的时候，按下 C 可复制该像素点的颜色值（RGB/Hex）。之后可以 F3 将它贴出，或者 Ctrl + V 贴到其他程序里
- 可按下 Shift 来切换颜色格式

## [标注](https://docs.snipaste.com/zh-cn/getting-started?id=标注)

#### [手动结束当前图案](https://docs.snipaste.com/zh-cn/getting-started?id=手动结束当前图案)

- 单击 鼠标右键

#### [如何重新编辑已经结束的图案](https://docs.snipaste.com/zh-cn/getting-started?id=如何重新编辑已经结束的图案)

- 按 撤销 **直到你需要编辑的图案已经消失**，再按 重做
- 将来会支持直接的二次编辑

#### [画板里没有我想要的颜色](https://docs.snipaste.com/zh-cn/getting-started?id=画板里没有我想要的颜色)

- 请点击那个大的颜色按钮

#### [调整画笔宽度](https://docs.snipaste.com/zh-cn/getting-started?id=调整画笔宽度)

- 鼠标滚轮
- 1 2

#### [调整文字大小](https://docs.snipaste.com/zh-cn/getting-started?id=调整文字大小)

- 拖动文字框四角

#### [旋转文字](https://docs.snipaste.com/zh-cn/getting-started?id=旋转文字)

- 拖动文字框上方的小圆点

#### [将旋转过的文字重新变为水平的](https://docs.snipaste.com/zh-cn/getting-started?id=将旋转过的文字重新变为水平的)

- 按住 Shift 再拖动文字框四角

## [贴图](https://docs.snipaste.com/zh-cn/getting-started?id=贴图)

所谓**贴图**，是指将系统剪贴板中的内容转化成图片，然后作为窗口置顶显示。

所以，能否贴出来、贴出来的是什么，取决于系统剪贴板中的内容。

#### [如何贴图](https://docs.snipaste.com/zh-cn/getting-started?id=如何贴图)

- 快捷键（默认 F3）
- 鼠标中键 单击托盘图标
- 截图时选择 `贴到屏幕`

#### [什么时候可以贴图](https://docs.snipaste.com/zh-cn/getting-started?id=什么时候可以贴图)

- 剪贴板中复制有图像
- 剪贴板中复制有颜色信息
- RGB：3 个 0~255 的整数或 3 个 0~1 的小数
- HEX：以 # 开头的合理色值
- 剪贴板中有文字
- 纯文本
- HTML 文本
- 剪贴板中有文件路径（指复制了文件）
- 文件是图片，会把图像贴出
  - 图像贴出后再贴，会把文件路径当做文本贴出
- 文件不是图片，会把文件路径当做文本贴出
  - 在选项对话框中可以选择不要将文件路径转化成图片

#### [旋转贴图](https://docs.snipaste.com/zh-cn/getting-started?id=旋转贴图)

- 1 2

#### [水平/垂直翻转](https://docs.snipaste.com/zh-cn/getting-started?id=水平垂直翻转)

- 3 4

#### [缩放贴图](https://docs.snipaste.com/zh-cn/getting-started?id=缩放贴图)

- 滑动滚轮
- \+ -
- 拖动贴图窗口的边缘

#### [设置贴图透明度](https://docs.snipaste.com/zh-cn/getting-started?id=设置贴图透明度)

- Ctrl + 滑动滚轮
- Ctrl + + -

#### [使贴图鼠标穿透](https://docs.snipaste.com/zh-cn/getting-started?id=使贴图鼠标穿透)

- 前往 `首选项` - `控制` - `全局快捷键` - `鼠标穿透开关` 为其设置快捷键
- 按键触发后，会切换光标所在位置的贴图的鼠标穿透状态
  - 如果没有贴图位于光标之下，则取消所有贴图的鼠标穿透状态

#### [重置贴图为 100% 大小 及 100% 不透明](https://docs.snipaste.com/zh-cn/getting-started?id=重置贴图为-100-大小-及-100-不透明)

- 中键单击
  - 可自定义

#### [缩略图模式](https://docs.snipaste.com/zh-cn/getting-started?id=缩略图模式)

- Shift

   

  +

   

  左键双击

  - 可自定义

#### [关闭单张贴图](https://docs.snipaste.com/zh-cn/getting-started?id=关闭单张贴图)

- Esc/左键双击

  - 可自定义

- Ctrl + W

- 被关闭的贴图，可再次被贴出，除非超过“可被恢复的已关闭贴图数”

  - 如何恢复：按下贴图键一次或多次

- “可被恢复的已关闭贴图数”可在选项对话框设置（默认设置/建议是 **1**）

- 当你觉得自己可能不需要这张贴图了，**关闭**贴图操作是你的首选，因为它同时提供了一种后悔药，防止你刚把贴图关闭就后悔了，想找回来

- **如果你并不希望这张贴图消失，而只是想暂时隐藏它，那么你不应该关闭它**，而是使用“隐藏所有贴图”，或者把它移动到另一个贴图分组

- 关闭 Snipaste 时，如果已关闭的贴图没有被显示出来，它们会被自动销毁（即使未达到最大计数）

#### [隐藏所有贴图](https://docs.snipaste.com/zh-cn/getting-started?id=隐藏所有贴图)

- 快捷键（默认为 Shift + F3）
- 再次按下快捷键将显示所有贴图
- 注意，隐藏所有贴图与上面提到的关闭单张贴图**是完全不同的行为**，也就是说，隐藏所有贴图不会影响对已关闭贴图的计数
- 被隐藏的贴图不会被自动销毁，即使关闭 Snipaste 时它们都是隐藏状态

#### [销毁贴图](https://docs.snipaste.com/zh-cn/getting-started?id=销毁贴图)

- Shift + Esc / 在贴图窗口的右键菜单中选 销毁
- 当你确认自己不可能再需要这张贴图，并且不希望这张贴图留下任何痕迹，才建议使用**销毁**
- 被销毁的贴图，不会再通过贴图键被恢复出来
  - 可是再按贴图键，还是贴出来了？
    - 这是因为它还在你剪贴板里，Snipaste 是把它当做新的内容贴了出来
- 如果希望销毁当前分组的所有贴图，关闭该贴图分组即可

#### [放大镜](https://docs.snipaste.com/zh-cn/getting-started?id=放大镜-1)

- 和截图时一样，按住 Alt 可唤出放大镜

#### [取色](https://docs.snipaste.com/zh-cn/getting-started?id=取色-1)

- 和截图时一样，放大镜可见时按 C 可复制当前像素点的颜色值

