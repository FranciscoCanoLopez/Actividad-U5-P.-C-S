using CSharpRestService.Models;
using CSharpRestService.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CSharpRestService.Controllers;

[ApiController]
[Authorize]
[Route("api/v1/shipments")]
public class ShipmentsController : ControllerBase
{
    private readonly IShipmentService _shipmentService;

    public ShipmentsController(IShipmentService shipmentService)
    {
        _shipmentService = shipmentService;
    }

    [HttpGet]
    public ActionResult<IEnumerable<Shipment>> GetAll()
    {
        return Ok(_shipmentService.GetAll());
    }

    [HttpGet("{trackingNumber}")]
    public ActionResult<Shipment> GetByTrackingNumber(string trackingNumber)
    {
        var shipment = _shipmentService.GetByTrackingNumber(trackingNumber);
        if (shipment == null) return NotFound(new { message = $"Guía '{trackingNumber}' no encontrada." });
        return Ok(shipment);
    }

    [HttpPost]
    public ActionResult<Shipment> Create([FromBody] Shipment shipment)
    {
        var created = _shipmentService.Create(shipment);
        return CreatedAtAction(nameof(GetByTrackingNumber), new { trackingNumber = created.TrackingNumber }, created);
    }

    [HttpPut("{trackingNumber}")]
    public IActionResult Update(string trackingNumber, [FromBody] Shipment shipment)
    {
        var updated = _shipmentService.Update(trackingNumber, shipment);
        if (!updated) return NotFound(new { message = $"Guía '{trackingNumber}' no encontrada." });
        return NoContent();
    }

    [HttpDelete("{trackingNumber}")]
    public IActionResult Delete(string trackingNumber)
    {
        var deleted = _shipmentService.Delete(trackingNumber);
        if (!deleted) return NotFound(new { message = $"Guía '{trackingNumber}' no encontrada." });
        return NoContent();
    }

    [HttpPost("{trackingNumber}/events")]
    public ActionResult<TrackingEvent> AddEvent(string trackingNumber, [FromBody] TrackingEvent trackingEvent)
    {
        var shipment = _shipmentService.GetByTrackingNumber(trackingNumber);
        if (shipment == null) return NotFound(new { message = $"Guía '{trackingNumber}' no encontrada." });

        var createdEvent = _shipmentService.AddEvent(trackingNumber, trackingEvent);
        return Ok(createdEvent);
    }

    [HttpGet("{trackingNumber}/events")]
    public ActionResult<IEnumerable<TrackingEvent>> GetEvents(string trackingNumber)
    {
        var shipment = _shipmentService.GetByTrackingNumber(trackingNumber);
        if (shipment == null) return NotFound(new { message = $"Guía '{trackingNumber}' no encontrada." });

        return Ok(_shipmentService.GetEvents(trackingNumber));
    }
}