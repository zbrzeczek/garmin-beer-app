import Toybox.Graphics;
import Toybox.System;
using Toybox.WatchUi as Ui;
import Toybox.Lang;

class HistoryView extends Ui.View {
     var app;

    function initialize() {
        View.initialize();
        app = getApp();
    }

    function onUpdate(dc as Dc) {

        dc.clear();

        var keys = AlcoholModel.getLastDaysKeys();

        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        var barWidth = 20;
        var spacing = 5;

        var maxHeight = screenH - 40;

        // find max value for scaling
        var maxValue = 1;

        var values = [];

        for (var i = 0; i < keys.size(); i++) {
            var data = AlcoholModel.getDayData(keys[i]);
            var score = getAlcoholScore(data);
            values.add(score);

            if (score > maxValue) {
                maxValue = score;
            }
        }

        // draw bars
        for (var i = 0; i < values.size(); i++) {

            var value = values[i];

            var height = (value / maxValue) * maxHeight;

            var x = 10 + i * (barWidth + spacing);
            var y = screenH - height;

            // bar
            dc.fillRectangle(x, y, barWidth, height);

            // label (day index)
            dc.drawText(
                x,
                screenH - 10,
                Graphics.FONT_TINY,
                i,
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }
    }

    function getAlcoholScore(data as Array) as Number {
        return data[0] * 1 + data[1] * 2 + data[2] * 1.5;
    }

}
