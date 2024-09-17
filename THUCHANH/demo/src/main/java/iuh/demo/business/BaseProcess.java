package iuh.demo.business;

import iuh.demo.models.Student;

import java.util.ArrayList;
import java.util.List;

public class BaseProcess {
    public List<Student> students = new ArrayList<>();

    public List<Student> getAll() {
        students.add(new Student(1, "Nguyen Van A", "12 nvb"));
        students.add(new Student(2, "Nguyen Van B", "12 nvc"));
        students.add(new Student(3, "Nguyen Van C", "12 nvd"));
        return students;
    }

    public Student getById(long id) {
        //.....
        return null;
    }

    public Student persist(Student student) {
        //.....
        return student;
    }
}
