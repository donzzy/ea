package controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import bean.Menu;
import service.IMenuService;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController{
	@Resource
	private IMenuService menuService;
	
	@RequestMapping("/test")
	public String test(){
		return "/test";
	}
	@RequestMapping("/getMenu")
	public void getMenu(HttpServletRequest req,HttpServletResponse rsp) throws IOException{
		List<Menu> menu = menuService.getMenu();
		super.printJSON(menu, req, rsp);
	}

}
