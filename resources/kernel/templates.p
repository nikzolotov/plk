#cp1251#########################################################################
#	����� templates v1.5 23/03/2006
#	�����: �������� ������� | shurgalin@infolio.ru
################################################################################
#	���������� ������������ ������������������ ������������ XSL-��������
################################################################################
#	^templates::create[BASE_PATH]	- ������ ������ ������������������.
#	^templates::create[				- ������ ������ ������������������ c �����
#		BASE_PATH					     ������ � ������������������.
#	;
#		XSL_FILE_NAME
#	]
#	^OBJ.empty[]					- ���������� TRUE, ���� ������������������
#										�����, � ��������� ������ - FALSE.
#	^OBJ.clear[]					- ������� ������������������ ������.
#	^OBJ.add[XSL_FILE_NAME]			- �������� ���� � ������������������.
#	^OBJ.xdoc[]						- ���������� ������ ������ xdoc, � �������
#										��������� ���������� �� �������� ������
#										� ���������.
################################################################################
#	BASE_PATH			- ���� ������������ �������� ����� �������� �����������
#							� ������������������ ����� �������� (string)
#	XSL_FILE_NAME		- ��� ������������ ����� �������� (string)
################################################################################

@CLASS
templates

@create[_base_path;_file]
	$base_path[$_base_path]
	$files[^table::create{file}]
	^if(def $_file){ ^add[$_file] }

@empty[]
	$result(^if(def $files){0}{1})

@clear[]
	$files[^table::create{file}]

@add[_file][_node]
	^files.append{$_file}
	$result[]

@xdoc[][xslt]
	^if(def $base_path){
		$result[^xdoc::create[$base_path]{<?xml version="1.0" encoding="$request:charset"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">^if($files){^files.menu{<xsl:import href="$files.file"/>}}</xsl:stylesheet>}]
	}{
		$result[^xdoc::create{<?xml version="1.0" encoding="$request:charset"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">^if($files){^files.menu{<xsl:import href="$files.file"/>}}</xsl:stylesheet>}]
	}