using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace superMedAPI.Models
{
    public class Visit
    {
		public int ID { get; set; }
		public int DoctorID { get; set; }
		public int PatientID { get; set; }
		public DateTime Date { get; set; }
	}
}
