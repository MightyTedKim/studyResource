# INSTALLATION

​        공식 문서를 따라하며 설치했었습니다. 참고하면 좋을만한 내용을 입력했습니다.

- <공식 문서: http://ora2pg.darold.net/documentation.html>

- <참고 사이트: https://dbvisit.atlassian.net/wiki/spaces/ugd9/pages/333414402/Data+Instantiation+for+PostgreSQL+step-by-step+guide>

  

## Requirement

The Oracle Instant Client or a full Oracle instaaltion must be installed on the system. You can download the RPM from Oracle download center:

```
    rpm -ivh oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
    rpm -ivh oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
    rpm -ivh oracle-instantclient12.2-jdbc-12.2.0.1.0-1.x86_64.rpm
    rpm -ivh oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm
```

---

- 요약: 오라클 client가 설치되어 있어야 합니다.

- 파일 다운로드
  - 설명: 오라클 홈페이지에서 파일 받기
  - <링크: https://www.oracle.com/technetwork/apps-tech/linuxx86-64soft-092277.html>

- 설치
  - rpm으로 실행 후 DBD:Oracle을 perl로 설치



## Installing Ora2Pg

Like any other Perl Module Ora2Pg can be installed with the following commands:

```
        tar xjf ora2pg-x.x.tar.bz2
        cd ora2pg-x.x/
        perl Makefile.PL
        make && make install
```

---



아래처럼 설치합니다.

```
`[root``@target11g` `~]# mkdir download; cd download``[root``@target11g` `~]# wget https:``//sourceforge.net/projects/ora2pg/files/18.2/ora2pg-18.2.tar.bz2``[root``@target11g` `~]# bzip2 -d ora2pg*.bz2``[root``@target11g` `~]# tar xvf ora2pg*``[root``@target11g` `~]# cd ora2pg*``[root``@target11g` `~]# perl Makefile.PL``[root``@target11g` `~]# make && make install``[root``@target11g` `~]# cd ../..; rm -rf download`
```

## Installing DBD::Oracle

```
        export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
        export ORACLE_HOME=/usr/lib/oracle/12.2/client64/lib
        perl -MCPAN -e 'install DBD::Oracle'
```

---



- PATH 설정하고 실행하라는 내용입니다.

  - 하지만 제가 했을 때는 SDK 오라클 클라이언트 PATH를 찾지 못해 오류가 났습니다.

- PATH 설정

  ```
  cd ;
  vi .bash_profile
  
  export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
  export ORACLE_HOME=/usr/lib/oracle/12.2/client64/lib
  ```

- 설치

  ```
  perl -MCPAN -e 'install DBD::Oracle'
  ```

  - 한줄씩 실행하고 싶으면 

  ```
  #perl -MCPAN -e shell
  cpan> get DBD::Oracle
  cpan> quit
  cd ~/.cpan/build/DBD-Oracle*
  export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib
  export ORACLE_HOME=/usr/lib/oracle/11.2/client64/lib
  perl Makefile.PL
  make
  make install
  ```

  - 오류
    - 원인: SDK 파일을 찾지 못해 오류가 나옴
      - Makefile.PL에서 ctrl+f  "For Instant Client that means the SDK package"
      - <링크: https://github.com/gwenshap/DBD-Oracle/blob/master/Makefile.PL>

  ```
  WARNING: Could not determine Oracle client version, defaulting to
  version 9.2.0.4.0. Some features of DBD::Oracle may not work.
  Oracle version-based logic in Makefile.PL may produce erroneous
  results. You can use "perl Makefile.PL -V X.Y.Z" to specify your
  client version.
  
  Oracle Version 9.2.0.4.0 (9.2)
  Looks like an Instant Client installation, okay
  You don't have a libclntsh.so file, only /usr/lib/oracle/12.2/client64/lib/libclntsh.so.12.1
  So I'm going to create a /usr/lib/oracle/12.2/client64/lib/libclntsh.so symlink to /usr/lib/oracle/12.2client64/lib/libclntsh.so.12.1
  Your LD_LIBRARY_PATH env var is set to '/usr/lib/oracle/12.2/client64/lib'
  Oracle sysliblist:
  
  
  *********************************************************
  I can't find the header files I need in your Oracle installation.
  You probably need to install some more Oracle components.
  For Instant Client that means the SDK package.
  I'll keep going, but the compile will probably fail.
  See the appropriate troubleshooting guide for your OS for more information.
  *********************************************************
  
  ```

- SDK를 zip으로 풀고, PATH 설정

  -  다운로드

    - instantclient-sdk-linux.x64-12.2.0.1.0.zip

    - <링크: https://www.oracle.com/technetwork/apps-tech/linuxx86-64soft-092277.html>

```
unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip
cd instantclient_12_2/sdk/include 
```

- oci.h를 못찾아서 문제 생긴 부분 해결
  
    ```
    cd ;
    vi .bash_profile
    
    export C_INCLUDE_PATH=/root/oracleClient/instantclient_12_2/sdk/include
    ```


​    

    - 설치
      - perl로 한줄씩 실행하면 나눠서 볼 수 있음
        - make에서 warning이 뜨지만 설치는 가능
      - PATH는 bash_profile에서 잡았기 때문에 생략합니다.
    
    ```
    #perl -MCPAN -e shell
    cpan> get DBD::Oracle
    cpan> quit
    cd ~/.cpan/build/DBD-Oracle*
    ## export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib
    ## export ORACLE_HOME=/usr/lib/oracle/11.2/client64/lib
    perl Makefile.PL
    make
    make install
    ```


​    
