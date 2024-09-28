package iuh.backend.resources;


import iuh.backend.models.Customer;
import iuh.backend.services.CustomerService;
import iuh.backend.services.OrderService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/orders")
public class OrderResource {
    private final OrderService orderService;
    private final Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    @Inject
    public OrderResource() {
        orderService = new OrderService();
    }

    @GET
    @Produces("application/json")
    public Response getAll() {
        Response.ResponseBuilder response = Response.ok();
        response.entity(orderService.getAll());
        return response.build();
    }

    @GET
    @Path("/{id}")
    @Produces("application/json")
    public Response getById(@PathParam("id") long id) {
        Response.ResponseBuilder response = Response.ok();
        response.entity(orderService.findById(id));
        return response.build();
    }



}
