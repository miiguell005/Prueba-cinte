using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Prueba_Cinte.Context.Models
{
    public class TipoIdentificacion
    {
        [Key]
        public int IdTipoIdentificacion { get; set; }

        [MaxLength(7)]
        public string Tipo { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Usuario> Usuario { get; set; }
    }
}
