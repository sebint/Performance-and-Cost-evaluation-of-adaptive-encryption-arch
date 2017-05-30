/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import iCloud_Pack.DBConnect;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ZionZ
 */
@WebFilter(filterName = "Filt_admin", urlPatterns = {"/user/admin_home/*"})
public class Filt_admin implements Filter {
    
    private static final boolean debug = true;
   DBConnect dbcon=new DBConnect();
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    /**
     *
     * @param req
     * @param res
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain)throws IOException, ServletException {
        int rle=0;
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("iCloud_user_id") == null) {
//        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
//        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
//        response.setDateHeader("Expires", 0); // Proxies.
       response.sendRedirect("../index.jsp?status=login_user");
        } else {
            try{
            ResultSet rs=dbcon.get_User_Info(Integer.parseInt( session.getAttribute("iCloud_user_id").toString()));
            while(rs.next()){
               rle=rs.getInt("role");
            }
            }catch(SQLException ex){
                ex.printStackTrace();
            }
            if(rle==1){
            chain.doFilter(req, res); // Logged-in user found, so just continue request.
            }
            if(rle==0){
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
        
    }
    @Override
    public void destroy() {        
    }

    /**
     * Init method for this filter
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                log("Filt_admin:Initializing filter");
            }
        }
    }
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);        
    }
    
}
