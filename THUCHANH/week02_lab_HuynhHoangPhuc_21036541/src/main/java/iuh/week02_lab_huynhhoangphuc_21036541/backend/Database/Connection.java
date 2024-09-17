package iuh.week02_lab_huynhhoangphuc_21036541.backend.Database;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Connection {
    private static Connection instance;
    private EntityManagerFactory emf;

    private Connection(){
        emf = Persistence.createEntityManagerFactory("mariaDB");
    }

    public static Connection getInstance(){
        if(instance == null){
            instance = new Connection();
        }
        return instance;
    }

    public EntityManagerFactory getEmf(){
        return emf;
    }
}