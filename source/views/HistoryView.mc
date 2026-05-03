import Toybox.Graphics;
import Toybox.System;
using Toybox.WatchUi as Ui;

class HistoryView extends Ui.View {
    var app;

    function initialize() {
        View.initialize();
        app = getApp();
    }

    // // // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.clear();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        dc.drawText(
            80,                // Center X
            120,               // Center Y
            Graphics.FONT_MEDIUM,             // Font
            "history",                    // Text
            Graphics.TEXT_JUSTIFY_CENTER      // Justification
        );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
