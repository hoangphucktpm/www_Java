package iuh.demo.api;

import iuh.demo.business.BaseProcess;
import iuh.demo.models.Student;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;

@Path("/students")
public class StudentResource {
    @Inject
    private BaseProcess baseProcess;
    @GET
    public Response getAll() {
        Response.ResponseBuilder builder = Response.ok();
        builder.entity(baseProcess.getAll());
        return builder.build();
    }

    @GET
    @Path("/{id}")
    public Response getById(@PathParam("id") long id) {
        Response.ResponseBuilder builder = Response.ok();
        builder.entity(baseProcess.getById(id));
        return builder.build();
    }

    @POST
    public Response add(Student student) {
        Response.ResponseBuilder builder = Response.ok();
        builder.entity(baseProcess.persist(student));
        return builder.build();
    }

}
