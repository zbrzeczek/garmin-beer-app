import Toybox.Lang;
import Toybox.WatchUi;

class AlcoholCounterMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        var app = getApp();
        

        if (item == :main) {
            app.setSelectedMenu(0);
        } 
        else if (item == :promiles) {
            app.setSelectedMenu(1);
        } 
        else if (item == :history) {
            app.setSelectedMenu(2);
        } 
        else if (item == :calories) {
            app.setSelectedMenu(3);
        } 

        WatchUi.popView(WatchUi.SLIDE_DOWN);

        app.route();
    }

}