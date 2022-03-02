--1. ÷������ ���ε� ���̺�

CREATE TABLE MP_FILE(
    FILE_NO NUMBER,        -- ���Ϲ�ȣ
    BNO NUMBER NOT NULL,    -- �Խ��� ��ȣ
    ORG_FILE_NAME VARCHAR2(260) NOT NULL,   -- ���� ���� �̸�
    STORED_FILE_NAME VARCHAR2(36) NOT NULL, -- ����� ���� �̸�
    FILE_SIZE NUMBER,       -- ���� ũ��
    REGDATE DATE DEFAULT SYSDATE NOT NULL,  -- ���� �����
    DEL_GB VARCHAR2(1) DEFAULT 'N' NOT NULL,  -- ��������
    PRIMARY KEY(FILE_NO)        -- �⺻Ű FILE_NO
);

CREATE SEQUENCE SEQ_MP_FILE_NO
START WITH 1
INCREMENT BY 1
NOMAXVALUE NOCACHE;

