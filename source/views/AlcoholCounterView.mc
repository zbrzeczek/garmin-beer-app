import Toybox.Graphics;
import Toybox.System;
using Toybox.WatchUi as Ui;

class AlcoholCounterView extends Ui.View {
    var app;
    var bmpDict = {
		0 => Rez.Drawables.beer,
		1 => Rez.Drawables.shot,
		2 => Rez.Drawables.drink};

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

        //Call the parent onUpdate function to redraw the layout
        var selected = app.getSelectedProperty();

        var label = " ";
        var count;

        if(selected == 0){
            label = "Beer";
        }
        else if(selected == 1){
            label = "Shot";
        }
        else{ 
            label = "Drink";
        }

        count = Application.Storage.getValue(AlcoholModel.getCountKey(selected));
        if (count == null) { Application.Storage.setValue(AlcoholModel.getCountKey(selected), 0);}
        var image;
		var str = "";
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();
		str = label + ": " + count;

		image = Ui.loadResource(bmpDict[selected]);

        dc.drawBitmap(
            screenWidth / 2 - image.getWidth()/2,                // Center X
            screenHeight / 2 - image.getHeight()/2 - 20,
            image);
        dc.drawText(
            screenWidth / 2,                // Center X
            screenHeight / 2 + image.getHeight()/2,               // Center Y
            Graphics.FONT_MEDIUM,             // Font
            str,                    // Text
            Graphics.TEXT_JUSTIFY_CENTER      // Justification
        );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. Th is includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
