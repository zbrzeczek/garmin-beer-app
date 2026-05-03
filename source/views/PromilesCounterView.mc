import Toybox.Graphics;
import Toybox.System;
import Toybox.UserProfile;
using Toybox.WatchUi as Ui;

class PromilesCounterView extends Ui.View {
    var app;
    var promiles = 0.0;
    var hours = 0.0;
    var profile;

    function initialize() {
        View.initialize();
        // Get the user profile
        profile = UserProfile.getProfile();
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
        recalculatePromiles();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        //Call the parent onUpdate function to redraw the layout
        var selected = app.getSelectedProperty();

        var title;
        var number;
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();

        if(selected == 0){
            title = "Promiles: ";
            number = promiles.format("%.1f") + " ‰";
        }
        else{
            dc.drawText(
                screenWidth / 2,                // Center X
                screenHeight / 2- 60,
                Graphics.FONT_SMALL, 
                "Predicted time", 
                Graphics.TEXT_JUSTIFY_CENTER );
            title = "to sober up: ";
            number = hours.format("%.1f") + " h";
        }

        dc.drawText(
            screenWidth / 2,                // Center X
            screenHeight / 2- 20,
            Graphics.FONT_SMALL, 
            title, 
            Graphics.TEXT_JUSTIFY_CENTER );
        dc.drawText(
            screenWidth / 2,                // Center X
            screenHeight / 2 + 20,               // Center Y
            Graphics.FONT_MEDIUM,             // Font
            number,                    // Text
            Graphics.TEXT_JUSTIFY_CENTER      // Justification
        );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    private function recalculatePromiles(){
        var beerGrams = Application.Storage.getValue(AlcoholModel.getCountKey(0)) * 500 * 0.05 * 0.8; 
        var shotDrinkGrams = (Application.Storage.getValue(AlcoholModel.getCountKey(1)) 
                            + Application.Storage.getValue(AlcoholModel.getCountKey(2)) * 2) * 50 * 0.40 * 0.8; // here it takes that one shot is 50 ml of 40% alcohol and drink is 100ml 40% alc
        
        var totalAlcohol = beerGrams + shotDrinkGrams;
        
        var coeff = profile.gender == UserProfile.GENDER_FEMALE ? 0.6 : 0.7;
        var weight = profile.weight / 1000.0;

        promiles = totalAlcohol / (weight * coeff);
        hours = promiles / 0.15;
    }
}
