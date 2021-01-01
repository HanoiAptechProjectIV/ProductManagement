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
 
import beans.Brand;
import javax.servlet.annotation.MultipartConfig;
import utils.BrandDAO;
import utils.MyUtils;
import utils.UploadFile;
 
@WebServlet(urlPatterns = { "/editBrand" })
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class EditBrandServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String  UPLOAD_DIR = "\\images\\brand\\";
 
    public EditBrandServlet() {
        super();
    }
 
    // Hiển thị trang sửa sản phẩm.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
 
        int id = Integer.parseInt(request.getParameter("id"));
 
        Brand brand = null;
 
        String errorString = null;
 
        try {
            brand = BrandDAO.findBrand(conn, id);
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }
 
        // Không có lỗi.
        // Sản phẩm không tồn tại để edit.
        // Redirect sang trang danh sách sản phẩm.
        if (errorString != null && brand == null) {
            response.sendRedirect(request.getServletPath() + "/brandList");
            return;
        }
 
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("brand", brand);
 
        RequestDispatcher dispatcher = request.getServletContext()
                .getRequestDispatcher("/WEB-INF/views/CRUD/update/editBrandView.jsp");
        dispatcher.forward(request, response);
 
    }
 
    // Sau khi người dùng sửa đổi thông tin sản phẩm, và nhấn Submit.
    // Phương thức này sẽ được thực thi.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
 
        int id = Integer.parseInt( request.getParameter("id"));
        String name = (String) request.getParameter("name");
        
        UploadFile upload = new UploadFile();
        String logo = upload.uploadFile(request, UPLOAD_DIR, "logo");
        logo = (logo.length() > 0) ? logo : request.getParameter("oldLogo");
        
        String manufacturer = request.getParameter("manufacturer");
        String description = request.getParameter("description");
        boolean disable = Boolean.parseBoolean(request.getParameter("disable"));
        
        Brand brand = new Brand(id, name, logo, manufacturer, description, disable);
 
        String errorString = null;
 
        try {
            BrandDAO.updateBrand(conn, brand);
        } catch (SQLException e) {
            e.printStackTrace();
            errorString = e.getMessage();
        }
        // Lưu thông tin vào request attribute trước khi forward sang views.
        request.setAttribute("errorString", errorString);
        request.setAttribute("brand", brand);
 
        // Nếu có lỗi forward sang trang edit.
        if (errorString != null) {
            RequestDispatcher dispatcher = request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/views/CRUD/update/editBrandView.jsp");
            dispatcher.forward(request, response);
        }
        // Nếu mọi thứ tốt đẹp.
        // Redirect sang trang danh sách sản phẩm.
        else {
            response.sendRedirect(request.getContextPath() + "/brandList");
        }
    }
 
}