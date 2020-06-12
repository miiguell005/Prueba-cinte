using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Prueba_Cinte.Context.Models
{
    public class Usuario
    {        
        [Key]
        public int IdUsuario { get; set; }

        public int IdTipoIdentificacion { get; set; }

        [MaxLength(255)]
        public string Nombre { get; set; }

        [MaxLength(255)]
        public string Apellido { get; set; }

        [MaxLength(50)]
        public string NumeroIdentificacion { get; set; }

        [MaxLength(255)]
        public string Contrasenia { get; set; }
        
        [MaxLength(255)]
        public string Correo { get; set; }

        public Nullable<int> IdCreado { get; set; }

        public DateTime Creado { get; set; }

        public Nullable<int> IdModificado { get; set; }

        public DateTime Modificado { get; set; }

        public virtual TipoIdentificacion TipoIdentificacion { get; set; }
    }
}
