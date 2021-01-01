/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.create;

/**
 *
 * @author Hung
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Brand;
import javax.servlet.annotation.MultipartConfig;
import utils.BrandDAO;
import utils.MyUtils;
import utils.UploadFile;

@WebServlet(urlPatterns = {"/createBrand"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class CreateBrandServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "\\images\\brand\\";

    public CreateBrandServlet() {
        super();
    }

    // Hiển thị trang tạo sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/create/createBrandView.jsp");
        dispatcher.forward(request, response);
    }

    // Khi người dùng nhập các thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được gọi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        Brand brand = null;
        try {
            int id = 0;
            String name = (String) request.getParameter("name");

            UploadFile upload = new UploadFile();
            String logo = upload.uploadFile(request, UPLOAD_DIR, "logo");

            String manufacturer = request.getParameter("manufacturer");
            String description = request.getParameter("description");

            brand = new Brand(id, name, logo, manufacturer, description, false);

            if (errorString == null) {
                BrandDAO.insertBrand(conn, brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {

            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("brand", brand);

            // Nếu có lỗi forward (chuyển tiếp) sang trang 'edit'.
            if (errorString != null) {
                RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/views/CRUD/create/createBrandView.jsp");
                dispatcher.forward(request, response);
            } // Nếu mọi thứ tốt đẹp.
            // Redirect (chuyển hướng) sang trang danh sách sản phẩm.
            else {
                response.sendRedirect(request.getContextPath() + "/brandList");
            }
        }
    }

}
