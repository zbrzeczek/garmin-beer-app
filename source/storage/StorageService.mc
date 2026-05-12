import Toybox.Application;
import Toybox.Lang;

module StorageService {

    function load(key as String) {
        return Application.Storage.getValue(key);
    }

    function save(key as String, value) {
        Application.Storage.setValue(key, value);
    }
}