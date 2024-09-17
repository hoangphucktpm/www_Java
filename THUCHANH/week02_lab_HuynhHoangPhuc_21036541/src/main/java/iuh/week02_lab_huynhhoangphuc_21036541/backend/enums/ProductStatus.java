package iuh.week02_lab_huynhhoangphuc_21036541.backend.enums;

public enum ProductStatus {
    ACTIVE(1),      // đang kinh doanh
    ON_LEAVE(0),    // tạm ngưng kinh doanh
    TERMINATED(-1); // ngừng kinh doanh

    private int value;

    ProductStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
