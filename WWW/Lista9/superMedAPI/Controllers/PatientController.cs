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
    public class PatientController : Controller
    {
		IPatientRepository patientRepository { get; set; }
		public PatientController(IPatientRepository patientRepository)
		{
			this.patientRepository = patientRepository;
		}


		// GET: api/values
		[HttpGet]
		public IEnumerable<Patient> GetAll()
		{
			return patientRepository.FindAll();

		}

		// GET api/values/5
		[HttpGet("{id}")]
		public IActionResult Get(int id)
		{
			var patient = patientRepository.Find(id);
			if (patient != null)
				return new ObjectResult(patient);
			else
				return NotFound();
		}

		// POST api/values
		[HttpPost]
		public IActionResult Create([FromBody]Patient patientData)
		{
			if (patientData == null)
			{
				return BadRequest();
			}
			var patient = patientRepository.Add(patientData);
			return CreatedAtAction("Get", new { id = patient.ID }, patient);
		}

		// PUT api/values/5
		[HttpPut("{id}")]
		public IActionResult Update(int id, [FromBody]Patient patientData)
		{
			if (patientData == null || patientData.ID != id)
			{
				return BadRequest();
			}

			var patient = patientRepository.Find(id);
			if (patient == null)
			{
				return NotFound();
			}

			patientRepository.Update(id, patientData);
			return new NoContentResult();
		}

		// DELETE api/values/5
		[HttpDelete("{id}")]
		public IActionResult Delete(int id)
		{
			var patient = patientRepository.Find(id);
			if (patient == null)
			{
				return NotFound();
			}
			patientRepository.Remove(id);
			return new NoContentResult();
		}
	}
}
