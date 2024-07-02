using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TicketingSystem.Data;
using TicketingSystem.Models;



[Route("api/[controller]")]
[ApiController]
public class TicketsController : ControllerBase
{
    private readonly TicketContext _context;

    public TicketsController(TicketContext context)
    {
        _context = context;
    }

    [HttpGet("GetTickets")]
    public async Task<ActionResult<List<Ticket>>> GetTickets()

    {
        var value = await _context.Tickets.ToListAsync();
        return Ok(value);
    }

    [HttpPost("RaiseTicket")]
    public async Task<IActionResult> RaiseTicket([FromBody] Ticket ticket)
    {
        if (ticket == null)
        {
            return BadRequest(new { success = false, message = "Ticket object is null." });
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        Random random = new Random();
        string ticketReference = random.Next(10000, 99999).ToString() + random.Next(10000, 99999).ToString();

        ticket.EmailSent = false;
        _context.Tickets.Add(ticket);
        await _context.SaveChangesAsync();

        return Ok(new { success = true, message = $"Ticket raised successfully. Ticket Reference #{ticketReference}" });
    }
}
