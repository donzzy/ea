package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSON;

public class BaseController {

	// 输出JSON化的content
	public void printJSON(Object content, HttpServletRequest req,
			HttpServletResponse rsp) throws IOException {
		req.setCharacterEncoding("utf-8");
		rsp.setCharacterEncoding("utf-8");
		PrintWriter out = rsp.getWriter();
		out.print(JSON.toJSONString(content));
		out.flush();
		out.close();
	}

	// 输出非JSON化的content
	public void print(Object content, HttpServletRequest req,
			HttpServletResponse rsp) throws IOException {
		req.setCharacterEncoding("utf-8");
		rsp.setCharacterEncoding("utf-8");
		PrintWriter out = rsp.getWriter();
		out.print(content.toString().trim());
		out.flush();
		out.close();
	}

}
