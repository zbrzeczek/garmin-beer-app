import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class CaloriesDelegate extends WatchUi.BehaviorDelegate {
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

    function onSelect() as Boolean {
        return true;
    }

    function onBack() as Boolean {
        return true;
    }

    function onNextPage() as Boolean {
        return true;
    }

    function onPreviousPage() as Boolean {
        return true;
    }
    
}