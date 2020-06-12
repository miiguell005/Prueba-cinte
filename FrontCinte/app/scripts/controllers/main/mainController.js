
angular.module('Cinte')
    .controller('mainController', function (userService, $window, $rootScope) {


        var vm = this;

        $rootScope.logeado = false;
                
        vm.init = function () {

            userService.sesionEstaIniciada();

            $rootScope.logeado = userService.logIn

            if (!$rootScope.logeado &&
                ($window.location.hash != "#!/usuario/0" || $window.location.hash != "#!/login"))
                $window.location.href = "#!login";

            else if ($rootScope.logeado && ($window.location.hash == "#!/login" || $window.location.hash == "#!/"))
                    $window.location.href = "#!triqui";
        }

        /**
         * 
         */
        vm.logOut = function () {

            userService.cerrarSesion();

            $window.location.href = "#!login";
        }

        vm.init();
    });