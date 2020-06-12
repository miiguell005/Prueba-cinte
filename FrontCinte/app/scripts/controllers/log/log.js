
angular.module('Cinte')
    .controller('logController', function (userService, $window, SLog) {
        
        var vm = this;

        //Contiene todos los registros de log almacenasdos en la base de datos
        vm.logs = [];

        vm.init = function () {

            SLog.query({}, function (dataLogs) {

                vm.logs = dataLogs;

            }, function (error) {
                console.log(error);
            });
        }
        
        vm.irAtras = function () {
            $window.history.back();
        }

        vm.init();
    });