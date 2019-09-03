package com.nicolas.ocp6.consumer.impl.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.sql.DataSource;


public abstract class AbstractDaoImpl {

    @Autowired
    @Qualifier("dataSource")
    private DataSource dataSource;    /*DataSource is an interface! */

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public DataSource getDataSource() {
        return dataSource;
    }
}