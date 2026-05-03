import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class PromilesCounterDelegate extends WatchUi.BehaviorDelegate {
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

        if (current < 0){ current = 1; }
        else if (current > 1) { current = 0; }

        app.setSelectedProperty(current);

        WatchUi.requestUpdate();
    }

    
}