using System.ComponentModel.DataAnnotations;

namespace TicketingSystem.Models
{

    public class Ticket
    {
        public int Id { get; set; }

        [Required]
        [EmailAddress]
        public string userId { get; set; }

        [Required]
        public string priority { get; set; }

        [Required]
        public string Module { get; set; }

        [Required]
        public string Title { get; set; }

        [Required]
        public string OrderId { get; set; }

        [Required]
        public string Description { get; set; }

        public bool EmailSent { get; set; }

    }
}
