# fs-portlet/www/fs-portlet.tcl

ad_page_contract {
    The display logic for the fs portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -properties {
    folders:multirow
}

array set config $cf
set user_id [ad_conn user_id]
set list_of_folder_ids $config(folder_id)

# set up the multirow datasource using the db_multirow proc and 1 id
set my_folder_id [lindex $list_of_folder_ids 0]

db_multirow -local folders select_files_and_folders {} {

    # we can set array vars for this row
    set folders(url) [site_nodes::get_url_from_package_id \
        -package_id [db_string select_package_id {}] \
    ]       

}

foreach my_folder_id [lrange $list_of_folder_ids 1 end] {  

    # use the append switch to add rows to the datasource
    db_multirow -local -append folders select_files_and_folders {} {        
        set folders(url) [site_nodes::get_url_from_package_id \
            -package_id [db_string select_package_id {}] \
        ]        
    }

}

ad_return_template 
