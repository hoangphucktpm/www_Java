package iuh.week02_lab_huynhhoangphuc_21036541.backend.repositories;

import iuh.week02_lab_huynhhoangphuc_21036541.backend.Database.Connection;
import iuh.week02_lab_huynhhoangphuc_21036541.backend.enums.EmployeeStatus;
import iuh.week02_lab_huynhhoangphuc_21036541.backend.models.Employee;
import jakarta.persistence.*;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;

public class EmployeeRepository {
    private EntityManagerFactory emf;
    private EntityManager em;
    private EntityTransaction trans;
    private final Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    public EmployeeRepository(){
        emf = Connection.getInstance().getEmf();
        em = emf.createEntityManager();
        trans = em.getTransaction();
    }

    public void insertEmp(Employee employee) {
        try {
            trans.begin();
            em.persist(employee);
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
            logger.error(ex.getMessage());
        }
    }

    public void setStatus(Employee employee, EmployeeStatus status) {
        employee.setStatus(status);
    }

    public void update(Employee employee) {
        try {
            trans.begin();
            em.merge(employee);
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
            logger.error(ex.getMessage());
        }
    }

    public Optional<Employee> findbyId(long id) {
        TypedQuery<Employee> query = em.createQuery("select e from Employee e where e.id=:id", Employee.class);
        query.setParameter("id", id);
        Employee emp = query.getSingleResult();
        return emp == null ? Optional.empty() : Optional.of(emp);
    }

    public List<Employee> getAllEmp(){
        String sql = "select * from employee";
        List<Employee> le = em.createNativeQuery(sql, Employee.class).getResultList();
        return le;
    }
    //...
}
