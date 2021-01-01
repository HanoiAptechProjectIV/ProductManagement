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
import utils.ProductDAO;
import utils.MyUtils;

import java.io.IOException;
import javax.servlet.annotation.MultipartConfig;
import utils.UploadFile;
 
@WebServlet(urlPatterns = { "/createProduct" })
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class CreateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String  UPLOAD_DIR = "\\images\\product\\";
 
    public CreateProductServlet() {
        super();
    }
 
    // Hiển thị trang tạo sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/create/createProductView.jsp");
        dispatcher.forward(request, response);
    }
    
    // Khi người dùng nhập các thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được gọi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
 
        int id = 0;
        String name = (String) request.getParameter("name");
        String priceStr = request.getParameter("price");
        int price = 0;
        price = Integer.parseInt(priceStr);
        
        UploadFile upload = new UploadFile();
        String image = upload.uploadFile(request, UPLOAD_DIR, "image");
        
        int quantity = Integer.parseInt(request.getParameter("quantity"));;   
        String description = request.getParameter("description");
        LocalDate dateAdded = LocalDate.parse(request.getParameter("dateAdded"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        Product product = new Product(id, price, quantity, categoryId, brandId, name, description, image, dateAdded, false);
 
        String errorString = null;
 
        if (errorString == null) {
            try {
                ProductDAO.insertProduct(conn, product);
            } catch (SQLException e) {
                e.printStackTrace();
                errorString = e.getMessage();
            }
        }
 
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("product", product);
 
        // Nếu có lỗi forward (chuyển tiếp) sang trang 'edit'.
        if (errorString != null) {
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/create/createProductView.jsp");
            dispatcher.forward(request, response);
        }
        // Nếu mọi thứ tốt đẹp.
        // Redirect (chuyển hướng) sang trang danh sách sản phẩm.
        else {
            response.sendRedirect(request.getContextPath() + "/productList");
        }
    } 
}