import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class AlcoholCounterDelegate extends WatchUi.BehaviorDelegate {
    var app;
    function initialize() {
        BehaviorDelegate.initialize();
        app = getApp();
    }

    // function onMenu() as Boolean {
    //     System.println("Menu");
    //     WatchUi.pushView(
    //         new Rez.Menus.MainMenu(), 
    //         new AlcoholCounterMenuDelegate(), 
    //         WatchUi.SLIDE_UP);
    //     return true;
    // }

    function onSelect() as Boolean {
        app.addDrink(1, app.getSelected());
        WatchUi.requestUpdate();

        return true;
    }

    function onBack() as Boolean {
        if (app.getDrink(app.getSelected()) > 0) {
            System.println("Remove drink ");
            app.addDrink(-1, app.getSelected());
            WatchUi.requestUpdate();
        }
        return true;
    }

    function onNextPage() as Boolean {
        app.changeFace(1);
        return true;
    }

    function onPreviousPage() as Boolean {
        app.changeFace(-1);
        return true;
    }
    
}