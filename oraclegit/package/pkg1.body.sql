
  CREATE OR REPLACE PACKAGE BODY "ORACLEGIT"."PKG1" 
as
procedure pp1
as
begin
dbms_output.put_line('pkg1 proc1');
end pp1;
end pkg1;