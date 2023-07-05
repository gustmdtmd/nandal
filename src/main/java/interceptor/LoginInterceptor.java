package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	public LoginInterceptor() {
	
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Login preHandle...");
		String uri = request.getRequestURI();
		//uri:/myapp/write.do
		System.out.println("uri:" + uri);
		
		uri = uri.substring(uri.lastIndexOf("/") + 1);
		//uri:write.do
		System.out.println("uri:" + uri);
		
		HttpSession session = request.getSession();
		//로그인 상태가 아니면
		if(session.getAttribute("id") == null) {
			//"redirect:/write.do"와 같다.
			response.sendRedirect("login.do?returnUrl="+uri);
			return false;
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
}//end class
