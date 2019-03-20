package com.uyiku.imageupload.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.uyiku.imageupload.entity.Computer;
import com.uyiku.imageupload.mapper.ComputerMapper;
import com.uyiku.imageupload.service.ComputerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComputerServiceImpl implements ComputerService {
    @Autowired
    ComputerMapper computerMapper;

    @Override
    public PageInfo<Computer> find(int page, int pageSize) {
        PageHelper.startPage(page,pageSize);
        Page<Computer> page1 = computerMapper.select();
        return new PageInfo<>(page1);
    }

    @Override
    public void insert(Computer computer) {
        computerMapper.insert(computer);
    }

    @Override
    public void del(int id) {
        computerMapper.delete(id);
    }

    @Override
    public Computer toEdit(int id) {
        return computerMapper.selectById(id);
    }

    @Override
    public void edit(Computer computer) {
        computerMapper.update(computer);
    }
}
