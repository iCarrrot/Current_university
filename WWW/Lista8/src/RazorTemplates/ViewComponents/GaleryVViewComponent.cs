using Microsoft.AspNetCore.Mvc;
using RazorTemplates.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RazorTemplates.ViewComponents
{
    public class GaleryVViewComponent : ViewComponent
    {
        //private IWiseMan _wiseMan;

        public GaleryVViewComponent(IWiseMan wiseMan)
        {
            //_wiseMan = wiseMan;
        }

        public IViewComponentResult Invoke()
        {
            //var model = _wiseMan.GetThought();
            //return View("Default", model);
            var model = new string[4]
            {
                "images/banner1.svg",
                "images/banner2.svg",
                "images/banner3.svg",
                "images/banner4.svg"
            };
            return View("Default", model);
        }
    }
}
