package org.pox.web;

import java.sql.Connection;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/config/dataSource-context.xml" })
public class DBTester {

	@Resource(name = "dataSource-MYSQL")
	private DataSource ds;

	@Test
	public void test() throws Exception {
		Connection con = ds.getConnection();
		System.out.println(con);
		con.close();
	}

}
