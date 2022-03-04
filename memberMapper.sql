--1. DB 테이블 MP_MEMBER 생성
CREATE TABLE MP_MEMBER (
    USERID VARCHAR2(40) NOT NULL,
    USERPASS VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(40) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(USERID)
);

----------------------------------------------------

--# 이클립스 memberMapper.xml

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="memberMapper">
	<!-- # 회원가입 -->
	<insert id="register">
		INSERT INTO MP_MEMBER ( USERID
								, USERPASS
								, USERNAME)
						VALUES( #{userId}
								,#{userPass}
								,#{userName})
	</insert>
	
	<!-- # 로그인 -->
	<select id="login" resultType="com.hyun.vo.MemberVO">
		SELECT USERID, USERPASS, USERNAME
		  FROM MP_MEMBER
		 WHERE USERID = #{userId}
		  <!-- AND USERPASS = #{userPass} -->
	</select>
	
	<!-- # 회원정보 수정 -->
	<update id="memberUpdate">
		UPDATE MP_MEMBER 
		SET 
		USERNAME = #{userName}
		WHERE USERID = #{userId}
	</update>
	
	<!-- # 회원 탈퇴 -->
	<delete id="memberDelete">
		DELETE FROM MP_MEMBER
		WHERE USERID = #{userId}
	</delete>
	
	<!-- # 패스워드 체크 -->
	<select id="passChk" resultType="int">
		SELECT COUNT(*) FROM MP_MEMBER
		WHERE USERID = #{userId}
		AND USERPASS = #{userPass}
	</select>
	
	<!-- # 아이디 중복 체크 -->
	<select id="idChk" resultType="int">
		SELECT COUNT(*) FROM MP_MEMBER
		WHERE USERID = #{userId}
	</select>
</mapper>
