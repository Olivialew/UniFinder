using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace UniFinder
{
    public class DataCleaner
    {        public static string RemoveHtmlTags(string text)
        {
            return Regex.Replace(text, "<.*?>", string.Empty);
        }

        public static string RemoveSpecificCharacters(string text, char[] charsToRemove)
        {
            foreach (var c in charsToRemove)
            {
                text = text.Replace(c.ToString(), string.Empty);
            }
            return text;
        }
    }
}