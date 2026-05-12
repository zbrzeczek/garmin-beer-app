import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Application;

module AlcoholModel {
    const COUNT_SIZE = 3;
    const DAYS_BACK = 7;
    const SECONDS_PER_DAY = 24 * 60 * 60;

    function add(counts as Array, type as Number, amount as Number) as Array {
        counts[type] += amount;
        return counts;
    }

    function remove(counts as Array, type as Number, amount as Number) as Array {
        counts[type] -= amount;
        if (counts[type] < 0) { counts[type] = 0; }
        return counts;
    }

    function createEmpty() as Array {
        return [0, 0, 0];
    }

    function getTodayKey() as String {

        var now = Time.now();
        var info = Gregorian.info(now, Time.FORMAT_SHORT);

        return Lang.format(
            "$1$-$2$-$3$",
            [
                Lang.format("%04d", [info.year]),
                Lang.format("%02d", [info.month]),
                Lang.format("%02d", [info.day])
            ]
        );
    }

     function getLastDaysKeys() {

        var keys = [];

        for (var i = 0; i < DAYS_BACK; i++) {
            var date = getDateOffset(i);
            keys.add(date);
        }

        return keys;
    }

    function getDateOffset(daysBack as Number) {

        var now = Time.now();
        var duration = new Time.Duration(SECONDS_PER_DAY * daysBack);
        var then = Time.now().add(duration);

        var info = Gregorian.info(then, Time.FORMAT_SHORT);

        return Lang.format(
            "$1$-$2$-$3$",
            [
                Lang.format("%04d", [info.year]),
                Lang.format("%02d", [info.month]),
                Lang.format("%02d", [info.day])
            ]
        );
    }

    function getDayData(key as String) {
        var data = Application.Storage.getValue(key);
        return data == null ? [0,0,0] : data;
    }

}