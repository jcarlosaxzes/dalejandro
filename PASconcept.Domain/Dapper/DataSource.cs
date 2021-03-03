using System.Collections.Generic;

namespace PASconcept.Domain.Dapper
{
    public class DataSource<T>
    {
        public int Count { get; set; }

        public IEnumerable<T> Payload { get; set; }

        public DataSource()
        {
            this.Count = 0;
            this.Payload = new List<T>();
        }
    }
}