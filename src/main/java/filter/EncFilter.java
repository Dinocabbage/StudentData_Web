package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

@WebFilter("*.jsp")
public class EncFilter extends HttpFilter implements Filter {
	private static final long serialVersionUID = 1L;
	private String encoding;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if(request.getCharacterEncoding() == null) {
			request.setCharacterEncoding(encoding);
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		this.encoding = fConfig.getServletContext().getInitParameter("encoding");
	}

}
