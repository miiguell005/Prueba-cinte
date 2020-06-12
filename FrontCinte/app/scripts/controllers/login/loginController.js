
angular.module('Cinte')
    .controller('loginController', function (userService, $window, SUsuario) {


        var vm = this;

        vm.usuario = {};

        //Valida si el usuario pudo ingresar o no
        vm.usuarioValido = true;

        vm.init = function () {
            userService.sesionEstaIniciada();

            console.log("Hola mundo");
        }

        vm.login = function () {

            if (!vm.usuario.numeroIdentificacion || !vm.usuario.contrasenia)
                return vm.manejarExcepciones(null, "Es obligatorio ingresar el número de identificación y la contraseña");

            SUsuario.login({ numeroIdentificacion: vm.usuario.numeroIdentificacion, contrasenia: vm.usuario.contrasenia}, function (dataResult) {

                userService.sesionIniciada(dataResult);
                $window.location.href = "#!triqui";

            }, function (error) {
                vm.manejarExcepciones(error);
            })
        }

        /**
         * Controla el mensaje de error
         * @param {any} error
         */
        vm.manejarExcepciones = function (error, mensaje) {

            if (error && error.data.error)
                toastr.error(error.data.error);

            if (mensaje)
                toastr.error(mensaje);

            console.log("Error", error);
        }

        vm.init();
    });