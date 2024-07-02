<<<<<<< HEAD
﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;

public class Program
{
    private static readonly HttpClient _httpClient = new HttpClient
    {
        BaseAddress = new Uri("https://localhost:7254"),
        Timeout = TimeSpan.FromSeconds(60)
    };

    private static Timer _timer;
    private static HashSet<int> processedTicketIds = new HashSet<int>();

    public static async Task Main(string[] args)
    {
        SetupTimer();
        Console.WriteLine("Console application started. Press Ctrl + C to exit.");
        await Task.Delay(Timeout.Infinite); 
    }

    private static void SetupTimer()
    {
        _timer = new Timer(async (_) =>
        {
            try
            {
                await ProcessTicketsAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error processing tickets: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");
                if (ex.InnerException != null)
                {
                    Console.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                    Console.WriteLine($"Inner Exception Stack Trace: {ex.InnerException.StackTrace}");
                }
            }
        }, null, TimeSpan.Zero, TimeSpan.FromSeconds(60)); 
    }

    private static async Task ProcessTicketsAsync()
    {
        List<Ticket> tickets = await FetchTicketsFromApiAsync();
        if (tickets != null && tickets.Count > 0)
        {
            Console.WriteLine($"{tickets.Count} tickets retrieved from API.");
            foreach (var ticket in tickets)
            {
                Console.WriteLine($"Processing ticket: {ticket.Id}, Priority: {ticket.priority}");
                if (ticket.priority == "High" && !processedTicketIds.Contains(ticket.Id))
                {
                    await SendEmailAlertAsync(ticket);
                    processedTicketIds.Add(ticket.Id);
                }
            }
        }
        else
        {
            Console.WriteLine("No high-priority tickets retrieved from API.");
        }
    }

    private static async Task<List<Ticket>> FetchTicketsFromApiAsync()
    {
        try
        {
            HttpResponseMessage response = await _httpClient.GetAsync("/api/Tickets/GetTickets");

            if (response.IsSuccessStatusCode)
            {
                string json = await response.Content.ReadAsStringAsync();
                var tickets = JsonConvert.DeserializeObject<List<Ticket>>(json);
                return tickets;
            }
            else
            {
                Console.WriteLine($"Failed to fetch tickets. Status code: {response.StatusCode}");
                return null;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred while fetching tickets: {ex.Message}");
            throw;
        }
    }

    public static async Task SendEmailAlertAsync(Ticket ticket)
    {
        string adminEmail = "er.sabdarkhan@gmail.com"; 
        string subject = $"High Priority Ticket: {ticket.Title}";
        string body = $"Ticket details:\nPriority: {ticket.priority}\nModule: {ticket.Module}\nDescription: {ticket.Description}";

        string email = Environment.GetEnvironmentVariable("EMAIL_USERNAME");
        string appPassword = Environment.GetEnvironmentVariable("EMAIL_PASSWORD");

        Console.WriteLine($"Debug - Email: {email}");
        Console.WriteLine($"Debug - Password: {appPassword}");

        try
        {
            using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com"))
            {
                smtpClient.Port = 587; 
                smtpClient.Credentials = new System.Net.NetworkCredential(email, appPassword);
                smtpClient.EnableSsl = true; 

                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(email);
                mailMessage.To.Add(adminEmail);
                mailMessage.Subject = subject;
                mailMessage.Body = body;

                await smtpClient.SendMailAsync(mailMessage);
                Console.WriteLine($"Email sent successfully to admin for ticket: {ticket.Id}");
            }
        }
        catch (SmtpException ex)
        {
            Console.WriteLine($"SMTP error while sending email for ticket {ticket.Id}: {ex.Message}");
            throw;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed to send email for ticket {ticket.Id}: {ex.Message}");
            throw;
        }
    }
}

public class Ticket
{
    public int Id { get; set; }
    public string userId { get; set; }
    public string priority { get; set; }
    public string Module { get; set; }
    public string Title { get; set; }
    public string OrderId { get; set; }
    public string Description { get; set; }
    public bool EmailSent { get; set; }
}
=======
using Microsoft.EntityFrameworkCore;
using TicketingSystem.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("dbsc");
// Register the DbContext with the connection string
builder.Services.AddDbContext<TicketContext>(options =>
    options.UseSqlServer(connectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(options =>
{
    options.AllowAnyOrigin()
           .AllowAnyMethod()
           .AllowAnyHeader();
});

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
>>>>>>> 466efa6186c9c55ad811ba339b31c04e0de52d8d
