package iuh.week02_lab_huynhhoangphuc_21036541.backend.resources;

import iuh.week02_lab_huynhhoangphuc_21036541.backend.services.EmployeeServices;
import iuh.week02_lab_huynhhoangphuc_21036541.backend.models.Employee;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;
@Path("/employees")
public class EmployeeResources {
    private final EmployeeServices employeeServices;
    private final Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    public EmployeeResources() {
        employeeServices = new EmployeeServices();
    }

    @GET
    @Produces("application/json")
    @Path("/{id}")
    public Response getEmp(@PathParam("id") long eid) {
        Optional<Employee> empOpt = employeeServices.findById(eid);
        if (empOpt.isPresent()) {
            return Response.ok(empOpt.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @GET
    @Produces("application/json")
    public Response getAll() {
        List<Employee> lst = employeeServices.getAll();
        if (lst != null && !lst.isEmpty()) {
            return Response.ok(lst).build();
        }
        return Response.status(Response.Status.NO_CONTENT).build();
    }

    @POST
    @Produces("application/json")
    @Consumes("application/json")
    public Response insert(Employee employee) {
        employeeServices.insertEmp(employee);
        return Response.ok(employee).build();
    }

    @DELETE
    @Path("/{id}")
    public Response delete(@PathParam("id") long id) {
        if (employeeServices.delete(id)) {
            return Response.ok().build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }
}
