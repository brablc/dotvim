let b:vimpipe_command="st-mysql st_cms -t"
if !empty($SSH_HOME)
	source ${SSH_HOME}/.dbextrc
endif
