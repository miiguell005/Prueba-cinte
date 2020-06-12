using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Prueba_Cinte.Context.Models
{
    public class Log
    {
        [Key]
        public int IdLog { get; set; }

        public Nullable<int> IdUsuario { get; set; }

        [MaxLength(255)]
        public string Usuario { get; set; }

        public DateTime Fecha { get; set; }

        public string Detalle { get; set; }

        [MaxLength(255)]
        public string Evento { get; set; }

        public string Excepcion { get; set; }
    }
}
