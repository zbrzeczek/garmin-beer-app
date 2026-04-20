import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;
import Toybox.System;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class AlcoholCounterApp extends Application.AppBase {
    var selected = 0;
    const COUNT_PROPERTY = ["dailyBeerCount",  
                            "dailyShotCount",
                            "dailyDrinkCount"];
    const DATE_PROPERTY = "dailyAlcoholDate";

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        ensureTodayState();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new AlcoholCounterView(), new AlcoholCounterDelegate() ];
    }

    function ensureTodayState() as Void {
        var todayKey = getTodayKey();
        var savedDate = getProperty(DATE_PROPERTY) as String?;

        if (savedDate == null || savedDate != todayKey) {
            setProperty(DATE_PROPERTY, todayKey);
            for (var i = 0; i < COUNT_PROPERTY.size(); i++){
                setProperty(COUNT_PROPERTY[i], 0);
            }
        }
    }

    public function changeFace(num as Number) as Void {
        selected += num;

        if (selected < 0){ selected = 2; }
        else if (selected > 2) { selected = 0; }
        WatchUi.requestUpdate();
        System.println(selected);
    }

    function getDrink(type as Number) as Number {
        var value = getProperty(COUNT_PROPERTY[type]) as Number?;
        return value == null ? 0 : value;
    }

    function addDrink(amount as Number, type as Number) as Number {
        var nextCount = getDrink(type) + amount;
        System.println(nextCount);
        setProperty(COUNT_PROPERTY[type], nextCount);
        return nextCount;
    }

    function resetToday() as Void {
        setProperty(DATE_PROPERTY, getTodayKey());
        for (var i = 0; i < COUNT_PROPERTY.size(); i++){
            setProperty(COUNT_PROPERTY[i], 0);
        }
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

    function getSelected() {
        return selected;
    }
}

function getApp() as AlcoholCounterApp {
    return Application.getApp() as AlcoholCounterApp;
}