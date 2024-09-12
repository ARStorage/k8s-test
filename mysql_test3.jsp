<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>

<html>
<head>
    <title>Test Table Data (WAS 1 Server)</title>
</head>
<body>

<h2>WAS SERVER 1</h2>
<h2>Data from testTable</h2>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // 직접 JDBC URL로 연결
        String url = "jdbc:mysql://mysql-test-svc:3306/testdb";
        String username = "user_02";
        String password = "1111";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        stmt = conn.createStatement();

        // form data input
        String idInput = request.getParameter("idInput");
        String nameInput = request.getParameter("nameInput");
        String statusInput = request.getParameter("statusInput");

        if (idInput != null && nameInput != null && statusInput != null) {
            String insertSQL = "INSERT INTO testTable (id, name, status) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(insertSQL);
            pstmt.setInt(1, Integer.parseInt(idInput));
            pstmt.setString(2, nameInput);
            pstmt.setString(3, statusInput);
            pstmt.executeUpdate();
            pstmt.close();
        }

        // select all table data
        String sql = "SELECT id, name, status FROM testTable";
        rs = stmt.executeQuery(sql);

        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Name</th><th>Status</th></tr>");

        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String status = rs.getString("status");

            out.println("<tr>");
            out.println("<td>" + id + "</td>");
            out.println("<td>" + name + "</td>");
            out.println("<td>" + status + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

  
<h2>Enter New Data</h2>
<form action="mysql_test3.jsp" method="post">
    <label for="idInput">ID:</label>
    <input type="text" id="idInput" name="idInput" required><br>

    <label for="nameInput">Name:</label>
    <input type="text" id="nameInput" name="nameInput" required><br>

    <label for="statusInput">Status:</label>
    <input type="text" id="statusInput" name="statusInput" required><br>

    <input type="submit" value="Enter">
</form>



</body>
</html>
