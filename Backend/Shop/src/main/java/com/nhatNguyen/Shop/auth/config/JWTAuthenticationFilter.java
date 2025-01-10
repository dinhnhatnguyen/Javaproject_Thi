package com.nhatNguyen.Shop.auth.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

public class JWTAuthenticationFilter extends OncePerRequestFilter {

    private final UserDetailsService userDetailsService;
    private final JWTTokenHelper jwtTokenHelper;

    public JWTAuthenticationFilter(JWTTokenHelper jwtTokenHelper, UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
        this.jwtTokenHelper = jwtTokenHelper;
    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authHeader = request.getHeader("Authorization");

        // kiểm tra có tồn tại header hay không hoặc có format Bearer  hay không
        if (null == authHeader || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);// nếu không cho request đi tiếp nếu không có JWT
            return;
        }
        try {
            String authToken = jwtTokenHelper.getToken(request);
            if (null != authToken) {
                // Lấy username từ token
                String userName = jwtTokenHelper.getUserNameFromToken(authToken);
                if (null != userName) {
                    // Load thông tin user từ database
                    UserDetails userDetails = userDetailsService.loadUserByUsername(userName);

                    // Validate token
                    if (jwtTokenHelper.validateToken(authToken, userDetails)) {
                        // Tạo authentication object nếu token hợp lệ
                        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                                userDetails, // thông tin user
                                null, // thông tin pass (nhưng ở đây không cần lưu nên để null)
                                userDetails.getAuthorities() // quyền hạn (user, admin)
                        );
                        authenticationToken.setDetails(new WebAuthenticationDetails(request));

                        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    }
                }

            }
            filterChain.doFilter(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
