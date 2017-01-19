using System.Collections.Generic;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
	public interface IDoctorRepository
	{
		Doctor Add(Doctor doctor);
		Doctor Find(int id);
		List<Doctor> FindAll();
		void Remove(int id);
		Doctor Update(int id, Doctor doctor);
	}
}