namespace PASconcept.Domain.Entities
{
    /// <summary>
    ///     Contains the common properties of the entities.
    /// </summary>
    /// <typeparam name="TKey">The type of the object primary key</typeparam>
    public interface IEntity<TKey> : IEntity
    {
        /// <summary>
        ///     Gets or sets the primary key of the object.
        /// </summary>
        TKey Id { get; set; }
    }

    public interface IEntity
    {
    }
}