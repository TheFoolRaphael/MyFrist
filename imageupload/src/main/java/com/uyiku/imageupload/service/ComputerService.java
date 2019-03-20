package com.uyiku.imageupload.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.uyiku.imageupload.entity.Computer;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface ComputerService {
    PageInfo<Computer> find(int page, int pageSize);
    void insert(Computer computer);
    void del(int id);
    Computer toEdit(int id);
    void edit(Computer computer);
}
