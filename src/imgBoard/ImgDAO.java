package imgBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utility.DBClose;
import utility.DBOpen;

public class ImgDAO {
	public List<ImgDTO> list(Map map) {
		List<ImgDTO> list = new ArrayList<>();
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (int) map.get("sno");
		int eno = (int) map.get("eno");
		StringBuffer sql = new StringBuffer();
		sql.append(" select imgno, name, title, wdate, fname, indent, r ");
		sql.append(" from( ");
		sql.append("    select imgno, name, title, wdate, fname, indent, rownum as r ");
		sql.append("    from( ");
		sql.append("      select imgno, name, title, wdate, fname, indent ");
		sql.append("      from img ");
		if (word.trim().length() > 0) {
			sql.append("  where " + col + " like '%' || ? || '%' ");
		}
		sql.append("      order by grpno desc, ansnum asc ");
		sql.append("    ) ");
		sql.append(" ) where r >= ? and r <= ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if (word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ImgDTO dto = new ImgDTO();
				dto.setImgno(rs.getInt("imgno"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

public int total(Map map) {
		int total = 0;
		String col = (String) map.get("col");
		String word = (String) map.get("word");
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;	
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) ");
		sql.append(" FROM img ");
		if (word.trim().length() > 0) {
			sql.append(" where " + col + " LIKE '%' || ? || '%' ");
		}
		try {
			pstmt = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0) {
				pstmt.setString(1, word);
			}
			rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}		
		return total;
	}

	public ImgDTO read(int imgno) {
		ImgDTO dto = null;
		
		Connection conn = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select imgno, name, title, content, to_char(wdate,'yyyy-mm-dd') wdate, fname ");
		sql.append(" from img ");
		sql.append(" where imgno=? ");
		
		try {
			pstmt= conn.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new ImgDTO();
				dto.setImgno(rs.getInt("imgno"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
			}
		} catch (SQLException e) {
			System.out.println(
					"==============================ImgDAO::read()::prepareStatement memory loading fail...");
			e.printStackTrace();
		}finally{
			DBClose.close(rs, pstmt, conn);
		}
		
		return dto;
	}
	
	public Map fileList(int imgno) {
		Map map = new HashMap<>();

		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(imgno,2)     over (order by imgno) pre_imgno2,   ");
		sql.append("          lag(imgno,1)     over (order by imgno ) pre_imgno1,  ");
		sql.append("          imgno, ");
		sql.append("          lead(imgno,1)    over (order by imgno) nex_imgno1,   ");
		sql.append("          lead(imgno,2)    over (order by imgno) nex_imgno2,   ");
		sql.append("          lag(fname,2)  over (order by imgno) pre_file2,    ");
		sql.append("          lag(fname,1)  over (order by imgno ) pre_file1, ");
		sql.append("          fname,  ");
		sql.append("          lead(fname,1) over (order by imgno) nex_file1, ");
		sql.append("          lead(fname,2) over (order by imgno) nex_file2  ");
		sql.append("          from (  ");
		sql.append("               SELECT imgno, fname   ");
		sql.append("               FROM img ");
		sql.append("               where ansnum=0  ");
		sql.append("               ORDER BY imgno DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE imgno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				map.put("1n", rs.getInt("pre_imgno2"));
				map.put("1f", rs.getString("pre_file2"));
				map.put("2n", rs.getInt("pre_imgno1"));
				map.put("2f", rs.getString("pre_file1"));
				map.put("3n", rs.getInt("imgno"));
				map.put("3f", rs.getString("fname"));
				map.put("4n", rs.getInt("nex_imgno1"));
				map.put("4f", rs.getString("nex_file1"));
				map.put("5n", rs.getInt("nex_imgno2"));
				map.put("5f", rs.getString("nex_file2"));
			}
		} catch (SQLException e) {
			System.out.println(
					"==============================ImgDAO::fileList()::prepareStatement memory loading fail...");
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return map;
	}

	public boolean create(ImgDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into img ");
		sql.append(" (imgno, name, title, content, passwd, wdate, fname,grpno) ");
		sql.append(" values ");                                                
		sql.append(" ((select nvl(Max(imgno),0)+1 from img), ");
		sql.append(" ?,?,?,?,sysdate,?,(select nvl(Max(grpno),0)+1 from img)) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFname());
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	public ImgDTO readAns(int imgno) {
		ImgDTO dto = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT imgno, title, grpno, indent, ansnum ");
		sql.append(" FROM img ");
		sql.append(" WHERE imgno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ImgDTO();
				dto.setImgno(rs.getInt("imgno"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;
	}
	public void updateAnsnum(Map map) {
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int grpno = (Integer) map.get("grpno");
		int ansnum = (Integer) map.get("ansnum");
		sql.append(" update img ");
		sql.append(" set ansnum = ansnum + 1 ");
		sql.append(" where grpno = ?  ");
		sql.append(" and ansnum > ?  ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}
	public boolean createAns(ImgDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into img ");
		sql.append(" (imgno, name, title, content, passwd, wdate, fname, grpno,indent,ansnum,refnum) ");
		sql.append(" values ");
		sql.append(" ((select nvl(Max(imgno),0)+1 from img), ");
		sql.append(" ?,?,?,?,sysdate,?,?,?,?,?) ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFname());
			pstmt.setInt(6, dto.getGrpno());
			pstmt.setInt(7, dto.getIndent() + 1);
			pstmt.setInt(8, dto.getAnsnum() + 1);
			pstmt.setInt(9, dto.getImgno());

			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}
	

	public boolean update(ImgDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update img ");
		sql.append(" set ");
		sql.append(" name= ?, ");
		sql.append(" title= ?, ");
		sql.append(" content= ?, ");
		sql.append(" fname = ? ");
		sql.append(" where imgno= ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getFname());
			pstmt.setInt(5, dto.getImgno());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	public boolean delete(int imgno) {
		boolean flag = false;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from img ");
		sql.append(" where imgno= ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			
			int cnt = pstmt.executeUpdate();
			if(cnt > 0 ) flag= true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	public boolean checkPw(Map map){

		boolean flag = false;
		int imgno = (int)map.get("imgno");
		String passwd = (String)map.get("passwd");
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) ");
		sql.append(" from img ");
		sql.append(" where imgno = ? and passwd = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt(1);
			if(cnt > 0) flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return flag;
	}
	
	public boolean checkAn(int imgno){
		int cnt=0;
				
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*)  ");
		sql.append("  from img ");
		sql.append("  where refnum=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			rs = pstmt.executeQuery();
			rs.next();
			cnt =rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(
					"==============================ImgDAO::checkAn()::prepareStatement memory loading fail...");
		}finally {
			DBClose.close(rs, pstmt, con);
		}
				
		return cnt>0; //true ªË¡¶X
	}
}
