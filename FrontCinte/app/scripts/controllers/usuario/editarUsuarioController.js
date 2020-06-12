
angular.module('Cinte')
    .controller('editarUsuarioController', function (userService, $window, SUsuario, $routeParams, STipoIdentificacion) {


        var vm = this;
        console.log($window);
        //Titulo de la pagina
        vm.titulo = "Crear usuario";

        //Contiene la información del usuario
        vm.usuario = {};

        vm.tiposIdentificacion = [];

        vm.guardarOprimido = false;

        /**
         * Se ejecuta la iniciar el controller
         */
        vm.init = function () {


            STipoIdentificacion.query({}, function (dataTipoIdentificacion) {

                //Contiene los tipos de identificacion posibles para seleccionar
                vm.tiposIdentificacion = dataTipoIdentificacion;

                //Para editar una usuario
                if ($routeParams.idUsuario != "0") {

                    vm.titulo = "Editar usuario";

                    SUsuario.getUsuario({ idUsuario: $routeParams.idUsuario }, function (dataUsuario) {

                        vm.usuario = dataUsuario;
                        console.log("??", dataUsuario);

                    }, function (error) {
                        vm.manejarExcepciones(error)
                    });
                }

                //Para crear un usuario
                else {

                }

            }, function (error) {
                vm.manejarExcepciones(error)
            });
        }

        /**
         * Guardar usuario
         */
        vm.guardar = function () {

            vm.guardarOprimido = true;

            //No permite continuar hasta que se haya llenado todos los campos que son obligatorios
            if (!vm.usuario.idUsuario && (!vm.usuario.repetirContrasenia || !vm.usuario.contrasenia ||
                vm.usuario.repetirContrasenia != vm.usuario.contrasenia))
                return;

            if (!vm.usuario.idTipoIdentificacion || !vm.usuario.nombre || !vm.usuario.apellido
                || !vm.usuario.numeroIdentificacion || !vm.usuario.correo)
                return;

            //Crea el usuario
            if (!vm.usuario.idUsuario) {

                SUsuario.post({}, vm.usuario, function (dataUsuario) {

                    //Actualiza los datos del usuario
                    vm.titulo = "Editar usuario";
                    vm.usuario = dataUsuario;
                    toastr.success("El usuario ha sido creado exitosamente");

                }, function (error) {
                    vm.manejarExcepciones(error)
                });
            }

            //Edita el usaurio
            else {
                SUsuario.put({ IdUsuario: vm.usuario.idUsuario }, vm.usuario, function (dataUsuario) {

                    //Actualiza el usuario
                    vm.usuario = dataUsuario;
                    toastr.success("El usuario ha sido editado exitosamente");

                }, function (error) {
                    vm.manejarExcepciones(error)
                });
            }
        }

        /**
         * Controla el mensaje de error
         * @param {any} error
         */
        vm.manejarExcepciones = function (error) {

            if (error.data.error)
                toastr.error(error.data.error);

            console.log("Error", error);
        }

        vm.irAtras = function () {
            $window.history.back();
        }

        vm.init();
    });