<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8"); // 设置request编码
    response.setCharacterEncoding("UTF-8"); // 设置response编码
    String action = request.getParameter("action"); // 获取action参数
    if ("login".equals(action)) { // 如果为login动作
        String account = request.getParameter("account");// 获取account参数
        String password = request.getParameter("password");// 获取password参数                                                   
        int timeout = new Integer(request.getParameter("timeout")); // 获取timeout参数
        Cookie accountCookie = new Cookie("account", account);// 新建Cookie                                                 
        accountCookie.setMaxAge(timeout);// 设置有效期
        //Cookie ssidCookie =new Cookie("ssid", ssid);   // 新建Cookie
        //ssidCookie.setMaxAge(timeout);                 // 设置有效期
        response.addCookie(accountCookie); // 输出到客户端
        //response.addCookie(ssidCookie);            // 输出到客户端
        // 重新请求本页面，参数中带有时间戳，禁止浏览器缓存页面内容
        response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
        return;
    } else if ("logout".equals(action)) {
        Cookie accountCookie = new Cookie("account", "");// 新建Cookie，内容为空
        accountCookie.setMaxAge(0); // 设置有效期为0，删除
        response.addCookie(accountCookie); // 输出到客户端
        //重新请求本页面，参数中带有时间戳，禁止浏览器缓存页面内容
        response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
        return;
    }

    boolean login = false; // 是否登录
    String account = null; // 账号
    String ssid = null; // SSID标识
    if (request.getCookies() != null) { // 如果Cookie不为空
        for (Cookie cookie : request.getCookies()) { // 遍历Cookie
            if (cookie.getName().equals("account")) // 如果Cookie名为 account
                account = cookie.getValue(); // 保存account内容
        }
    }
    if (account != null) { // 如果account、SSID都不为空
        login = true;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<span><%=login ? "欢迎您回来" : "请先登录"%></span>
	<a href="${pageContext.request.requestURI }" target="_parent">Jsessionid</a>
	<%
	    if (login) {
	%>
	欢迎您, ${cookie.account.value }. &nbsp;&nbsp;
	<a href="${pageContext.request.requestURI }?action=logout"> 注销</a>
	<%
	    } else {
	%>
	<form action="${pageContext.request.requestURI }?action=login"
		method="post">
		<table>
			<tr>
				<td>账号：</td>
				<td><input type="text" name="account" style="width: 200px;"></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>有效期：</td>
				<td><input type="radio" name="timeout" value="-1" checked>
					关闭浏览器即失效 <br /> <input type="radio" name="timeout"
					value="<%=30 * 24 * 60 * 60%>"> 30天 内有效 <br /> <input
					type="radio" name="timeout" value="<%=Integer.MAX_VALUE%>">
					永久有效 <br /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value=" 登 录 " class="button"></td>
			</tr>
		</table>
	</form>
	<%
	    }
	%>
</body>
</html>