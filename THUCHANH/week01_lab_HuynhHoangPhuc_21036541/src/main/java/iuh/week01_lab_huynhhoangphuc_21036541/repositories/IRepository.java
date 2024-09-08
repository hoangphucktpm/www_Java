package iuh.week01_lab_huynhhoangphuc_21036541.repositories;

import java.util.List;
import java.util.Optional;

public interface IRepository<T> {
    boolean them(T t);
    boolean xoa(T t);
    boolean capNhat(T t);
    List<T> layDs();
    Optional<T> layTheoMa(Object...objects) throws Exception;
}
