package mapper;

import java.util.List;

import bean.Menu;
import tk.mybatis.mapper.common.Mapper;

public interface MenuMapper extends Mapper<Menu> {
	public List<Menu> getMenu();
}