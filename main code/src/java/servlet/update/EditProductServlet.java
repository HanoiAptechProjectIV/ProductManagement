/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.update;

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

import beans.Product;
import java.time.LocalDate;
import javax.servlet.annotation.MultipartConfig;
import utils.ProductDAO;
import utils.MyUtils;
import utils.UploadFile;

@WebServlet(urlPatterns = {"/editProduct"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "\\images\\product\\";

    public EditProductServlet() {
        super();
    }

    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);

        Product product = null;
        String errorString = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            product = ProductDAO.findProduct(conn, id);
        } catch (Exception e){
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {

            // Không có lỗi.
            // Sản phẩm không tồn tại để edit.
            // Redirect sang trang danh sách sản phẩm.
            if (errorString != null && product == null) {
                response.sendRedirect(request.getServletPath() + "/productList");
                return;
            }

            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("product", product);

            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/update/editProductView.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        Product product = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = (String) request.getParameter("name");
            int price = Integer.parseInt(request.getParameter("price"));

            UploadFile upload = new UploadFile();
            String image = upload.uploadFile(request, UPLOAD_DIR, "image");
            image = (image.length() > 0) ? image : request.getParameter("oldImage");

            int quantity = Integer.parseInt(request.getParameter("quantity"));;

            String description = request.getParameter("description");
            LocalDate dateAdded = LocalDate.parse(request.getParameter("dateAdded"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            boolean disable = Boolean.parseBoolean(request.getParameter("disable"));

            product = new Product(id, price, quantity, categoryId, brandId, name, description, image, dateAdded, disable);

            ProductDAO.updateProduct(conn, product);
        } catch (Exception e){
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.setAttribute("product", product);

            // Nếu có lỗi forward sang trang edit.
            if (errorString != null) {
                RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/views/CRUD/update/editProductView.jsp");
                dispatcher.forward(request, response);
            } // Nếu mọi thứ tốt đẹp.
            // Redirect sang trang danh sách sản phẩm.
            else {
                response.sendRedirect(request.getContextPath() + "/productList");
            }
        }
    }

}
