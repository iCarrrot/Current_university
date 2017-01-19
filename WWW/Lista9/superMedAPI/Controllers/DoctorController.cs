using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using superMedAPI.Repositories;
using superMedAPI.Models;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace superMedAPI.Controllers
{
    [Route("api/[controller]")]
    public class DoctorController : Controller
    {
		IDoctorRepository doctorRepository { get; set; }
		public DoctorController(IDoctorRepository doctorRepository)
		{
			this.doctorRepository = doctorRepository;
		}

		// GET: api/values
		[HttpGet]
		public IEnumerable<Doctor> GetAll()
		{
			return doctorRepository.FindAll();

		}

		// GET api/values/5
		[HttpGet("{id}")]
		public IActionResult Get(int id)
		{
			var doctor = doctorRepository.Find(id);
			if (doctor != null)
				return new ObjectResult(doctor);
			else
				return NotFound();
		}

		// POST api/values
		[HttpPost]
		public IActionResult Create([FromBody]Doctor doctorData)
		{
			if (doctorData == null)
			{
				return BadRequest();
			}
			var doctor = doctorRepository.Add(doctorData);
			return CreatedAtAction("Get", new { id = doctor.ID }, doctor);
		}

		// PUT api/values/5
		[HttpPut("{id}")]
		public IActionResult Update(int id, [FromBody]Doctor doctorData)
		{
			if (doctorData == null || doctorData.ID != id)
			{
				return BadRequest();
			}

			var doctor = doctorRepository.Find(id);
			if (doctor == null)
			{
				return NotFound();
			}

			doctorRepository.Update(id, doctorData);
			return new NoContentResult();
		}

		// DELETE api/values/5
		[HttpDelete("{id}")]
		public IActionResult Delete(int id)
		{
			var doctor = doctorRepository.Find(id);
			if (doctor == null)
			{
				return NotFound();
			}
			doctorRepository.Remove(id);
			return new NoContentResult();
		}
	}
}
