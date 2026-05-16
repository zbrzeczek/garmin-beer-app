import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class AlcoholCounterApp extends Application.AppBase {
    private var selectedMenu = 0;
    private var selectedProperty = 0;
    private var alcoCount;
    private var grams = 0.0;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        alcoCount = AlcoholModel.getDayData(AlcoholModel.getTodayKey());
        grams = Application.Storage.getValue("grams") == null ? 0.0 : Application.Storage.getValue("grams");

    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new AlcoholCounterView(), new AlcoholCounterDelegate() ];
    }

    function getSelectedMenu() {
        return selectedMenu;
    }

    function setSelectedMenu(v as Number) {
        selectedMenu = v;
    }

    function getSelectedProperty() {
        return selectedProperty;    
    }

    function setSelectedProperty(v as Number) {
        selectedProperty = v;
    }

    function route() {
        selectedProperty = 0;
        var view;
        var delegate;

        if (selectedMenu == 0) {
            view = new AlcoholCounterView();
            delegate = new AlcoholCounterDelegate();
        }
        else if (selectedMenu == 1) {
            view = new PromilesCounterView();
            delegate = new PromilesCounterDelegate();
        }
        else if (selectedMenu == 2) {
            view = new HistoryView();
            delegate = new HistoryDelegate();
        }
        else {
            view = new CaloriesView();
            delegate = new CaloriesDelegate();
        }

        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function addDrink(amount as Number) {
        var selectedDrink = getSelectedProperty();
        alcoCount = AlcoholModel.add(alcoCount, selectedDrink, amount);
        grams += AlcoholModel.getGrams(selectedDrink);
    }

    function removeDrink(amount as Number) {
        var selectedDrink = getSelectedProperty();
        alcoCount = AlcoholModel.remove(alcoCount, selectedDrink, amount);
        grams -= AlcoholModel.getGrams(selectedDrink);
    }

    function getDrink(type as Number) {
        return alcoCount[type];
    }   

    function getAlcoCount() {
        return alcoCount;
    }

    public function getGrams() as Float {
        return grams;
    }

    function changeFace(dir as Number, faceSize as Number) {
        selectedProperty += dir;

        if (selectedProperty < 0) { selectedProperty = faceSize -1 ; }
        else if (selectedProperty > faceSize - 1) { selectedProperty = 0; }
    }

}


function getApp() as AlcoholCounterApp {
    return Application.getApp() as AlcoholCounterApp;
}
