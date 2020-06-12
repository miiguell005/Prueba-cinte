using Prueba_Cinte.Context;
using Prueba_Cinte.Context.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Prueba_Cinte.Modulo
{
    public class LogModulo
    {
        private readonly AppDbContext _context;

        public LogModulo(AppDbContext Context)
        {
            _context = Context;
        }

        /// <summary>
        //Verifica si hay cambios entre los dos objetos
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="objOld"></param>
        /// <param name="objNew"></param>
        /// <param name="propiedadesAValidar"></param>
        /// <returns></returns>
        public string HayCambios<T>(T objOld, T objNew, string propiedadesOmitir = "")
        {
            var propiedades = propiedadesOmitir.Split(',');

            string antiguo = "";
            string nuevo = "";

            //Verifica los dos objetos y encuentra los campos que se modificaron
            foreach (var key in objNew.GetType().GetProperties())
                if (key.GetValue(objOld) != null && key.GetValue(objNew) == null ||
                    key.GetValue(objOld) == null && key.GetValue(objNew) != null ||
                    (key.GetValue(objOld) != null && key.GetValue(objNew) != null && !key.GetValue(objOld).Equals(key.GetValue(objNew))))

                    if (propiedades.Length == 0 || (propiedades.Length == 1 && propiedades[0] == "") || !propiedades.Contains(key.Name))
                    {
                        nuevo += key.Name + ": " + key.GetValue(objNew) + ", ";
                        antiguo += key.Name + ": " + key.GetValue(objOld) + ", ";
                    }


            if (nuevo != "")
                nuevo = nuevo.Remove(nuevo.Length - 2) + " ";

            //Si se llega a necesitar
            //if (antiguo != "")
            //    antiguo = antiguo.Remove(nuevo.Length - 2) + " ";

            return nuevo;
        }

        public void GuardarLog(string evento, string detalle, int? idUsuario = null, Exception ex = null)
        {
            if (idUsuario == 0)
                idUsuario = null;

            var user = _context.Usuario.Where(u => u.IdUsuario == idUsuario).FirstOrDefault();

            var log = new Log()
            {
                Detalle = detalle,
                Evento = evento,
                Excepcion = ex != null ? ex.ToString() : "",
                Fecha = DateTime.Now,
                IdUsuario = idUsuario,
                Usuario = user != null ? $"{user.Nombre} {user.Apellido} " : ""
            };

            _context.Log.Add(log);
            _context.SaveChanges();
        }
    }
}
