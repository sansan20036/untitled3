#!/usr/bin/env python3
# coding=utf-8
# -*- coding: UTF-8 -*-
from flask import Flask, request
import MySQLdb
import os

app = Flask(__name__)

@app.route('/')
def index():
    form = """
    <form method="post" action="/action" >
        課程代碼：<input name="course_code">
        <input type="submit" value="查詢">
    </form>
    """
    return form

@app.route('/action', methods=['POST'])
def action():
    # 取得輸入的課程代碼
    course_code = request.form.get("course_code")

    conn = None
    cursor = None
    results = """
    <p><a href="/">Back to Query Interface</a></p>
    """

    try:
        # 建立資料庫連線
        conn = MySQLdb.connect(host="127.0.0.1",
                               user="student",
                               passwd="test1234",
                               db="testdb")



        # 欲查詢的 query 指令
        query = "SELECT Openingclass, Accountcode, Subjectname, Requiredelective, credit FROM class WHERE Courseselection = '{}'';".format(course_code)

        # 執行查詢
        cursor = conn.cursor()
        cursor.execute(query, (course_code,))

        # 取得並列出所有查詢結果
        for(Courseselection	,Openingclass,Accountcode,Subjectname,Requiredelective,credit) in cursor.fetchall():
            results += "<p>{} {} {} {} {} {}</p>".format(Courseselection,Openingclass,Accountcode,Subjectname,Requiredelective,credit)

#         row = cursor.fetchall()
#         if row:
#             results += str(row) + str(course_code)
# #             <p>開課班級: {row[0]}</p>
# #             <p>課程代碼: {row[1]}</p>
# #             <p>科目名稱: {row[2]}</p>
# #             <p>必修/選修: {row[3]}</p>
# #             <p>學分數: {row[4]}</p>
# #             """
#         else:
#             results += "<p>No results found.</p>"

    except MySQLdb.Error as e:
        results += f"<p>Database error: {e}</p>"

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

    return results

if __name__ == '__main__':
    app.run(debug=True)
