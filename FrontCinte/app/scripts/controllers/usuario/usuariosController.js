
angular.module('Cinte')
    .controller('usuariosController', function (userService, $window, SUsuario, STipoIdentificacion, $scope) {


        var vm = this;

        //Contiene la lista de usuario
        vm.usuarios = [];

        vm.init = function () {

            STipoIdentificacion.query({}, function (dataTipoIdentificacion) {

                SUsuario.query({}, function (dataUsuarios) {

                    vm.usuarios = dataUsuarios;

                    //cruza los tipos de identificacion con los usuarios
                    _.each(vm.usuarios, function (u) {
                        u.tipoIdentificacion = _.find(dataTipoIdentificacion, function (ti) { return ti.idTipoIdentificacion == u.idTipoIdentificacion; });
                    });

                }, function (error) {
                    vm.manejarExcepciones(error);
                });
            }, function (error) {
                vm.manejarExcepciones(error);
            });
        }

        /**
         * Permite eliminar un usuario seleccionado
         */
        vm.eliminarUsuario = function (idUsuario, nombre) {

            bootbox.confirm({
                message: "Está seguro que desea eliminar el usuario '" + nombre + "'",
                buttons: {
                    confirm: {
                        label: 'Confirmar',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancelar',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {

                    if (result) {

                        SUsuario.remove({ IdUsuario: idUsuario }, function (dataUsuario) {

                            //Descarta el usuario eliminado
                            vm.usuarios = _.filter(vm.usuarios, function (u) { return u.idUsuario != idUsuario; });

                            //Actualiza la lista en el html
                            $scope.$apply();

                        }, function (error) {
                            vm.manejarExcepciones(error);
                        })
                    }
                }
            });

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