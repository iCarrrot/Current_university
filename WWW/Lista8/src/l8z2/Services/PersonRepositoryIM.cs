using l8z2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace l8z2.Services
{
    public interface IPersonRepository
    {
        IEnumerable<Person> GetAll();
        Person GetById(int id);
        IEnumerable<Person> GetPart(int id);
    }
    public class PersonRepositoryIM : IPersonRepository
    {
        List<Person> _persons;
        int numberPerPage = 10;

        public PersonRepositoryIM()
        {
            //_persons = new List<Person>
            //{
            //    new Person { Id = 1, FirstName = "Jan", LastName = "Kowalski", Address = "ul. Trawiasta 10" },
            //    new Person { Id = 2, FirstName = "Agata", LastName = "Zielony", Address = "ul. Koszykowa 12" },
            //    new Person { Id = 3, FirstName = "Ewa", LastName = "Szumska", Address = "ul. Zaciszna 3" }
            //};
            _persons = new List<Person>();
            for(var i = 0; i < 100; i++)
            {
                _persons.Add(new Person
                {
                    Id = i,
                    FirstName = String.Format("Imie{0}", i),
                    LastName = String.Format("Nazwisko{0}", i),
                    Address = String.Format("Adres{0}", i)
                });
            }
        }
        public IEnumerable<Person> GetAll()
        {
            return _persons;
        }

        public IEnumerable<Person> GetPart(int id)
        {
            return this._persons
                .Skip(id * this.numberPerPage)
                .Take(this.numberPerPage);
        }

        public Person GetById(int id)
        {
            foreach (var p in _persons)
                if (p.Id == id)
                    return p;
            return null;
        }
    }
}
