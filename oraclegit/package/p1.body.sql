
  CREATE OR REPLACE PACKAGE BODY "ORACLEGIT"."P1" 
as
procedure pp1
as
begin
dbms_output.put_line('proc1');
end pp1;
end p1;