# www/fs-portlet.tcl
ad_page_contract {
    The display logic for the fs portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -properties {
    
}

array set config $cf

set user_id [ad_conn user_id]

set list_of_folder_ids $config(folder_id)

set my_folder_id [lindex $list_of_folder_ids 0]

#foreach my_folder_id $list_of_folder_ids {
   
    db_multirow -local items select_files_and_folders {} {
        set package_id [db_string select_package_id {}]
        
#        set items(url) \
#                [dotlrn_community::get_url_from_package_id -package_id $package_id]
        
    }
#}

ad_return_template 
