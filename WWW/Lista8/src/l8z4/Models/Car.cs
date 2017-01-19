using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace l8z4.Models
{
    public class Car
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Proszę podać nr rejestracyjny")]
        [RegularExpression("^([a-zA-z]{2,3}[0-9]{4,6})$", ErrorMessage = "Nr rejestracyjny nie jest poprawny")]
        [Display(Name = "Nr rejestracyjny")]
        public string RegistrationNumber { get; set; }

        [Required(ErrorMessage = "Proszę podać datę pierwszej rejestracji")]
        [Display(Name = "Data pierwszej rejestracji")]
        [DataType(DataType.Date, ErrorMessage = "Wprowadzona data jest niepoprawna")]
        public DateTime FirstRegistrationDate { get; set; }

        [Required(ErrorMessage = "Proszę podać markę auta")]
        [Display(Name = "Marka")]
        public string Brand { get; set; }

        [Required(ErrorMessage = "Proszę podać rok produkcji")]
        [RegularExpression("^([0-9]{4})$", ErrorMessage = "Podany rok produkcji jest niepoprawny")]
        [Display(Name = "Rok produkcji")]
        public int ProductionYear { get; set; }

        [Required(ErrorMessage = "Proszę podać typ paliwa")]
        [RegularExpression("^(P|ON|LPG|EE)$", ErrorMessage = "Podany typ paliwa jest niepoprawny")]
        [Display(Name = "Typ paliwa")]
        public string FuelType { get; set; }
    }
}
