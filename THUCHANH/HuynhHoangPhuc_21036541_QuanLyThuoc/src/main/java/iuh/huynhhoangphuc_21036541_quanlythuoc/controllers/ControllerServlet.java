package iuh.huynhhoangphuc_21036541_quanlythuoc.controllers;

import iuh.huynhhoangphuc_21036541_quanlythuoc.dao.QuanLyLoaiThuocDAO;
import iuh.huynhhoangphuc_21036541_quanlythuoc.dao.QuanLyThuocDAO;
import iuh.huynhhoangphuc_21036541_quanlythuoc.models.LoaiThuoc;
import iuh.huynhhoangphuc_21036541_quanlythuoc.models.Thuoc;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ControllerServlet", urlPatterns = "/controller")
public class ControllerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        QuanLyThuocDAO quanLyThuocDAO = new QuanLyThuocDAO();
        QuanLyLoaiThuocDAO quanLyLoaiThuocDAO = new QuanLyLoaiThuocDAO();

        if (action.equalsIgnoreCase("listThuoc")) {
            List<Thuoc> thuocList = quanLyThuocDAO.getAllThuoc();
            request.setAttribute("thuocList", thuocList);
            request.getRequestDispatcher("danhSachThuoc.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("listLoaiThuoc")) {
            List<LoaiThuoc> loaiThuocList = quanLyLoaiThuocDAO.getAllLoaiThuoc();
            request.setAttribute("loaiThuocList", loaiThuocList);
            request.getRequestDispatcher("danhSachLoaiThuoc.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("filterByLoai")) {
            String maLoai = request.getParameter("maLoai");
            List<Thuoc> thuocList = quanLyThuocDAO.getThuocByLoai(maLoai);
            List<LoaiThuoc> loaiThuocList = quanLyLoaiThuocDAO.getAllLoaiThuoc();
            request.setAttribute("thuocList", thuocList);
            request.setAttribute("loaiThuocList", loaiThuocList);
            request.getRequestDispatcher("danhSachThuoc.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("addThuoc")) {
            List<LoaiThuoc> loaiThuocList = quanLyLoaiThuocDAO.getAllLoaiThuoc();
            request.setAttribute("loaiThuocList", loaiThuocList);
            request.getRequestDispatcher("themThuoc.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        QuanLyThuocDAO quanLyThuocDAO = new QuanLyThuocDAO();

        if (action.equalsIgnoreCase("addThuocSubmit")) {
            Thuoc thuoc = new Thuoc();
            thuoc.setMaThuoc(request.getParameter("maThuoc"));
            thuoc.setTenThuoc(request.getParameter("tenThuoc"));
            thuoc.setGia(Double.parseDouble(request.getParameter("gia")));
            thuoc.setNamSx(Integer.parseInt(request.getParameter("namSx")));
            LoaiThuoc loaiThuoc = new LoaiThuoc();
            loaiThuoc.setMaLoai(request.getParameter("maLoai"));
            thuoc.setMaLoai(loaiThuoc);
            quanLyThuocDAO.addThuoc(thuoc);
            response.sendRedirect("controller?action=listThuoc");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}