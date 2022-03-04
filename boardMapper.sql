-- 이클립스 xml 파일

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
  
<mapper namespace="boardMapper">
	
	<!-- # 게시글 작성 -->
	<insert id="insert" useGeneratedKeys="true" keyProperty="bno" parameterType="com.hyun.vo.BoardVO">
		<selectKey keyProperty="bno" resultType="int" order= "BEFORE">
			SELECT MP_BOARD_SEQ.NEXTVAL FROM DUAL
		</selectKey>
	   INSERT INTO MP_BOARD(    BNO 
	   					      , TITLE 
	   					      , CONTENT 
	   					      , WRITER  )
	                 VALUES(    #{bno} 
	                 		  , #{title}
	                 		  , #{content}
	                 		  , #{writer}  )
   </insert>

	<!-- # 게시글 목록 조회 -->   
	<select id="listPage" resultType="com.hyun.vo.BoardVO" parameterType="com.hyun.vo.SearchCriteria">
		SELECT  BNO, 
		        TITLE, 
		        WRITER, 
		        REGDATE
		 FROM ( 
		        SELECT BNO, 
		               TITLE, 
		               CONTENT, 
		               WRITER, 
		               REGDATE, 
		               ROW_NUMBER() OVER(ORDER BY BNO DESC) AS RNUM
		         FROM MP_BOARD
		         WHERE 1=1
		         <include refid = "search"></include>
		                       )
		WHERE RNUM BETWEEN #{rowStart} AND #{rowEnd}
		ORDER BY BNO DESC
	</select>
	
	<!-- # 게시물 총 갯수 -->
	<select id="listCount" resultType="int" parameterType="com.hyun.vo.SearchCriteria">
		SELECT COUNT(BNO)
		FROM MP_BOARD
		WHERE 1=1
		<include refid="search"></include>
		AND BNO > 0
	</select>
	
	<!-- # 검색 조건 -->
	<sql id="search">
		<if test="searchType != null">
			<if test="searchType == 't'.toString()">AND TITLE LIKE '%' || #{keyword} || '%'</if>
			<if test="searchType == 'c'.toString()">AND CONTENT LIKE '%' || #{keyword} || '%'</if>
			<if test="searchType == 'w'.toString()">AND WRITER LIKE '%' || #{keyword} || '%'</if>
			<if test="searchType == 'tc'.toString()">AND (TITLE LIKE '%' || #{keyword} || '%') or (CONTENT LIKE '%' || #{keyword} || '%')</if>
		</if>
	</sql>
	
	<!-- # 특정 게시글 조회 -->
	<select id="read" parameterType="int" resultType="com.hyun.vo.BoardVO">
		SELECT	BNO
			  , TITLE
			  , CONTENT
			  , WRITER
			  , REGDATE
		 FROM MP_BOARD
		 WHERE BNO = #{bno}
	</select>
	
	<!-- # 게시글 수정 -->
	<update id="update" parameterType="com.hyun.vo.BoardVO">
		UPDATE MP_BOARD
		   SET TITLE    =   #{title},
		   	   CONTENT  =   #{content}
		 WHERE BNO = #{bno} 
	</update>
	
	<!-- # 게시글 삭제 -->
	<delete id="delete" parameterType="int">
		DELETE 
		  FROM MP_BOARD
		 WHERE BNO = #{bno}
	</delete>
	
	<!-- # 첨부파일 업로드 -->
	<insert id="insertFile" parameterType="hashMap">
		INSERT INTO MP_FILE(
			FILE_NO,
			BNO,
			ORG_FILE_NAME,
			STORED_FILE_NAME,
			FILE_SIZE
		)VALUES(
			SEQ_MP_FILE_NO.NEXTVAL,
			#{BNO},
			#{ORG_FILE_NAME},
			#{STORED_FILE_NAME},
			#{FILE_SIZE}
		)
    </insert>
    
    <!-- # 첨부파일 조회 -->
    <select id="selectFileList" parameterType="int" resultType="hashMap">
    	SELECT FILE_NO,
    		   ORG_FILE_NAME,
    		   ROUND(FILE_SIZE/1024,1) AS FILE_SIZE
    	FROM MP_FILE
    	WHERE BNO = #{BNO} AND DEL_GB = 'N'
    </select>
	
</mapper>
