<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>考试预约系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="css/menu.css">
	<link rel="stylesheet" href="easyui/themes/metro/easyui.css">   
    <link rel="stylesheet" href="easyui/themes/icon.css">
	<link rel="stylesheet" href="layui/css/layui.css">
	
	<script src="js/jquery-3.1.1.js"></script>
	<script src="easyui/jquery.easyui.min.js"></script>
	<script src="layui/layui.js"></script>
	<script src="zTree/js/jquery.ztree.all.js"></script>

  </head>
  
  <body id="all" class="easyui-layout ">
    <div  data-options="region:'north',style:{borderWidth:0},border:false" style="height:50px;">
    <div style="height:45px;background-color: #fff;border-bottom:5px solid #009688;"></div>
    </div>
    <div  data-options="region:'west',collapsed:false,style:{borderWidth:0},border:false" style="padding:0px;width:200px;overflow:hidden;background-color:#383D49;">
       <ul class="ztree_menu" id="menu"></ul>
    </div>
    <div id="main" data-options="region:'center',style:{borderWidth:0},border:false" style="padding:0px;overflow: hidden;" >
       <div data-options="fit:true, narrow:true,style:{borderWidth:0},border:false" tabHeight="35px" id="tab_add" class="easyui-tabs" style="height: 100%;" >   
         <div title="首页" style="overflow: hidden;"> 
           <iframe frameborder="0" src="/view" style="width:100%;height:100%;"></iframe>
         </div>   
       </div> 
    </div>
  </body>
  <script type="text/javascript">
  var setting_menu = {
  		   async: {
				enable: true,
				url: "menu/getMenu",
				type :"post",
				dataType: "json",
				autoParam: ["id","pId","name"],
			},
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pId",
					rootPId: 0,
				}
			},
  			view: {
  				showLine: false,	
  				selectedMulti: false,
  				dblClickExpand: false,
  				showIcon: true,
  				showTitle: false,
  				autoCancelSelected: false
  			},
  			callback: {
  				beforeClick: menu_beforeClick,
  				onClick: menu_OnClick,
  				onAsyncSuccess:menuOnAsyncSuccess,
  				beforeExpand: menu_BeforeExpand,
  			},
  	};     
	  var menuZtree = $.fn.zTree.init($("#menu"), setting_menu);
	  function menuOnAsyncSuccess(event,treeNode, msg) {
		  //$("#main").html("<button ></button>");

     }	  
	  function menu_OnClick(event, treeId, treeNode){
		  //menuId = treeNode.id;
 		  var href;
 		  var title = treeNode.name;
 		  if(treeNode.link==null || treeNode.link==""){
 			href = '<%=path%>/view/urlcheck'; 
 		  }else{
 				href = '<%=path%>/view/'+treeNode.link;
 		   }
 		  tabAdd(title,href);
 	    	
	  }
	  function tabAdd(title,href){
		  if ($('#tab_add').tabs('exists', title)){
	  	        $('#tab_add').tabs('select',title);
	  	      }
		  else{
			  $('#tab_add').tabs('add',{    
	  	      	    title:title,
	  	            content:"<iframe frameborder=\"0\" src='"+href+"' style=\"width:100%;height:100%;\"></iframe>",   
	  	            closable:true,
	  	      	});
			   //绑定双击tab事件
	  	      $('#tab_add').tabs('bindDblclick', function(index, title){
	  		    	//alert(index);
	  		    	if(index!=0)
	  		    	$('#tab_add').tabs('close',index);
	  		    });    	
		  }
	    	  
	  }
	  var expendNodeId;
	  function menu_beforeClick(treeId, treeNode) {  
			if (treeNode.level == 0) {	
				var zTree = $.fn.zTree.getZTreeObj("menu");
				zTree.expandNode(treeNode,null,false,true,true);
				expendNodeId = treeNode.id;
				return false;
			}
			
			return true;
		}
	  function menu_BeforeExpand(treeId, treeNode){
		  if(expendNodeId!=null){
			  var zTree = $.fn.zTree.getZTreeObj("menu");
			  var node = zTree.getNodesByParam("id", expendNodeId);
			  zTree.expandNode(node[0],false,false,false,false);
		  }
			  
	  }
	  
     
	    
	
	//扩展双击事件
	$.extend($.fn.tabs.methods, {
	    /**
	     * 绑定双击事件
	     * @param {Object} jq
	     * @param {Object} caller 绑定的事件处理程序
	     */
	    bindDblclick: function(jq, caller){
	        return jq.each(function(){
	            var that = this;
	            $(this).children("div.tabs-header").find("ul.tabs").undelegate('li', 'dblclick.tabs').delegate('li', 'dblclick.tabs', function(e){
	                if (caller && typeof(caller) == 'function') {
	                    var title = $(this).text();
	                    var index = $(that).tabs('getTabIndex', $(that).tabs('getTab', title));
	                    caller(index, title);
	                }
	            });
	        });
	    },	  
	});
  </script>
</html>
