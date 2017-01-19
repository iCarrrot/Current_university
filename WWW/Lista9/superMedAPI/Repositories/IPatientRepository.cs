using System.Collections.Generic;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
	public interface IPatientRepository
	{
		Patient Add(Patient patient);
		Patient Find(int id);
		List<Patient> FindAll();
		void Remove(int id);
		Patient Update(int id, Patient patient);
	}
}