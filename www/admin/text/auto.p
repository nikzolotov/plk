@auto[]
#	� ������� ����� �������, ����� �������� ���������� ��� ��������������
	^update_navigation[$TEMPLATES_DIR/admin/text_transform_navigation.xslt]

######################################################################################################
# ��������� � � �������� ���� ��������� (������ text) ���������� �������� ����� ���������
@update_navigation[_stylesheet][main_navigation;tmp;parent;key;value;text_navigation;i]
	$parent[^Navigation.documentElement.selectSingle[//item[@module = 'text']]]
	
	$main_navigation[^xdoc::load[$RESOURCES_DIR/navigation.xml]]
	$text_navigation[^main_navigation.transform[$_stylesheet]]
	^for[i](0;$text_navigation.documentElement.childNodes - 1){
		$tmp[^parent.appendChild[^Navigation.importNode[$text_navigation.documentElement.childNodes.[$i]](100)]]]
	}