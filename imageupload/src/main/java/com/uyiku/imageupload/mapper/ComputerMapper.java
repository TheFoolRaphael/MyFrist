package com.uyiku.imageupload.mapper;

import com.github.pagehelper.Page;
import com.uyiku.imageupload.entity.Computer;
import org.apache.ibatis.annotations.*;
import org.apache.commons.lang.StringUtils;

import java.util.List;

public interface ComputerMapper {

    @Select("select * from computer")
    Page<Computer> select();

    @Insert("insert into computer(name,image,price,remark,made_Date) " +
            "values(#{name},#{image},#{price},#{remark},#{made_Date})")
    void insert(Computer computer);

    @Select("select * from computer where id=#{id}")
    Computer selectById(int id);
    @UpdateProvider(type = computerUpdateProvider.class, method = "getUpdateSql")
    void update(Computer c);

    @Delete("delete from computer where id=#{id}")
    void delete(int id);

    class computerUpdateProvider {
        public String getUpdateSql(Computer c){
            StringBuilder sb = new StringBuilder("update computer set ");
            if(!StringUtils.isBlank(c.getName())){
                sb.append("name=#{name},");
            }
            if(!StringUtils.isBlank(c.getImage())){
                sb.append("image=#{image},");
            }
            if(c.getPrice() != null){
                sb.append("price=#{price},");
            }
            if(!StringUtils.isBlank(c.getRemark())){
                sb.append("remark=#{remark},");
            }
            if(c.getMade_Date() != null){
                sb.append("made_date=#{made_Date},");
            }
            sb.deleteCharAt(sb.length()-1);
            sb.append(" where id=#{id}");
            return sb.toString();
        }
    }
}
