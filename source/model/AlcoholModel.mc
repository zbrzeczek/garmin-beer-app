import Toybox.Lang;

module AlcoholModel {
    const COUNT_PROPERTY = [
        "dailyBeerCount",
        "dailyShotCount",
        "dailyDrinkCount"
    ];

    const DATE_PROPERTY = "dailyAlcoholDate";

    function getCountKey(type as Number) {
        return COUNT_PROPERTY[type];
    }

    function getCountSize() as Number {
        return COUNT_PROPERTY.size();
    }

}