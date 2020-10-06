ad_library {
    Automated tests for the fs-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        fs_admin_portlet::link
        fs_portlet::link
        fs_contents_portlet::link
    } -cats {
        api
        production_safe
    } fs_portlet_links {
        Test diverse link procs.
} {
    aa_equals "FS admin portlet link"       "[fs_admin_portlet::link]" ""
    aa_equals "FS portlet link"             "[fs_portlet::link]" ""
    aa_equals "FS contents portlet link"    "[fs_contents_portlet::link]" ""
}

aa_register_case -procs {
        fs_portlet::get_pretty_name
        fs_admin_portlet::get_pretty_name
        fs_contents_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } fs_portlet__names {
        Test diverse name procs.
} {
    set pretty_name [parameter::get_from_package_key -package_key [fs_portlet::my_package_key] -parameter pretty_name]
    aa_equals "Pretty name" "[fs_portlet::get_pretty_name]" "$pretty_name"
    aa_equals "Admin pretty name" "[fs_admin_portlet::get_pretty_name]" "#fs-portlet.lt_File_Storage_Administ#"
    aa_true "Contents pretty name should return an error" "[catch {fs_contents_portlet::get_pretty_name}]"
}

aa_register_case -procs {
        fs_portlet::add_self_to_page
        fs_portlet::remove_self_from_page
        fs_contents_portlet::add_self_to_page
        fs_contents_portlet::remove_self_from_page
        fs_admin_portlet::add_self_to_page
        fs_admin_portlet::remove_self_from_page
    } -cats {
        api
    } fs_portlet_add_remove_from_page {
        Test add/remove portlet procs.
} {
    #
    # Helper proc to check portal elements
    #
    proc portlet_exists_p {portal_id portlet_name} {
        return [db_0or1row portlet_in_portal {
            select 1 from dual where exists (
              select 1
                from portal_element_map pem,
                     portal_pages pp
               where pp.portal_id = :portal_id
                 and pp.page_id = pem.page_id
                 and pem.name = :portlet_name
            )
        }]
    }
    #
    # Start the tests
    #
    aa_run_with_teardown -rollback -test_code {
        #
        # Create a community and a folder.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set community_id [dotlrn_community::new -community_type dotlrn_community -pretty_name foo]
        set folder_id [fs::new_folder -name foo -pretty_name foo -parent_id $community_id]
        if {$community_id ne ""} {
            aa_log "Community created: $community_id"
            set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
            set package_id [dotlrn::instantiate_and_mount $community_id [fs_portlet::my_package_key]]
            #
            # fs_portlet
            #
            set portlet_name [fs_portlet::get_my_name]
            #
            # Add portlet.
            #
            fs_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action "" -folder_id $folder_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            fs_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id -folder_id $folder_id
            aa_false "Portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            fs_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action "" -folder_id $folder_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # fs_contents_portlet
            #
            set portlet_name [fs_contents_portlet::get_my_name]
            #
            # Add portlet.
            #
            fs_contents_portlet::add_self_to_page -portal_id $portal_id -pretty_name foo -folder_id $folder_id -param_action ""
            aa_true "Contents portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            fs_contents_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id -folder_id $folder_id
            aa_false "Contents portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            fs_contents_portlet::add_self_to_page -portal_id $portal_id -pretty_name foo -folder_id $folder_id -param_action ""
            aa_true "Contents portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # admin_portlet
            #
            set portlet_name [fs_admin_portlet::get_my_name]
            #
            # Add portlet.
            #
            fs_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            fs_admin_portlet::remove_self_from_page $portal_id
            aa_false "Admin portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            fs_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
        } else {
            aa_error "Community creation failed"
        }
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
