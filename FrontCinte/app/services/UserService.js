angular.module('Cinte')

    .service('userService', function ($rootScope) {

        var vm = this;

        //Contiene la tura relativa de la aplicación
        this.urlService = "https://localhost:44393/";

        vm.usuario = {};

        vm.logIn = false;

        /**
         * Inicia sesión 
         * @param {any} usuario nombre 
         * @param {any} contrasenia contraseña
         */
        vm.sesionIniciada = function (usuario) {

            if (usuario) {

                amplify.store.sessionStorage("user", usuario);

                vm.usuario = usuario;

                vm.logIn = true;
                $rootScope.logeado = true;
            }
        };

        /**
         *Carga los datos del amplify
         */
        vm.sesionEstaIniciada = function () {

            var user = amplify.store.sessionStorage("user");

            if (user) {
                vm.usuario = user;
                vm.logIn = true;
                $rootScope.logeado = true;
            }
        };

        /**
         *Cierra sesión del usuario
         */
        vm.cerrarSesion = function () {

            amplify.store.sessionStorage("user", null);

            vm.usuario = {};

            vm.logIn = false;
            $rootScope.logeado = false;
        };

    });
