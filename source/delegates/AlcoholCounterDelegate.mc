import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.System;
import Toybox.WatchUi;

class AlcoholCounterDelegate extends WatchUi.BehaviorDelegate {
    var app;

    function initialize() {
        BehaviorDelegate.initialize();
        app = getApp();

        // var todayKey = getTodayKey();
        // var savedDate = Application.Storage.getValue(todayKey);

        // if (savedDate == null) {
        //     var baseAlcoCount = [0, 0, 0];
        //     alcoCount = baseAlcoCount;
        //     Application.Storage.setValue(todayKey, alcoCount);
        //     // for (var i = 0; i < AlcoholModel.getCountSize(); i++){
        //     //     Application.Storage.setValue(AlcoholModel.getCountKey(i), 0);
        //     // }
        // }
        // else{
        //     alcoCount = Application.Storage.getValue(todayKey);
        // }
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
        app.addDrink(1);
        System.println("adding drink");
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() as Boolean {
        app.removeDrink(1);
        WatchUi.requestUpdate();
        System.println("removing drink");
        return true;
    }

    function onNextPage() as Boolean {
        app.changeFace(1, 3);
        WatchUi.requestUpdate();
        return true;
    }

    function onPreviousPage() as Boolean {
        app.changeFace(-1, 3);
        WatchUi.requestUpdate();
        return true;
    }
}