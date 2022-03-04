--1. DB ���̺� MP_MEMBER ����
CREATE TABLE MP_MEMBER (
    USERID VARCHAR2(40) NOT NULL,
    USERPASS VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(40) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(USERID)
);

----------------------------------------------------

--# ��Ŭ���� memberMapper.xml

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="memberMapper">
	<!-- # ȸ������ -->
	<insert id="register">
		INSERT INTO MP_MEMBER ( USERID
								, USERPASS
								, USERNAME)
						VALUES( #{userId}
								,#{userPass}
								,#{userName})
	</insert>
	
	<!-- # �α��� -->
	<select id="login" resultType="com.hyun.vo.MemberVO">
		SELECT USERID, USERPASS, USERNAME
		  FROM MP_MEMBER
		 WHERE USERID = #{userId}
		  <!-- AND USERPASS = #{userPass} -->
	</select>
	
	<!-- # ȸ������ ���� -->
	<update id="memberUpdate">
		UPDATE MP_MEMBER 
		SET 
		USERNAME = #{userName}
		WHERE USERID = #{userId}
	</update>
	
	<!-- # ȸ�� Ż�� -->
	<delete id="memberDelete">
		DELETE FROM MP_MEMBER
		WHERE USERID = #{userId}
	</delete>
	
	<!-- # �н����� üũ -->
	<select id="passChk" resultType="int">
		SELECT COUNT(*) FROM MP_MEMBER
		WHERE USERID = #{userId}
		AND USERPASS = #{userPass}
	</select>
	
	<!-- # ���̵� �ߺ� üũ -->
	<select id="idChk" resultType="int">
		SELECT COUNT(*) FROM MP_MEMBER
		WHERE USERID = #{userId}
	</select>
</mapper>
