package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class BbsDAO {
	public int total(Map map){
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int total = 0;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) ");
		sql.append(" from bbs ");
		if(word.trim().length() > 0) 
			sql.append(" where "+ col +" like '%'||?||'%' ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length() > 0)
				pstmt.setString(1, word);
			
			rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return total;
	}
	public boolean getRefnum(int bbsno){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) ");
		sql.append(" from bbs ");
		sql.append(" where refnum = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
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
	public void upAnsnum(Map map){
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs  ");
		sql.append(" SET ansnum = ansnum + 1  ");
		sql.append(" WHERE grpno = ? and ansnum > ? ");
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}
	public boolean replyCreate(BbsVO vo){
		boolean flag= false;
		
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, grpno, indent, ansnum, refnum)   ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs),  ");
		sql.append(" ?,?,?,?, sysdate,?,?,?,?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getWname());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getPasswd());
			pstmt.setInt(5, vo.getGrpno());
			pstmt.setInt(6, vo.getIndent()+1);
			pstmt.setInt(7, vo.getAnsnum()+1);
			pstmt.setInt(8, vo.getBbsno());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	public BbsVO replyRead(int bbsno){
		BbsVO vo = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, title, grpno, indent, ansnum ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno = ?  ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				vo = new BbsVO();
				vo.setBbsno(rs.getInt("bbsno"));
				vo.setTitle(rs.getString("title"));
				vo.setGrpno(rs.getInt("grpno"));
				vo.setIndent(rs.getInt("indent"));
				vo.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return vo;
	}
	public boolean create(BbsVO vo){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, grpno)   ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs),  ");
		sql.append(" ?,?,?,?, sysdate, ");
		sql.append(" (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM bbs)) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getWname());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getPasswd());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public BbsVO read(int bbsno){
		BbsVO vo = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, content, viewcnt, wdate ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno = ?  ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				vo = new BbsVO();
				vo.setBbsno(rs.getInt("bbsno"));
				vo.setWname(rs.getString("wname"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setWdate(rs.getString("wdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return vo;
	}
	
	public boolean update(BbsVO vo){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs  ");
		sql.append(" SET wname=?, title=?, content=? ");
		sql.append(" WHERE bbsno = ?  ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getWname());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setInt(4, vo.getBbsno());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	public boolean delete(int bbsno){
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM bbs WHERE bbsno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public List<BbsVO> list(Map map){
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		List<BbsVO> list = new ArrayList<BbsVO>();
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, r ");
		sql.append(" 	from( ");
		sql.append(" 	SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, rownum as r ");
		sql.append(" 		FROM (  ");
		sql.append(" 		SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum ");
		sql.append(" 		FROM bbs ");
		if(word.trim().length() > 0)
			sql.append(" 	where "+ col +" like '%'||?||'%' ");
		sql.append(" 		ORDER BY grpno DESC, ansnum) ");
		sql.append(" 	) ");
		sql.append(" where r >= ? and r <= ? ");
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length() > 0)
				pstmt.setString(++i, word);
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BbsVO vo = new BbsVO();
				vo.setBbsno(rs.getInt("bbsno"));
				vo.setWname(rs.getString("wname"));
				vo.setTitle(rs.getString("title"));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setWdate(rs.getString("wdate"));
				vo.setGrpno(rs.getInt("grpno"));
				vo.setIndent(rs.getInt("indent"));
				vo.setAnsnum(rs.getInt("ansnum"));
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return list;
	}

	
	public boolean passwdCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(bbsno) ");
		sql.append(" from bbs ");
		sql.append(" where bbsno = ? and passwd = ? ");
		
		int bbsno = (Integer)map.get("bbsno");
		String passwd = (String)map.get("passwd");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
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
	
	public void upViewcnt(int bbsno){
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs  ");
		sql.append(" SET viewcnt = viewcnt + 1  ");
		sql.append(" WHERE bbsno = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}
}
