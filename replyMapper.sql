<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="replyMapper">

	<!-- # ´ñ±Û Á¶È¸ -->
	<select id="readReply" resultType="com.hyun.vo.ReplyVO">
    	SELECT
    		  RNO, CONTENT, WRITER, REGDATE
    	 FROM MP_REPLY
    	WHERE BNO = #{bno}
	</select>
 
	<!-- # ´ñ±Û ÀÛ¼º -->
	<insert id="writeReply">
	INSERT INTO MP_REPLY(
							  BNO
							, RNO
							, CONTENT
							, WRITER
						  				)
				  VALUES(	 #{bno}
				  		   , MP_REPLY_SEQ.NEXTVAL
				  		   , #{content}
				  		   , #{writer}	)
	</insert>
	
	<!-- # ´ñ±Û ¼öÁ¤ -->
	<update id="updateReply" parameterType="com.hyun.vo.ReplyVO">
		UPDATE MP_REPLY SET CONTENT = #{content}
		WHERE RNO = #{rno}
	</update>

	<!-- # ´ñ±Û »èÁ¦ -->
	<delete id="deleteReply" parameterType="com.hyun.vo.ReplyVO">
		DELETE FROM MP_REPLY
		WHERE RNO = #{rno}
	</delete>
	
	<!-- # ¼±ÅÃµÈ ´ñ±Û Á¶È¸ -->
	<select id="selectReply" resultType="com.hyun.vo.ReplyVO">
		SELECT
				BNO
			  , RNO
			  , CONTENT
			  , WRITER
			  , REGDATE
		  FROM MP_REPLY
		 WHERE RNO = #{rno}
	</select>
	
</mapper>