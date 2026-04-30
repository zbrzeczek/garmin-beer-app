import Toybox.Lang;
import Toybox.WatchUi;

class AlcoholCounterMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        var app = getApp();

        if (item == :menu) {
            app.addDrink(1, 0);
        } else if (item == :add_shot) {
            app.addDrink(1, 1);
        } else if (item == :reset_today) {
            app.resetToday();
        }

        WatchUi.requestUpdate();
    }

}