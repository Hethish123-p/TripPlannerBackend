using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

[ApiController]
[Route("api/chatbot")]
public class ChatbotController : ControllerBase
{
    [HttpGet]
    public IActionResult GetResponse([FromQuery] string message)
    {
        var responses = new Dictionary<string, string>
        {
            { "hello", "Hi there! How can I help you plan your trip?" },
            { "recommend", "I recommend visiting Paris, Dubai, or Tokyo!" },
            { "weather", "You can check the weather on OpenWeather API." }
        };

        string response = responses.ContainsKey(message.ToLower()) ? responses[message.ToLower()] : "I can help with destinations, weather, and budgets!";
        return Ok(new { response });
    }
}
