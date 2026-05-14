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

        var barWidth = screenW/16+screenW/64;
        var spacing = screenW/32;

        var bottomHeight = screenH/4 + 5;
        var maxHeight = screenH - bottomHeight*2;

        // find max value for scaling
        var maxValue = 1;

        var values = [];
        var dates = [];

        for (var i = 0; i < keys.size(); i++) {
            // wstawianie numerku do skali
            var day = keys[i];
            var index = day.find("-");

            while (index != null) {
                day = day.substring(index + 1, day.length());
                index = day.find("-");
            }

            dates.add(day);

            // obliczanie wartosci promili i maxa do skali
            var data = AlcoholModel.getDayData(keys[i]);
            var score = getAlcoholScore(data);
            values.add(score);

            if (score > maxValue) {
                maxValue = score;
            }
        }

        var x = screenW/8;

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(x, bottomHeight+maxHeight, 7*barWidth+6*spacing, 3);
        // draw bars
        for (var i = 0; i < values.size(); i++) {
            var value = values[i];

            var height = (value / maxValue) * maxHeight;
            // x = i * (barWidth + spacing);
            var y = bottomHeight + (maxHeight - height);

            // bar
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(x, y, barWidth, height);
            // label (day index)
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                x + barWidth/2,
                screenH - bottomHeight+ 5,
                Graphics.FONT_XTINY,
                dates[i],
                Graphics.TEXT_JUSTIFY_CENTER
            );

            x += barWidth + spacing;

        }
    }

    function getAlcoholScore(data as Array) as Number {
        System.println("2");
        System.println(data[0] * 1 + data[1] * 2 + data[2] * 1.5);
        return data[0] * 1 + data[1] * 2 + data[2] * 1.5;
    }

}
