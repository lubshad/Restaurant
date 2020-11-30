class TabMenuItem {
  final String title;
  final TabMenuInfo tabMenuInfo;

  TabMenuItem(this.tabMenuInfo, {this.title});
}

enum TabMenuInfo { Deals, Menu, Sides, Desserts, Drinks }

List<TabMenuItem> tabMenuItems = [
  TabMenuItem(TabMenuInfo.Deals, title: "Deals"),
  TabMenuItem(TabMenuInfo.Menu, title: "Menu"),
  TabMenuItem(TabMenuInfo.Sides, title: "Sides"),
  TabMenuItem(TabMenuInfo.Desserts, title: "Desserts"),
  TabMenuItem(TabMenuInfo.Drinks, title: "Drinks"),
];
