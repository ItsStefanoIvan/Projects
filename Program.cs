using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Web;

class Program
{
    public class Episode
    {
        public string? Title { get; set; }
        public string? Directors { get; set; }
        public string? WrittenBy { get; set; }
        public string? Released { get; set; }
    }

    static void Main()
    {
        string urlSeasons1To4 = "https://en.wikipedia.org/wiki/List_of_Samurai_Jack_episodes#Episodes";
        string fromMail = "ivanstefanovyahoo.com@gmail.com";
        string fromPassword = "rjen roqj mhqp ckiy";

        Console.Write("Do you want to enter the recipient's email address? (yes/no): ");
        string userInput = Console.ReadLine().ToLower();

        string toMail;

        if (userInput == "yes")
        {
            Console.Write("Enter the recipient's email address: ");
            toMail = Console.ReadLine();
        }
        else
        {
            // Default recipient email
            toMail = "ivanstefanovyahoo.com@gmail.com, Ivan_Stefanov05@yahoo.com";
        }

        while (true)
        {
            // Call the dynamic scraper function and send email for Seasons 1-4
            ScrapeAndSendEmailSeasons1To4(urlSeasons1To4, fromMail, fromPassword, toMail);

            // Sleep
            Thread.Sleep(TimeSpan.FromMinutes(1));
        }
    }

    static void ScrapeAndSendEmailSeasons1To4(string url, string fromMail, string fromPassword, string toMail)
    {
        try
        {
            var htmlContent = DownloadHtmlContent(url);

            var document = new HtmlDocument();
            document.LoadHtml(htmlContent);

            // XPath expression to target only tables for seasons 1 to 4
            var nodes = document.DocumentNode.SelectNodes("//*[@id='mw-content-text']//table[contains(@class,'wikiepisodetable')][position()<5]/tbody/tr[position()>1]");

            if (nodes != null)
            {
                List<Episode> episodes = new List<Episode>();

                foreach (var node in nodes)
                {
                    string title = node.SelectSingleNode("td[2]")?.InnerText?.Trim();
                    string directors = node.SelectSingleNode("td[3]")?.InnerText?.Trim();
                    string writtenBy = node.SelectSingleNode("td[4]")?.InnerText?.Trim();
                    string released = HttpUtility.HtmlDecode(node.SelectSingleNode("td[5]")?.InnerText?.Trim());

                    // Check if any of the fields are empty, and skip if true
                    if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(directors) ||
                        string.IsNullOrEmpty(writtenBy) || string.IsNullOrEmpty(released))
                    {
                        continue;
                    }

                    episodes.Add(new Episode()
                    {
                        Title = title,
                        Directors = directors,
                        WrittenBy = writtenBy,
                        Released = released
                    });
                }

                string emailBody = GenerateEmailBody(episodes);

                SendEmail(fromMail, fromPassword, toMail, "Samurai Jack Episodes (Seasons 1-4)", emailBody);
            }
            else
            {
                Console.WriteLine("No nodes found in the HTML for Seasons 1-4.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }

    static string DownloadHtmlContent(string url)
    {
        using (var client = new WebClient())
        {
            return client.DownloadString(url);
        }
    }

    static string GenerateEmailBody(List<Episode> episodes)
    {
        StringBuilder bodyBuilder = new StringBuilder();

        foreach (var episode in episodes)
        {
            bodyBuilder.AppendLine($"Title: {episode.Title}");
            bodyBuilder.AppendLine($"Directors: {episode.Directors}");
            bodyBuilder.AppendLine($"Written By: {episode.WrittenBy}");
            bodyBuilder.AppendLine($"Released: {episode.Released}");
            bodyBuilder.AppendLine(new string('-', 30)); // Separator between episodes
        }

        return bodyBuilder.ToString();
    }

    static void SendEmail(string fromMail, string fromPassword, string toMail, string subject, string body)
    {
        MailMessage message = new MailMessage();
        message.From = new MailAddress(fromMail);
        message.Subject = subject;
        foreach (var email in toMail.Split(','))
        {
            message.To.Add(new MailAddress(email.Trim()));
        }
        message.Body = body;
        message.IsBodyHtml = false; // Change to true to send HTML-formatted email

        var smtpClient = new SmtpClient("smtp.gmail.com")
        {
            Port = 587,
            Credentials = new NetworkCredential(fromMail, fromPassword),
            EnableSsl = true,
        };

        smtpClient.Send(message);
        Console.WriteLine($"Email sent to {toMail}");
    }
}
