package serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import mapper.MenuMapper;

import org.springframework.stereotype.Service;

import bean.Menu;
import service.IMenuService;

@Service
public class MenuServiceImpl implements IMenuService{

	@Resource
	private MenuMapper menuMapper;
	public List<Menu> getMenu() {
		return menuMapper.getMenu();
	
	}
}
