<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Stand
  Date: 2019-12-03
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <meta HTTP-EQUIV="Expires" CONTENT="0">
    <title>Search</title>
    <link rel="icon" href="../../../../../search/src/main/webapp/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="../../../../../search/src/main/webapp/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="../../../../../search/src/main/webapp/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="../../../../../search/src/main/webapp/css/font-awesome.min.css"/>
</head>
<script src="../../../../../search/src/main/webapp/js/jquery-3.3.1.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../../../search/src/main/webapp/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../../../search/src/main/webapp/js/vue.js" type="text/javascript" charset="utf-8"></script>
<!-- vue代码 -->
<script src="../../../../../search/src/main/webapp/js/ivue.js" type="text/javascript" charset="utf-8"></script>
<!-- 切换页面,便签,链接 -->
<script src="../../../../../search/src/main/webapp/js/index.js" type="text/javascript" charset="utf-8"></script>
<!-- 搜索结果自动补全 -->
<script src="../../../../../search/src/main/webapp/js/searchList.js" type="text/javascript" charset="utf-8"></script>
<!-- 登陆注册 -->
<script src="../../../../../search/src/main/webapp/js/login.js" type="text/javascript" charset="utf-8"></script>
<!-- 初始化 -->
<script src="../../../../../search/src/main/webapp/js/initial.js" type="text/javascript" charset="utf-8"></script>
<!-- 每日一言 -->
<script src="https://cdn.jsdelivr.net/npm/bluebird@3/js/browser/bluebird.min.js"></script>
<script src="../../../../../search/src/main/webapp/js/sentence.js" type="text/javascript" charset="utf-8"></script>
<body>
<!-- img从必应api中获取,每天更新 -->
<img src="http://api.dujin.org/bing/1920.php" id="bgimg">
<!-- filter:blur 解决给图片加滤镜时卡顿问题 -->
<img src="http://api.dujin.org/bing/1920.php" id="bgimg2">
<!-- 透明片 防止图片过于显眼 -->
<div id="imageTop"></div>
<!-- 模糊片 -->
<div id="image-blur"></div>
<div id="app">
    <div id="datetime">
				<span class="datetime" v-cloak>
					{{currentTime}}
				</span>
        <br>
        <span class="time_bottom"></span>
    </div>
    <div class="time_unclick">
        <!-- 百度搜索引擎api -->
        <form action="http://www.baidu.com/baidu" target="_self" id="baidu">
            <!-- AUTOCOMPLETE="off" 清除浏览器自带的下拉列表 -->
            <input type="text" name="word" size="40" id="search" AUTOCOMPLETE="off" placeholder="Search">
            <!-- 搜索结果补全 -->
            <ul id="languageList"></ul>
        </form>
        <section>
        </section>
        <footer>
            <div class="hitokoto">
                <!-- 每日一言 -->
                <p id="hitokoto"></p>
            </div>
        </footer>
        <div class="text-center" style="width:50%;position:fixed;bottom:1rem;line-height:2rem;">
            <a href="http://www.beian.miit.gov.cn" style="font-size:1rem;color:rgba(255,255,255,.5)">晋ICP备19011472号</a>
        </div>
    </div>

    <!-- 置顶便笺内容 -->
    <div class="top_note">
        <div>
            <p class="content"></p>
            <p class="note_date"></p>
            <span>×</span>
        </div>
    </div>

    <!-- 点击时间后 -->
    <div class="time_click">
        <!-- 文字链接 -->
        <div id="urls_word">
            <table>
                <tr>
                    <td><a href="https://fanyi.baidu.com/" target="_blank">翻译</a></td>
                    <td><a href="https://map.baidu.com/" target="_blank">地图</a></td>
                    <td><a href="https://email.163.com/" target="_blank">网易邮箱</a></td>
                    <td><a href="https://console.cloud.tencent.com/" target="_blank">腾讯云</a></td>
                </tr>
                <tr>
                    <td><a href="https://www.bilibili.com/" target="_blank">Bilibili</a></td>
                    <td><a href="https://github.com/" target="_blank">GitHub</a></td>
                    <td><a href="https://v4.bootcss.com/docs/4.3/getting-started/introduction/" target="_blank">bootstrap</a>
                    </td>
                    <td><a href="https://spring.io/projects/spring-framework#learn" target="_blank">spring</a></td>
                </tr>
                <tr>
                    <td><a href="https://mvnrepository.com/" target="_blank">mvnrepository</a></td>
                    <td><a href="https://cn.vuejs.org/v2/guide/" target="_blank">vue</a></td>
                    <td><a href="https://www.layui.com/" target="_blank">layui</a></td>
                    <td><a href="https://angular.cn/" target="_blank">angular</a></td>
                </tr>
            </table>
        </div>
        <!-- 便签 -->
        <div id="note_div">
            <ul class="note_history">
                <li class="create_new">
                    <i class="fa fa-plus"></i>新便笺
                </li>
            </ul>
            <textarea class="note write" rows="" cols="" placeholder="请输入一个新的便笺"></textarea>
            <div class="note_icons">
                <i class="fa fa-trash-o trash" title="删除该便笺"></i>
                <i class="fa fa-bell-o bell" title="固定到首页"></i>
            </div>
        </div>

        <!-- 链接/便签切换按钮 -->
        <div id="switch_buttons">
            <span class="active"></span>
            <span></span>
        </div>

        <!-- 图片链接 -->
        <div id="urls_img" class="container-fluid">
            <div class="row">
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
                <div class="col-3 col-md-1 url-img">+</div>
            </div>
            <div class="add_url">
                <div id="frmSetCustomNav">
                    <span class="popCaptionS">添加网站捷径</span>
                    <span class="btnCloseS" id="btnCloseFrmCusNav">×</span>
                    <input class="inputCustom" id="inputCustomUrl" placeholder="网址">
                    <input class="inputCustom" id="inputCustomTitle" placeholder="标题">
                    <div class="btnCustom" id="btnAddCusNav">添加</div>
                </div>
            </div>
        </div>

        <!-- 登陆注册 -->
        <input type="hidden" value="${sessionScope.currentUser.id}" id="checkLoginInput">
        <!-- 登陆成功后显示用户名 -->
        <c:choose>
            <c:when test="${sessionScope.currentUser != null}">
                <div class="login-user">
                    <button type="button" class="btn btn-link">
                            ${sessionScope.currentUser.username}
                    </button>
                    <ul class="user-option">
                        <li class="logout">
                            注销账户
                        </li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 登陆模态框 -->
                <button type="button" class="btn btn-link login-button" data-toggle="modal" data-target="#login">
                    登陆
                </button>

                <!-- Modal -->
                <div class="modal fade bd-example-modal-sm" id="login">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-body login-body">
                                <input type="text" class="form-control username" placeholder="用户名" AUTOCOMPLETE="off">
                                <div class="invalid-feedback message"></div>
                                <input type="password" class="password form-control" placeholder="密码" AUTOCOMPLETE="off">
                                <div class="invalid-feedback message"></div>
                                <button type="button" class="btn btn-success enter-button">登陆</button>
                                <button type="button" class="btn btn-secondary cancel" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 注册模态框 -->
                <button type="button" class="btn btn-link register-button" data-toggle="modal" data-target="#register">
                    注册
                </button>

                <!-- Modal -->
                <div class="modal fade bd-example-modal-sm" id="register">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-body register-body">
                                <input type="text" class="username form-control" placeholder="用户名" AUTOCOMPLETE="off">
                                <div class="invalid-feedback message"></div>
                                <input type="password" class="password form-control" placeholder="密码" AUTOCOMPLETE="off">
                                <div class="invalid-feedback message"></div>
                                <input type="password" class="repwd form-control" placeholder="再次输入密码" AUTOCOMPLETE="off">
                                <div class="invalid-feedback message"></div>
                                <button type="button" class="btn btn-success enter-button">注册</button>
                                <button type="button" class="btn btn-secondary cancel" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <!-- 登录注册成功弹出框 -->
        <div class="modal fade bd-example-modal-sm" id="message-modal">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-body message-body">
                        <i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>
                        <span class="sr-only">Loading...</span>
                        <h3 class="h-msg">注册成功</h3>
                        <p class="p-msg">2秒后自动跳转至登录页</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>