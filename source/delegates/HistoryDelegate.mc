import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class HistoryDelegate extends WatchUi.BehaviorDelegate {
    var app;

    function initialize() {
        BehaviorDelegate.initialize();
        app = getApp();
    }

    function onMenu() as Boolean {
        System.println("Menu");
        WatchUi.pushView(
            new Rez.Menus.MainMenu(), 
            new AlcoholCounterMenuDelegate(), 
            WatchUi.SLIDE_UP);
        return true;
    }

    function onBack() as Boolean {
        app.route();
        return true;
    }
}