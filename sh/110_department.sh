rails g scaffold department \
 uid name \
 worktype:references\
 upper_id:integer\
 is_stoped:boolean\
 memo:text\
 ou_id:integer\
 --force 