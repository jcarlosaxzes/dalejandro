using System.Runtime.Serialization;

namespace PASconcept.Domain.Entities
{
    public class IGridViewModel
    {
        [IgnoreDataMember] int Count { get; set; }
    }
}