package com.uyiku.imageupload.controller;

import com.github.pagehelper.PageInfo;
import com.uyiku.imageupload.entity.Computer;
import com.uyiku.imageupload.service.ComputerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
public class ComputerController {
    @Autowired
    ComputerService computerService;

    @RequestMapping("/All")
    public String queryAll(
            @RequestParam(required = false) Integer page,
            @RequestParam(required = false) Integer pageSize,
            HttpSession session){

        if(page == null)
            page=1;
        if(pageSize == null)
            pageSize=5;

        PageInfo<Computer> pageInfo = computerService.find(page, pageSize);

        int pageNum = pageInfo.getPageNum();
        System.out.println("当前第"+pageNum+"页");

        session.setAttribute("pageInfo",pageInfo);
        session.setAttribute("page",page);
        session.setAttribute("pageSize",pageSize);

        return "/index.jsp";
    }

    @RequestMapping("/add")
    public String insert(HttpSession session, Computer computer, MultipartFile img1) throws Exception {
        // 1. img1就是上传文件的名称
        // 2. 将img保存在computer对象中的image属性中
        // filename = 图片名字
        String filename = img1.getOriginalFilename();

        // 截取文件后缀名
        int x = filename.lastIndexOf(".");
        String ext = "";
        if(x > -1){
            ext = filename.substring(x); // .jpg  .png
        }

        if (img1.getSize() > 1024 * 1024 * 5)
            throw new Exception("图片最大支持5M大小");

        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        // 给上传的文件名重新取一个唯一的名字，避免重名的图片被替换
        filename = uuid+ext;
        System.out.println("添加图片："+filename);

        //文件的保存路径
        String path = "/img/"+filename;
        computer.setImage(filename);
        System.out.println(path);
        //使用application对象将相对路径转换成对应的绝对路径
        ServletContext application = session.getServletContext();
        path = application.getRealPath(path);
        System.out.println(path);

        // 3. 将img保存在数据库表中
        computer.setImage(filename);
        computer.setMade_Date(new Date());
        computerService.insert(computer);

        // 4. 将img1保存在服务器
        File file = new File(path);
        img1.transferTo(file);

        return "redirect:/All";
    }

    @RequestMapping("/toEdit-{id}")
    public String toEdit(@PathVariable int id, Map<String, Object> map){
        Computer computer = computerService.toEdit(id);
        map.put("c",computer);
        return "/edit.jsp";
    }

    @RequestMapping("/edit")
    public String edit(HttpSession session, Computer computer, MultipartFile  img1) throws IOException {
        String filename = img1.getOriginalFilename();
        int x = filename.lastIndexOf(".");
        String ext = "";
        if(x > -1){
            ext = filename.substring(x); // .jpg  .png
        }

        String uuid = UUID.randomUUID().toString().replaceAll("-", "");

        filename = uuid+ext;
        System.out.println("修改图片："+filename);

        String path = "/img/"+filename;

        ServletContext application = session.getServletContext();
        path = application.getRealPath(path);

        computer.setMade_Date(new Date());
        if(x != -1) {
            computer.setImage(filename);
            computerService.edit(computer);
            File file = new File(path);
            img1.transferTo(file);
        }

        return "redirect:/All";
    }

    @RequestMapping("/del-{id}")
    public String del(@PathVariable int id, HttpSession session){
        Object page = session.getAttribute("page");
        computerService.del(id);
        return "redirect:/All";
    }
}
