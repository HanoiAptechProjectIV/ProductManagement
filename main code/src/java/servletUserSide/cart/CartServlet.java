/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletUserSide.cart;

/**
 *
 * @author Hung
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.CartItem;
import beans.Product;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import utils.MyUtils;
import utils.ProductDAO;

@WebServlet(urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public CartServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            doGet_DisplayCart(request, response);
        } else {
            if (action.equalsIgnoreCase("buy")) {
                doGet_Buy(request, response);
            } else if (action.equalsIgnoreCase("remove")) {
                doGet_Remove(request, response);
            }
        }
    }

    protected void doGet_DisplayCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getServletContext().getRequestDispatcher("/WEB-INF/userViews/detail/cartDetail.jsp").forward(request, response);
    }

    protected void doGet_Remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            int id = Integer.parseInt(request.getParameter("id"));
            int index = CartItem.getItemIndex(id, cart);
            cart.remove(index);
            session.setAttribute("cart", cart);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            String previousUrl = request.getHeader("referer");
            String rootPath = request.getContextPath();
            String previousPath = previousUrl.substring(previousUrl.lastIndexOf(rootPath) + rootPath.length());
            response.sendRedirect(request.getContextPath() + previousPath);
        }
    }

    protected void doGet_Buy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Connection conn = MyUtils.getStoredConnection(request);
            int productId = Integer.parseInt(request.getParameter("id"));
            if (session.getAttribute("cart") == null) {
                List<CartItem> cart = new ArrayList<>();
                cart.add(new CartItem(ProductDAO.findProduct(conn, productId), 1));
                session.setAttribute("cart", cart);
            } else {
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                int id = Integer.parseInt(request.getParameter("id"));
                int index = CartItem.getItemIndex(id, cart);
                if (index == -1) {
                    cart.add(new CartItem(ProductDAO.findProduct(conn, productId), 1));
                } else {
                    int quantity = cart.get(index).getQuantity() + 1;
                    cart.get(index).setQuantity(quantity);
                }
                session.setAttribute("cart", cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            String previousUrl = request.getHeader("referer");
            String rootPath = request.getContextPath();
            String previousPath = previousUrl.substring(previousUrl.lastIndexOf(rootPath) + rootPath.length());
            response.sendRedirect(request.getContextPath() + previousPath);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = MyUtils.getStoredConnection(request);
        String errorString = null;
        try {
            HttpSession session = request.getSession();
            if (request.getParameter("cartDetail") == null) {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Product product = ProductDAO.findProduct(conn, id);
                if (product != null) {
                    if (session.getAttribute("cart") == null) {
                        List<CartItem> cart = new ArrayList<>();
                        cart.add(new CartItem(product, quantity));
                        session.setAttribute("cart", cart);
                    } else {
                        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                        int index = CartItem.getItemIndex(id, cart);
                        if (index == -1) {
                            cart.add(new CartItem(product, quantity));
                        } else {
                            cart.get(index).setQuantity(quantity);
                        }
                        session.setAttribute("cart", cart);
                    }
                }
            } else {
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                List<CartItem> cartTemp = new ArrayList<>();
                for(int i=0;i<cart.size();i++){
                    int quantity = Integer.parseInt(request.getParameter("quantity"+i));
                    boolean isRemove = Boolean.parseBoolean(request.getParameter("remove"+i));
                    
                    cart.get(i).setQuantity(quantity);
                    if(isRemove){
                        cartTemp.add(cart.get(i));
                    }
                }
                for(CartItem item : cartTemp){
                    cart.remove(item);
                }
                session.setAttribute("cart", cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorString = e.getMessage();
        } finally {
            // Lưu thông tin vào request attribute trước khi forward sang views.
            request.setAttribute("errorString", errorString);
            request.getServletContext().getRequestDispatcher("/WEB-INF/userViews/detail/cartDetail.jsp").forward(request, response);
        }
    }

}
