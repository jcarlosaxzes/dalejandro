namespace PASconcept.Domain.Entities
{
    /// <summary>
    ///     Contains the common property of every VM.
    ///     The type of the PK is int.
    /// </summary>
    public abstract class EntityViewModel<TKey> : IEntityViewModel<TKey>
    {
        public TKey Id { get; set; }
    }

    /// <summary>
    ///     Base class that encapsulates all common VM properties
    /// </summary>
    public class EntityViewModel : EntityViewModel<int>
    {
    }

    public interface IEntityViewModel<TKey>
    {
        TKey Id { get; set; }
    }

    public interface IEntityViewModel : IEntityViewModel<int>
    {
    }
}