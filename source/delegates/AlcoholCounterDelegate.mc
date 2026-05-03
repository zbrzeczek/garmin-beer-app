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

        var todayKey = getTodayKey();
        var savedDate = Application.Storage.getValue(AlcoholModel.DATE_PROPERTY) as String?;

        if (savedDate == null || savedDate != todayKey) {
            Application.Storage.setValue(AlcoholModel.DATE_PROPERTY, todayKey);
            for (var i = 0; i < AlcoholModel.getCountSize(); i++){
                Application.Storage.setValue(AlcoholModel.DATE_PROPERTY, 0);
            }
        }
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
        addDrink(1, app.getSelectedProperty());
        WatchUi.requestUpdate();

        return true;
    }

    function onBack() as Boolean {
        var sel = app.getSelectedProperty();

        if (getDrink(sel) > 0) {
            addDrink(-1, sel);
            WatchUi.requestUpdate();
        }
        return true;
    }

    function onNextPage() as Boolean {
        changeFace(1);
        return true;
    }

    function onPreviousPage() as Boolean {
        changeFace(-1);
        return true;
    }

    public function changeFace(num as Number) as Void {
        var current = app.getSelectedProperty();
        current += num;

        if (current < 0){ current = 2; }
        else if (current > 2) { current = 0; }

        app.setSelectedProperty(current);

        WatchUi.requestUpdate();
    }

    function getTodayKey() as String {
        var now = Time.now();
        var info = Gregorian.info(now, Time.FORMAT_SHORT);

        return Lang.format(
            "$1$-$2$-$3$",
            [
                info.year.format("%04d"),
                info.month.format("%02d"),
                info.day.format("%02d")
            ]
        );
    }
    
    function getDrink(type as Number) as Number {
        var value = Application.Storage.getValue(AlcoholModel.DATE_PROPERTY) as Number?;
        return value == null ? 0 : value;
    }

    function addDrink(amount as Number, type as Number) as Number {
        var nextCount = getDrink(type) + amount;
        Application.Storage.setValue(AlcoholModel.getCountKey(type), nextCount);
        return nextCount;
    }

}