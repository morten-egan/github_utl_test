
  CREATE OR REPLACE FUNCTION "ORACLEGIT"."GET_CLOB_FROM_BASE64_STRING" (p_clob CLOB)
RETURN clob

IS
	l_chunk clob; --Chunks of decoded blob that'll be appended
	l_result clob; --Final blob result to be returned
	l_rawout RAW (32767); --Decoded raw data from first pass decode
	l_rawin RAW (32767); --Encoded raw data chunk
	l_amt NUMBER DEFAULT 7700;
	--Default length of data to decode
	l_offset NUMBER DEFAULT 1;
	--Default Offset of data to decode
	l_tempvarchar VARCHAR2 (32767);
BEGIN
	BEGIN
		DBMS_LOB.createtemporary (l_result, FALSE, DBMS_LOB.CALL);
		DBMS_LOB.createtemporary (l_chunk, FALSE, DBMS_LOB.CALL);
		LOOP
			DBMS_LOB.READ (p_clob, l_amt, l_offset, l_tempvarchar);
				l_offset := l_amt + l_offset;
				l_rawin := UTL_RAW.cast_to_raw (l_tempvarchar);
				l_rawout := UTL_ENCODE.base64_decode (l_rawin);
				l_chunk := utl_raw.cast_to_varchar2(l_rawout);
			DBMS_LOB.append (l_result, l_chunk);
		END LOOP;
		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				NULL;
	END;

	return l_result;

end get_clob_from_base64_string;