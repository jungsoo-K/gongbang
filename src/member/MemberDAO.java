package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class MemberDAO {
	public String getFname(String id){
		String fname = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select fname ");
		sql.append(" from member");
		sql.append(" where id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				fname = rs.getString("fname");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return fname;
	}
	public String getGrade(String id){
		String grade = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select grade ");
		sql.append(" from member ");
		sql.append(" where id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				grade = rs.getString("grade");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return grade;
	}
	public boolean loginCheck(Map map){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id = (String)map.get("id");
		String passwd = (String)map.get("passwd");
		
		System.out.print(id +"  " + passwd);
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) ");
		sql.append(" FROM member ");
		sql.append(" WHERE id = ? AND passwd = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			rs.next();
			
			int cnt = rs.getInt(1);
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return flag;
	}
	public boolean delete(String id){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from member ");
		sql.append(" where id = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
				
		
		return flag;
	}
	public boolean update(MemberVO vo){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update member ");
		sql.append(" set tel = ?, ");
		sql.append(" 	 email = ?, ");
		sql.append(" 	 zipcode = ?, ");
		sql.append(" 	 address1 = ?, ");
		sql.append(" 	 address2 = ?, ");
		sql.append(" 	 job = ? ");
		sql.append(" where id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getTel());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getZipcode());
			pstmt.setString(4, vo.getAddress1());
			pstmt.setString(5, vo.getAddress2());
			pstmt.setString(6, vo.getJob());
			pstmt.setString(7, vo.getId());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	public boolean updatePw(Map map){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		String passwd = (String)map.get("passwd");
		String id = (String)map.get("id");
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET passwd = ? ");
		sql.append(" WHERE id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, passwd);
			pstmt.setString(2, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0)flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	public boolean updateFile(Map map){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		String fname = (String)map.get("fname");
		String id = (String)map.get("id");
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET fname = ? ");
		sql.append(" WHERE id = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, fname);
			pstmt.setString(2, id);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0)flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	public MemberVO read(String id){
		MemberVO dto = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * ");
		sql.append(" FROM member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				dto = new MemberVO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setJob(rs.getString("job"));
				dto.setMdate(rs.getString("mdate"));
				dto.setFname(rs.getString("fname"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return dto;
	}
	
	public int total(Map map){
		int total = 0;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) ");
		sql.append(" FROM member ");
		if(word.trim().length()>0)
			sql.append(" WHERE "+col+" LIKE '%'||?||'%' ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
			pstmt.setString(1, word);
			rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}	
		return total;
	}
	
	public List<MemberVO> list(Map map){
		List<MemberVO> list = new ArrayList<MemberVO>();
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT id, mname, tel, email, job, mdate, fname, r ");
		sql.append(" FROM( ");
		sql.append(" 	SELECT id, mname, tel, email, job, mdate, fname, rownum as r ");
		sql.append(" 	FROM( ");
		sql.append(" 		SELECT id, mname, tel, email, job, mdate, fname ");
		sql.append(" 		FROM member ");
		if(word.trim().length()>0)
			sql.append(" 		WHERE "+col+" LIKE '%'||?||'%' ");
		sql.append(" 		ORDER BY mdate DESC ");
		sql.append(" 	) ");
		sql.append("  )WHERE r>=? and r<=? ");
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				pstmt.setString(++i, word);
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO dto = new MemberVO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setJob(rs.getString("job"));
				dto.setMdate(rs.getString("mdate"));
				dto.setFname(rs.getString("fname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}		
		return list;
	}
	
	public boolean create(MemberVO dto){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade) ");
		
		sql.append(" VALUES(?,?,?,?,?,?,?,?,?,sysdate,?,'H') ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());
			pstmt.setString(10, dto.getFname());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	public boolean duplicateEmail(String email){
		boolean flag = false;
		
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(email) as cnt ");
		sql.append(" FROM member ");
		sql.append(" WHERE email=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int cnt = rs.getInt("cnt");
			
			if(cnt>0) flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return flag;
	}
	
		public boolean duplicateId(String id){
			boolean flag = false;
			
			Connection con = DBOpen.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT COUNT(id) as cnt ");
			sql.append(" FROM member ");
			sql.append(" WHERE id=? ");
			
			try {
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				int cnt = rs.getInt("cnt");
				
				if(cnt>0) flag = true;
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBClose.close(rs, pstmt, con);
			}
			
			return flag;
		}
	}

