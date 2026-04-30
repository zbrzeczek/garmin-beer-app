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
        var selected = app.getSelected();

        var label;
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

        count = app.getDrink(selected);
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
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    public function prev(){
        var selected = app.getSelected();
        selected--;
        if (selected < 0){
            selected = 2;
        }
        Ui.requestUpdate();
    }

    public function next(){
        var selected = app.getSelected();
        selected++;

        if (selected > 2){
            selected = 0;
        }
        Ui.requestUpdate();
    }

}
