import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class AlcoholCounterApp extends Application.AppBase {
    var selectedMenu = 0;
    var selectedProperty = 0;
    var view;
    var delegate;

    function initialize() {
        view = new AlcoholCounterView();
        delegate = new AlcoholCounterDelegate();
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new AlcoholCounterView(), new AlcoholCounterDelegate() ];
    }

    function getSelectedMenu() {
        return selectedMenu;
    }

    function setSelectedMenu(v as Number) {
        selectedMenu = v;
    }

    function getSelectedProperty() {
        return selectedProperty;    
    }

    function setSelectedProperty(v as Number) {
        selectedProperty = v;
    }

    function route() {
        selectedProperty = 0;

        if (selectedMenu == 0) {
            view = new AlcoholCounterView();
            delegate = new AlcoholCounterDelegate();
        }
        else if (selectedMenu == 1) {
            view = new PromilesCounterView();
            delegate = new PromilesCounterDelegate();
        }
        else if (selectedMenu == 2) {
            view = new HistoryView();
            delegate = new HistoryDelegate();
        }
        else if (selectedMenu == 3) {
            view = new CaloriesView();
            delegate = new CaloriesDelegate();
        }

        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
    }
}


function getApp() as AlcoholCounterApp {
    return Application.getApp() as AlcoholCounterApp;
}

// class AlcoholCounterApp extends Application.AppBase {
//     var selectedMainWindow = 0;
//     var selectedMenu = 0;
//     const COUNT_PROPERTY = ["dailyBeerCount",  
//                             "dailyShotCount",
//                             "dailyDrinkCount"];
//     const DATE_PROPERTY = "dailyAlcoholDate";

//     function initialize() {
//         AppBase.initialize();
//     }

//     // onStart() is called on application start up
//     function onStart(state as Dictionary?) as Void {
//         ensureTodayState();
//     }

//     // onStop() is called when your application is exiting
//     function onStop(state as Dictionary?) as Void {
//     }

//     // Return the initial view of your application here
//     function getInitialView() as [Views] or [Views, InputDelegates] {
//         return [ new AlcoholCounterView(), new AlcoholCounterDelegate() ];
//     }

//     function ensureTodayState() as Void {
//         var todayKey = getTodayKey();
//         var savedDate = getProperty(DATE_PROPERTY) as String?;

//         if (savedDate == null || savedDate != todayKey) {
//             setProperty(DATE_PROPERTY, todayKey);
//             for (var i = 0; i < COUNT_PROPERTY.size(); i++){
//                 setProperty(COUNT_PROPERTY[i], 0);
//             }
//         }
//     }

//     public function changeFace(num as Number, maxPages as Number) as Void {
//         selectedMainWindow += num;

//         if (selectedMainWindow < 0){ selectedMainWindow = maxPages - 1; }
//         else if (selectedMainWindow > maxPages - 1) { selectedMainWindow = 0; }
//         WatchUi.requestUpdate();
//         System.println(selectedMainWindow);
//     }

//     public function route() as Void {
//         if (selectedMenu == 0) {
//             WatchUi.switchToView(
//                 new AlcoholCounterView(),
//                 new AlcoholCounterDelegate(),
//                 WatchUi.SLIDE_IMMEDIATE
//             );
//         }
//         else if (selectedMenu == 1) {
//             WatchUi.switchToView(
//                 new PromilesCounterView(),
//                 new PromilesCounterDelegate(),
//                 WatchUi.SLIDE_IMMEDIATE
//             );
//         }
//         else if (selectedMenu == 2) {
//             WatchUi.switchToView(
//                 new HistoryView(),
//                 new HistoryDelegate(),
//                 WatchUi.SLIDE_IMMEDIATE
//             );
//         }
//         else if (selectedMenu == 3) {
//             WatchUi.switchToView(
//                 new CaloriesView(),
//                 new CaloriesDelegate(),
//                 WatchUi.SLIDE_IMMEDIATE
//             );
//         }
//     }

//     function getDrink(type as Number) as Number {
//         var value = getProperty(COUNT_PROPERTY[type]) as Number?;
//         return value == null ? 0 : value;
//     }

//     function addDrink(amount as Number, type as Number) as Number {
//         var nextCount = getDrink(type) + amount;
//         System.println(nextCount);
//         setProperty(COUNT_PROPERTY[type], nextCount);
//         return nextCount;
//     }

//     function resetToday() as Void {
//         setProperty(DATE_PROPERTY, getTodayKey());
//         for (var i = 0; i < COUNT_PROPERTY.size(); i++){
//             setProperty(COUNT_PROPERTY[i], 0);
//         }
//     }

//     function getTodayKey() as String {
//         var now = Time.now();
//         var info = Gregorian.info(now, Time.FORMAT_SHORT);

//         return Lang.format(
//             "$1$-$2$-$3$",
//             [
//                 info.year.format("%04d"),
//                 info.month.format("%02d"),
//                 info.day.format("%02d")
//             ]
//         );
//     }

//     function getSelectedMain() {
//         return selectedMainWindow;
//     }

//     public function setSelectedMenu(sel as Number) as Void {
//         selectedMenu = sel;
//     }

//     public function getSelectedMenu() as Number {
//         return selectedMenu;
//     }

// }